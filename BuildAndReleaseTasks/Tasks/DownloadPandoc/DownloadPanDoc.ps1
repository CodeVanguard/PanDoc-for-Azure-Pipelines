# This file is part of PanDoc for Azure Pipelines,
# Copyright (C) 2025 Lukas Grützmacher
#
# PanDoc for Azure Pipelines is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as
# published by the Free Software Foundation.
#
# PanDoc for Azure Pipelines is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with PanDoc for Azure Pipelines.  If not, see <http://www.gnu.org/licenses/>.

# DownloadPandoc.ps1
# 
# Downloads, verifies and installs PanDoc

# URL of the Pandoc release file
$DownloadUrl = "https://github.com/jgm/pandoc/releases/download/3.8/pandoc-3.8-windows-x86_64.zip"

# Expected SHA256 hash
$ExpectedHash = "3c72ee9966d2a35ebb59873967e496f5fe745c15cf9e825947dc745d19b36bad"

# Local temporary download path
$DownloadPath = Join-Path $env:AGENT_TEMPDIRECTORY 'pandoc.zip'

# Target directory where pandoc.exe should be copied
$TargetDir   = Join-Path $env:AGENT_TEMPDIRECTORY 'pandoc'

Write-Host "Downloading Pandoc..."
Invoke-WebRequest -Uri $DownloadUrl -OutFile $DownloadPath

Write-Host "Verifying file hash..."
$FileHash = (Get-FileHash -Path $DownloadPath -Algorithm SHA256).Hash.ToUpper()

if ($FileHash -ne $ExpectedHash.ToUpper()) {
    Write-Error "Hash verification failed! Expected: $ExpectedHash, got: $FileHash"
    exit 1
}
Write-Host "Hash verification successful."

Write-Host "Extracting archive..."
$ExtractPath = Join-Path $env:AGENT_TEMPDIRECTORY 'pandoc_extract'
if (Test-Path $ExtractPath) { Remove-Item $ExtractPath -Recurse -Force }
Expand-Archive -Path $DownloadPath -DestinationPath $ExtractPath

Write-Host "Copying pandoc.exe to $TargetDir..."
if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir | Out-Null
}

$PandocExe = Get-ChildItem -Path $ExtractPath -Recurse -Filter "pandoc.exe" | Select-Object -First 1

if (-not $PandocExe) {
    Write-Error "pandoc.exe was not found in the archive!"
    exit 1
}

Copy-Item -Path $PandocExe.FullName -Destination $TargetDir -Force
Write-Host "Pandoc was successfully installed to $TargetDir"

Remove-Item $ExtractPath -Recurse -Force

# Add Pandoc to the PATH for subsequent tasks
Write-Host "##vso[task.prependpath]$TargetDir"

# Set output variable for the Pandoc path
Write-Host "##vso[task.setvariable variable=PanDocDownloaded]true"
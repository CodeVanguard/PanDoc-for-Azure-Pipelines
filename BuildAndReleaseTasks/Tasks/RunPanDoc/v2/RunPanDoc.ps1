# This file is part of PanDoc for Azure Pipelines,
# Copyright (C) 2020-2025 Code Vanguard LLC
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

[CmdletBinding()]

param()

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Write-Verbose 'Entering RunPanDoc.ps1'
Write-Host "Build and release tools brought to you by Code Vanguard. For more help on your build and release process, reach out to us at https://www.codevanguard.com"
Write-Host "Copyright (C) 2020-2025 Code Vanguard LLC"

# Ensure Download task ran
if ($env:PandocInstalled -ne 'true') {
    Write-Error "Please run the DownloadPanDoc task before this task."
    exit 1
}

#Get Parameters
$sourceFiles    = Get-VstsInput -Name sourceFile -Require
$inputFormat    = Get-VstsInput -Name inputFormat -Require
$outputFormat   = Get-VstsInput -Name outputFormat -Require
$destFile       = Get-VstsInput -Name destFile -Require
$additionalArgs = Get-VstsInput -Name additionalArgs -Default ""

try {
    $pandocCmd = (Get-Command 'pandoc.exe' -ErrorAction Stop).Path
}
catch {
    Write-Error "pandoc.exe not found in PATH. Ensure the DownloadPanDoc task completed successfully."
    exit 1
}

Write-Host "`n"
Write-Host "Pandoc Version Information:"
& $pandocCmd --version | Write-Host

Write-Host "`n"
Write-Host "Local variable information:"
Write-Host "SourceFile(s): `t`t$sourceFiles"
Write-Host "InputFormat: `t`t$inputFormat"
Write-Host "OutputFormat: `t`t$outputFormat"
Write-Host "DestinationFile: `t$destFile"
Write-Host "Additional Arguments: `t$additionalArgs"

$commandArgs = "-f $inputFormat -t $outputFormat -o $destFile $sourceFiles $additionalArgs"
Start-Process -FilePath "pandoc.exe" -ArgumentList $commandArgs -NoNewWindow -Wait

Write-Verbose 'Leaving RunPanDoc.ps1'

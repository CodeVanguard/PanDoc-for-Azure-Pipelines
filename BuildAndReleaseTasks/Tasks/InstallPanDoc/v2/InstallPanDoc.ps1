# This file is part of PanDoc for Azure Pipelines,
# Copyright (C) 2025 Code Vanguard
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

# InstallPandoc.ps1
#
# Installs PanDoc

Write-Host "Installing Pandoc..."

$targetVersion = Get-VstsInput -Name version -Default ""

# Build a single argument list and invoke choco once
$chocoArgs = @('install', 'pandoc', '-y', '--no-progress', '--limit-output')

if ($targetVersion -ne "") {
    Write-Host "Installing specified Pandoc version: $targetVersion"
    $chocoArgs += @('--version', $targetVersion)
}
else {
    Write-Host "No specific version provided. Installing latest Pandoc version."
}

# Single invocation to avoid duplication
& choco @chocoArgs

# Set output variable for the Pandoc path
Write-Host "##vso[task.setvariable variable=PandocInstalled]true"
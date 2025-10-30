# This file is part of PanDoc for Azure Pipelines,
# Copyright (C) 2020-2022 Code Vanguard LLC
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

$ErrorActionPreference = "Stop"

Write-Verbose 'Entering RunPanDoc.ps1'

Write-Host "Build and release tools brought to you by Code Vanguard. For more help on your build and release process, reach out to us at https://www.codevanguard.com"
Write-Host "Copyright (C) 2020-2022 Code Vanguard LLC"

#Get Parameters
$sourceFiles = Get-VstsInput -Name sourceFile -Require
$inputFormat = Get-VstsInput -Name inputFormat -Require
$outputFormat = Get-VstsInput -Name outputFormat -Require
$destFile = Get-VstsInput -Name destFile -Require

Write-Host "`n"
Write-Host "Pandoc Version Information:"
. $PSScriptRoot\Lib\Pandoc\pandoc.exe -v

Write-Host "`n"
Write-Host "Local variable information:"
Write-Host "SourceFile(s): `t`t$sourceFiles"
Write-Host "InputFormat: `t`t$inputFormat"
Write-Host "OutputFormat: `t`t$outputFormat"
Write-Host "DesinationFile: `t$destFile"

$commandArgs = "-f $inputFormat -t $outputFormat -o $destFile $sourceFiles"
Start-Process -FilePath "$PSScriptRoot\Lib\Pandoc\pandoc.exe" -ArgumentList $commandArgs -NoNewWindow -Wait

Write-Verbose 'Leaving RunPanDoc.ps1'

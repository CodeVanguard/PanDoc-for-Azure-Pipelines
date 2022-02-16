# This file is part of PanDoc for Azure Pipelines,
# Copyright (C) 2020-2022 Code Vanguard LLC

[CmdletBinding()]

param()

$ErrorActionPreference = "Stop"

Write-Verbose 'Entering RunPanDoc.ps1'

Write-Host "Build and release tools brought to you by Code Vanguard. For more help on your build and release process, reach out to us at https://www.codevanguard.com"

#Get Parameters
$sourceFile = Get-VstsInput -Name sourceFile -Require
$inputFormat = Get-VstsInput -Name inputFormat -Require
$outputFormat = Get-VstsInput -Name outputFormat -Require
$destFile = Get-VstsInput -Name destFile -Require

Write-Host "Pandoc Version Information:\r\n"
. $PSScriptRoot\..\Utilities\PrintPanDocVersion.ps1

Write-Host "\r\nLocal variable information:\r\n"
Write-Host "SourceFile  = `t$sourceFile"
Write-Host "InputFormat  = `t$inputFormat"
Write-Host "OutputFormat  = `t$outputFormat"
Write-Host "DesinationFile   = `t$destFile"

. $PSScriptRoot\Lib\Pandoc\pandoc.exe -f $inputFormat -t $outputFormat -o $destFile $sourceFile

Write-Verbose 'Leaving RunPanDoc.ps1'
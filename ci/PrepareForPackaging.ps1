# This file is part of PanDoc for Azure Pipelines,
# Copyright (C) 2020-2022 Code Vanguard LLC

#
# PrepareForPackaging.ps1
# 
# Prepares project for packaging
#

$ErrorActionPreference = "Stop"

#Script Location
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
Write-Host "Script Path: $scriptPath"

Write-Host "Calling AddVstsTaskSdk.ps1"
. "$scriptPath/AddVstsTaskSdk.ps1"

Write-Host "Calling CopyVstsLibToTasks.ps1"
. "$scriptPath/CopyVstsLibToTasks.ps1"

Write-Host "Calling CopyIconToTasks.ps1"
. "$scriptPath/CopyIconToTasks.ps1"
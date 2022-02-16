# This file is part of PanDoc for Azure Pipelines,
# Copyright (C) 2020-2022 Code Vanguard LLC

#
# CopyVstsLibToTasks.ps1
# 
# Copies the VstsTaskSdk to each task
#

$ErrorActionPreference = "Stop"

Write-Host "Moving VSTSTaskLib to tasks"

#Script Location
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
Write-Host "Script Path: $scriptPath"

$tasks = Get-ChildItem $scriptPath\..\BuildAndReleaseTasks\Tasks -directory

foreach ($task in $tasks) {
  $path = "$scriptPath\..\BuildAndReleaseTasks\Tasks\$task\ps_modules"
  If (!(test-path $path)) {
    New-Item -ItemType Directory -Force -Path $path
  }

  $path = "$scriptPath\..\BuildAndReleaseTasks\Tasks\$task\ps_modules\VstsTaskSdk"
  If (!(test-path $path)) {
    New-Item -ItemType Directory -Force -Path $path
  }

  Copy-Item -Path $scriptPath\..\BuildAndReleaseTasks\Lib\VstsTaskSdk\0.11.0\*.* -Destination "$path" -Force
}
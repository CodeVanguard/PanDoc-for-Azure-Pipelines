# This file is part of PanDoc for Azure Pipelines,
# Copyright (C) 2020-2022 Code Vanguard LLC

#
# CopyIconToTasks.ps1
# 
# Copies the icon.png to each task
#

$ErrorActionPreference = "Stop"

Write-Host "Moving VSTSTaskLib to tasks"

#Script Location
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
Write-Host "Script Path: $scriptPath"

$tasks = Get-ChildItem $scriptPath\..\BuildAndReleaseTasks\Tasks -directory

foreach ($task in $tasks) {
  $path = "$scriptPath\..\BuildAndReleaseTasks\Tasks\$task\icon.png"
  If ((test-path $path)) {
    Remove-Item $path -Force
  }

  Copy-Item -Path "$scriptPath\..\icon.png" -Destination "$path" -Force
}
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

# CopyVstsLibToTasks.ps1
# 
# Copies the VstsTaskSdk to each task
#

$ErrorActionPreference = "Stop"

Write-Host "Moving VSTSTaskLib to tasks"

#Script Location
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
Write-Host "Script Path: $scriptPath"

$tasksRoot = Join-Path $scriptPath '..\..\BuildAndReleaseTasks\Tasks'
$tasks = Get-ChildItem -Path $tasksRoot -Directory
$vstsLibSource = Join-Path $scriptPath '..\..\BuildAndReleaseTasks\Lib\VstsTaskSdk\*\*.*'

foreach ($task in $tasks) {
    # Check for versioned child folders (e.g., v1, v2) by presence of task.json
    $childDirs = Get-ChildItem -Path $task.FullName -Directory -ErrorAction SilentlyContinue

    $versionDirs = @()
    foreach ($child in $childDirs) {
        if (Test-Path (Join-Path $child.FullName 'task.json')) {
            $versionDirs += $child 
        }
    }

    $targets = @()
    if ($versionDirs.Count -gt 0) {
        $targets = $versionDirs
    }
    else {
        $targets = @($task)
    }

    foreach ($target in $targets) {
        $psModulesPath = Join-Path $target.FullName 'ps_modules'
        if (!(Test-Path $psModulesPath)) { 
            New-Item -ItemType Directory -Force -Path $psModulesPath | Out-Null 
        }

        $sdkDestPath = Join-Path $psModulesPath 'VstsTaskSdk'
        if (!(Test-Path $sdkDestPath)) {
            New-Item -ItemType Directory -Force -Path $sdkDestPath | Out-Null 
        }

        Copy-Item -Path $vstsLibSource -Destination $sdkDestPath -Force
        Write-Host "Copied VstsTaskSdk to $sdkDestPath"
    }
}
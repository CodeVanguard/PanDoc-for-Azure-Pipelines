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

# CopyIconToTasks.ps1
# 
# Copies the icon.png to each task
#

$ErrorActionPreference = "Stop"

Write-Host "Copying icon.png to tasks (handles versioned task folders)"

# Script Location
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
Write-Host "Script Path: $scriptPath"

$tasksRoot = Join-Path $scriptPath '..\BuildAndReleaseTasks\Tasks'
$tasks = Get-ChildItem -Path $tasksRoot -Directory
$iconSource = Join-Path $scriptPath '..\icon.png'

foreach ($task in $tasks) {
    # Detect versioned subfolders by presence of task.json
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
        $destIcon = Join-Path $target.FullName 'icon.png'
        if (Test-Path $destIcon) {
            Remove-Item $destIcon -Force
        }
        
        Copy-Item -Path $iconSource -Destination $destIcon -Force
        Write-Host "Copied icon to $destIcon"
    }
}
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
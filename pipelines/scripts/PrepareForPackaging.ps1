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

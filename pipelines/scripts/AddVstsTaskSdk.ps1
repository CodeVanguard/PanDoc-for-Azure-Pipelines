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

# AddVstsTaskSdk.ps1
# 
# Adds Vsts Task PowerShell Sdk
#

$ErrorActionPreference = "Stop"

Write-Host "Adding Vsts Task PowerShell Sdk"

# Script Location
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
Write-Host "Script Path: $scriptPath"

$LibLocation = "$scriptPath/../../BuildAndReleaseTasks/Lib"
Write-Verbose "Installing SDK to $LibLocation"

If ((test-path $LibLocation)) {
    Write-Verbose "$LibLocation already exists. Removing for a clean installation"
    Remove-Item $LibLocation -Force -Recurse
}

mkdir -Path $LibLocation

Write-Verbose "Installing VstsTaskSdk"
Save-Module -Name VstsTaskSdk -Path $LibLocation
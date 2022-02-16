# This file is part of PanDoc for Azure Pipelines,
# Copyright (C) 2020-2022 Code Vanguard LLC

#
# AddVstsTaskSdk.ps1
# 
# Adds Vsts Task PowerShell Sdk
#

$ErrorActionPreference = "Stop"

Write-Host "Adding Vsts Task PowerShell Sdk"

#Script Location
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
Write-Host "Script Path: $scriptPath"

$LibLocation = "$scriptPath/../BuildAndReleaseTasks/Lib"
Write-Verbose "Installing SDK to $LibLocation"

If ((test-path $LibLocation)) {
  Write-Verbose "$LibLocation already exists. Removing for a clean installation"
  Remove-Item $LibLocation -Force -Recurse
}

mkdir -Path $LibLocation

Write-Verbose "Installing VstsTaskSdk"
Save-Module -Name VstsTaskSdk -Path $LibLocation
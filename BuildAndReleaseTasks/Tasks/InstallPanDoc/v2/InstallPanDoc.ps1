# This file is part of PanDoc for Azure Pipelines,
# Copyright (C) 2025 Code Vanguard
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

# InstallPandoc.ps1
#
# Installs PanDoc

Write-Host "Installing Pandoc..."

# Reduce noisy console output from Chocolatey in CI logs
#  - --no-progress hides the percentage bars
#  - --limit-output (-r) limits output to essentials
# NOTE: Avoid using global feature toggles to keep agent state clean
choco install pandoc -y --no-progress --limit-output

# Set output variable for the Pandoc path
Write-Host "##vso[task.setvariable variable=PandocInstalled]true"
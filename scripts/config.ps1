# Minecraft Resource Pack Configuration
# This file contains all configurable settings for the resource pack build system

# These variables are used in scripts that dot-source this file
# Using individual suppression comments for each variable

# Script paths
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptRoot

# Directory settings
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
$SourceDir = "$ProjectRoot\src"
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
$DistDir = "$ProjectRoot\dist"

# Resource pack settings
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
$DefaultPackName = "EisbaersBase"
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
$DefaultVersion = "0.0.1"  # Update this when releasing a new version
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
$MaxPreviousBuilds = 2  # Maximum number of previous builds to keep per version

# Minecraft settings
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
$DefaultMinecraftPath = "$env:APPDATA\PrismLauncher\instances\1.21.9 Fabric Plain\minecraft\resourcepacks"

# Console output colors
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
$ColorInfo = "Cyan"
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
$ColorSuccess = "Green"
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
$ColorWarning = "Yellow"
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
$ColorError = "Red"

# Common functions
function Write-ColorOutput {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

function Get-FormattedDateTime {
    return (Get-Date -Format "yyyy-MM-dd_HHmmss")
}

# This file is dot-sourced by other scripts
# No need for Export-ModuleMember as this is not a module

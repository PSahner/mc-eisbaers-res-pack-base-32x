# Minecraft Resource Pack Build and Copy Script
# Description: Builds and copies the resource pack to Minecraft using the build.ps1 and export.ps1 scripts

param(
    [string]$Version = "",
    [string]$PackName = "",
    [string]$MinecraftPath = "",
    [switch]$Help,
    [switch]$Quiet
)

# Import configuration
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptRoot\config.ps1"

# Script files check
if (!(Test-Path -Path "$ScriptRoot\build.ps1") -or !(Test-Path -Path "$ScriptRoot\export.ps1")) {
    Write-ColorOutput "Warning: Required script files not found!" $ColorWarning
    Write-ColorOutput "This script requires both 'build.ps1' and 'export.ps1' to be in the same directory." $ColorWarning
    exit 1
}

function Show-Help {
    Write-ColorOutput "Minecraft Resource Pack Build and Copy Script" $ColorInfo
    Write-ColorOutput "=============================================" $ColorInfo
    Write-ColorOutput ""
    Write-ColorOutput "Usage:" $ColorInfo
    Write-ColorOutput "  .\scripts\buildAndExport.ps1 [-Version <version>] [-PackName <name>] [-MinecraftPath <path>] [-Quiet] [-Help]"
    Write-ColorOutput ""
    Write-ColorOutput "Parameters:" $ColorInfo
    Write-ColorOutput "  -Version        Specify the version number (default from config.ps1)"
    Write-ColorOutput "  -PackName       Specify the resource pack name (default from config.ps1)"
    Write-ColorOutput "  -MinecraftPath  Specify the Minecraft resourcepacks folder (default from config.ps1)"
    Write-ColorOutput "  -Quiet          Run in non-interactive mode (skips all confirmation prompts)"
    Write-ColorOutput "  -Help           Show this help message"
    Write-ColorOutput ""
    Write-ColorOutput "Examples:" $ColorInfo
    Write-ColorOutput "  .\scripts\buildAndExport.ps1 -Version '1.2.0'"
    Write-ColorOutput "  .\scripts\buildAndExport.ps1 -Version '2.0.0' -PackName 'MyFaithfulPack'"
    Write-ColorOutput "  .\scripts\buildAndExport.ps1 -Quiet -MinecraftPath 'D:\Games\Minecraft\resourcepacks'"
    Write-ColorOutput ""
    exit 0
}

# Show help if requested
if ($Help) {
    Show-Help
}

Write-ColorOutput ""
Write-ColorOutput "STEP 1: Building Resource Pack" $ColorInfo
Write-ColorOutput "==============================" $ColorInfo

# Build parameters - use a hashtable for splatting
$buildParams = @{}
if (-not [string]::IsNullOrEmpty($Version)) {
    $buildParams["Version"] = $Version
}
if (-not [string]::IsNullOrEmpty($PackName)) {
    $buildParams["PackName"] = $PackName
}
if ($Quiet) {
    $buildParams["Quiet"] = $true
}

# Debug what parameters we're passing
Write-ColorOutput "Debug: Passing parameters to build.ps1:" $ColorInfo
foreach ($key in $buildParams.Keys) {
    Write-ColorOutput "  $key = $($buildParams[$key])" $ColorInfo
}

# Call the build script with parameters
try {
    & "$ScriptRoot\build.ps1" @buildParams
    
    if ($LASTEXITCODE -ne 0) {
        Write-ColorOutput "Build process failed with exit code $LASTEXITCODE" $ColorError
        exit $LASTEXITCODE
    }
} catch {
    Write-ColorOutput "Error while running build script: $_" $ColorError
    exit 1
}

Write-ColorOutput ""
Write-ColorOutput "STEP 2: Copying to Minecraft" $ColorInfo
Write-ColorOutput "============================" $ColorInfo

# Set default pack name if not provided
if ([string]::IsNullOrEmpty($PackName)) {
    $PackName = $DefaultPackName
    Write-ColorOutput "Using default pack name: $PackName" $ColorInfo
}

# Set default Minecraft path if none provided
if ([string]::IsNullOrEmpty($MinecraftPath)) {
    $MinecraftPath = $DefaultMinecraftPath
    Write-ColorOutput "Using default Minecraft resourcepacks path: $MinecraftPath" $ColorInfo
}

# Copy parameters - use a hashtable for splatting
$copyParams = @{}
if (-not [string]::IsNullOrEmpty($PackName)) {
    $copyParams["PackName"] = $PackName
}
if (-not [string]::IsNullOrEmpty($MinecraftPath)) {
    $copyParams["MinecraftPath"] = $MinecraftPath
}
if ($Quiet) {
    $copyParams["Quiet"] = $true
}

# Debug what parameters we're passing
Write-ColorOutput "Debug: Passing parameters to export.ps1:" $ColorInfo
foreach ($key in $copyParams.Keys) {
    Write-ColorOutput "  $key = $($copyParams[$key])" $ColorInfo
}

# Call the copy script with parameters
try {
    & "$ScriptRoot\export.ps1" @copyParams
    
    if ($LASTEXITCODE -ne 0) {
        Write-ColorOutput "Copy process failed with exit code $LASTEXITCODE" $ColorError
        exit $LASTEXITCODE
    }
} catch {
    Write-ColorOutput "Error while running copy script: $_" $ColorError
    exit 1
}

Write-ColorOutput ""
Write-ColorOutput "======================================" $ColorSuccess
Write-ColorOutput "|| Build and Copy Process Complete! ||" $ColorSuccess
Write-ColorOutput "======================================" $ColorSuccess

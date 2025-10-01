# Minecraft Resource Pack Copy Script
# Description: Copies the latest built resource pack to the Minecraft resourcepacks folder

param(
    [string]$PackName = "",
    [string]$MinecraftPath = "",
    [switch]$Help,
    [switch]$Quiet
)

# Import configuration
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptRoot\config.ps1"

# Show help information
function Show-Help {
    Write-ColorOutput "Minecraft Resource Pack Copy Script" $ColorInfo
    Write-ColorOutput "===================================" $ColorInfo
    Write-ColorOutput ""
    Write-ColorOutput "Usage:" $ColorInfo
    Write-ColorOutput "  .\scripts\export.ps1 [-PackName <name>] [-MinecraftPath <path>] [-Quiet] [-Help]"
    Write-ColorOutput ""
    Write-ColorOutput "Parameters:" $ColorInfo
    Write-ColorOutput "  -PackName       Specify the resource pack name (default from config.ps1)"
    Write-ColorOutput "  -MinecraftPath  Specify the Minecraft resourcepacks folder (default from config.ps1)"
    Write-ColorOutput "  -Quiet          Run in non-interactive mode (skips confirmation prompts)"
    Write-ColorOutput "  -Help           Show this help message"
    Write-ColorOutput ""
    Write-ColorOutput "Examples:" $ColorInfo
    Write-ColorOutput "  .\scripts\export.ps1"
    Write-ColorOutput "  .\scripts\export.ps1 -PackName 'MyFaithfulPack'"
    Write-ColorOutput "  .\scripts\export.ps1 -MinecraftPath 'D:\Games\Minecraft\resourcepacks'"
    Write-ColorOutput "  .\scripts\export.ps1 -Quiet -PackName 'MyFaithfulPack'"
    Write-ColorOutput ""
    Write-ColorOutput "Default Export Path: $DefaultMinecraftPath" $ColorInfo
    Write-ColorOutput ""
    exit 0
}

# Show help if requested
if ($Help) {
    Show-Help
}

# Set default pack name if not provided
if ([string]::IsNullOrEmpty($PackName)) {
    $PackName = $DefaultPackName
    Write-ColorOutput "Using default pack name: $PackName" $ColorInfo
} else {
    Write-ColorOutput "Using specified pack name: $PackName" $ColorInfo
}

# Get the Minecraft path
if ([string]::IsNullOrEmpty($MinecraftPath)) {
    $MinecraftPath = $DefaultMinecraftPath
    Write-ColorOutput "Using default Minecraft resourcepacks path: $MinecraftPath" $ColorInfo
} else {
    Write-ColorOutput "Using specified Minecraft resourcepacks path: $MinecraftPath" $ColorInfo
}

# Check if Minecraft resourcepacks directory exists
if (!(Test-Path -Path $MinecraftPath)) {
    Write-ColorOutput "Error: Minecraft resourcepacks directory not found at: $MinecraftPath" $ColorError
    Write-ColorOutput "Please specify the correct path using the -MinecraftPath parameter" $ColorWarning
    exit 1
}

# Check if dist directory exists
if (!(Test-Path -Path $DistDir)) {
    Write-ColorOutput "Error: $DistDir directory not found. Please run the build script first." $ColorError
    exit 1
}

# Find the latest resource pack zip file
$latestPack = Get-ChildItem -Path $DistDir -Filter "$PackName*.zip" | 
              Sort-Object LastWriteTime -Descending | 
              Select-Object -First 1

if ($null -eq $latestPack) {
    Write-ColorOutput "Error: No resource pack found in the $DistDir directory for '$PackName'" $ColorError
    Write-ColorOutput "Please run the build script first." $ColorWarning
    exit 1
}

Write-ColorOutput ""
Write-ColorOutput "Resource Pack Copy" $ColorInfo
Write-ColorOutput "------------------" $ColorInfo
Write-ColorOutput "Found latest resource pack: $($latestPack.Name)" $ColorInfo
Write-ColorOutput "Source: $($latestPack.FullName)" $ColorInfo
Write-ColorOutput "Destination: $MinecraftPath" $ColorInfo

# Prompt for confirmation unless in quiet mode
$proceed = $true
if (-not $Quiet) {
    Write-ColorOutput ""
    Write-ColorOutput "Ready to Copy Resource Pack" $ColorWarning
    Write-ColorOutput "---------------------------" $ColorWarning
    Write-ColorOutput "The resource pack will be copied to:" 
    Write-ColorOutput "$MinecraftPath\$($latestPack.Name)" $ColorInfo
    Write-ColorOutput ""
    Write-Host "Do you want to proceed? [Y/n]: " -NoNewline -ForegroundColor $ColorWarning
    
    $userResponse = Read-Host
    if ($userResponse -and $userResponse.Trim().ToLower() -eq 'n') {
        Write-ColorOutput "Copy operation cancelled by user." $ColorWarning
        $proceed = $false
    }
}

# Copy the resource pack to the Minecraft resourcepacks folder if confirmed
if ($proceed) {
    try {
        Copy-Item -Path $latestPack.FullName -Destination "$MinecraftPath\$($latestPack.Name)" -Force
        Write-ColorOutput ""
        Write-ColorOutput "--------------------" $ColorSuccess
        Write-ColorOutput "| Copy Successful! |" $ColorSuccess
        Write-ColorOutput "--------------------" $ColorSuccess
        Write-ColorOutput "Resource pack has been copied to Minecraft resourcepacks folder" $ColorSuccess
        Write-ColorOutput "Pack: $($latestPack.Name)" $ColorSuccess
        Write-ColorOutput "Location: $MinecraftPath\$($latestPack.Name)" $ColorSuccess
        Write-ColorOutput "Size: $([math]::Round($latestPack.Length / 1KB, 2)) KB" $ColorInfo
        exit 0
    } catch {
        Write-ColorOutput ""
        Write-ColorOutput "----------------" $ColorError
        Write-ColorOutput "| Copy Failed! |" $ColorError
        Write-ColorOutput "----------------" $ColorError
        Write-ColorOutput "Unable to copy resource pack to Minecraft folder." $ColorError
        Write-ColorOutput "Error: $_" $ColorError
        exit 1
    }
}

# If we get here, the user canceled the operation
if (-not $proceed) {
    exit 0
}

# Minecraft Resource Pack Build Script
# Description: Automated build script for Eisbaer's ResPack

param(
    [string]$Version = "",
    [string]$PackName = "",
    [switch]$Help,
    [switch]$Quiet
)

# Import configuration
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptRoot\config.ps1"

function Show-Help {
    Write-ColorOutput "Minecraft Resource Pack Build Script" $ColorInfo
    Write-ColorOutput "====================================" $ColorInfo
    Write-ColorOutput ""
    Write-ColorOutput "Usage:" $ColorInfo
    Write-ColorOutput "  .\scripts\build.ps1 [-Version <version>] [-PackName <name>] [-Quiet] [-Help]"
    Write-ColorOutput ""
    Write-ColorOutput "Parameters:" $ColorInfo
    Write-ColorOutput "  -Version    Specify the version number (default from config.ps1)"
    Write-ColorOutput "  -PackName   Specify the resource pack name (default from config.ps1)"
    Write-ColorOutput "  -Quiet      Run in non-interactive mode (skips prompts, uses defaults)"
    Write-ColorOutput "  -Help       Show this help message"
    Write-ColorOutput ""
    Write-ColorOutput "Examples:" $ColorInfo
    Write-ColorOutput "  .\scripts\build.ps1 -Version '1.2.0'"
    Write-ColorOutput "  .\scripts\build.ps1 -Version '2.0.0' -PackName 'MyFaithfulPack'"
    Write-ColorOutput "  .\scripts\build.ps1 -Quiet"
    Write-ColorOutput ""
    exit 0
}

# Show help if requested
if ($Help) {
    Show-Help
} else {
  Write-ColorOutput "Minecraft Resource Pack Build Script" $ColorInfo
  Write-ColorOutput "====================================" $ColorInfo
}

# Create dist directory if it doesn't exist
if (!(Test-Path -Path $DistDir)) {
    New-Item -ItemType Directory -Path $DistDir | Out-Null
    Write-ColorOutput "Created $DistDir directory" $ColorSuccess
}

# Set default pack name if not provided
if ([string]::IsNullOrEmpty($PackName)) {
    $PackName = $DefaultPackName
    Write-ColorOutput "Using default pack name: $PackName" $ColorInfo
} else {
    Write-ColorOutput "Using specified pack name: $PackName" $ColorSuccess
}

# Get version from user input if not provided as parameter
if ([string]::IsNullOrEmpty($Version)) {
    # In quiet mode, use default version without prompting
    if ($Quiet) {
        $Version = $DefaultVersion
        Write-ColorOutput "Using default version: $Version" $ColorInfo
    } else {
        Write-ColorOutput ""
        Write-ColorOutput "Version Input Required" $ColorWarning
        Write-ColorOutput "----------------------" $ColorWarning
        Write-ColorOutput "Please enter a version number for this build."
        Write-ColorOutput "Press Enter to use default version ($DefaultVersion)" $ColorInfo
        Write-Host "Version: " -NoNewline -ForegroundColor $ColorInfo
        
        $userInput = Read-Host
        
        if ([string]::IsNullOrWhiteSpace($userInput)) {
            $Version = $DefaultVersion
            Write-ColorOutput "Using default version: $Version" $ColorInfo
        } else {
            $Version = $userInput.Trim()
            Write-ColorOutput "Using version: $Version" $ColorSuccess
        }
    }
} else {
    Write-ColorOutput "Using specified version: $Version" $ColorSuccess
}

# Build preparation
Write-ColorOutput ""
Write-ColorOutput "Build Preparation" $ColorInfo
Write-ColorOutput "-----------------" $ColorInfo

# Define the resource pack file name
$timestamp = Get-FormattedDateTime
$zipFileName = "${PackName}_v$Version.zip"
$zipFilePath = "$DistDir\$zipFileName"

# Check if any older versions exist and manage them (keep max $MaxPreviousBuilds previous builds)
# Use a more precise filter that ensures we're only getting files with EXACTLY this package name
# The regex pattern will match PackName_vVersion.zip or PackName_vVersion_timestamp.zip
$filePattern = "^${PackName}_v${Version}(_.+)?\.zip$"
$existingFiles = Get-ChildItem -Path $DistDir -File | Where-Object { $_.Name -match $filePattern } | Sort-Object LastWriteTime

if ($existingFiles.Count -gt 0) {
    Write-ColorOutput "Found $($existingFiles.Count) previous build(s) for version $Version of $PackName" $ColorInfo
    
    # Separate non-timestamped and timestamped files
    $nonTimestampedFile = $existingFiles | Where-Object { $_.Name -eq $zipFileName }
    $timestampedFiles = $existingFiles | Where-Object { $_.Name -ne $zipFileName } | Sort-Object LastWriteTime
    
    # If we have a non-timestamped file, add a timestamp to it
    if ($nonTimestampedFile) {
        $newName = "${PackName}_v${Version}_${timestamp}.zip"
        Write-ColorOutput "Adding timestamp to current version: $newName" $ColorInfo
        Rename-Item -Path $nonTimestampedFile.FullName -NewName $newName
        
        # Add this newly timestamped file to our collection of timestamped files
        $timestampedFiles = @(Get-Item "$DistDir\$newName") + $timestampedFiles
    }
    
    # If we have more timestamped files than (MaxPreviousBuilds-1), delete the oldest ones
    # We use MaxPreviousBuilds-1 because we want to keep that many timestamped files plus 1 non-timestamped file
    if ($timestampedFiles.Count -gt ($MaxPreviousBuilds - 1)) {
        Write-ColorOutput "Too many timestamped builds ($($timestampedFiles.Count)), keeping only $($MaxPreviousBuilds-1)" $ColorInfo
        
        # Calculate how many to delete (all except the newest (MaxPreviousBuilds-1))
        $deleteCount = $timestampedFiles.Count - ($MaxPreviousBuilds - 1)
        $filesToDelete = $timestampedFiles | Select-Object -First $deleteCount
        
        foreach ($file in $filesToDelete) {
            Write-ColorOutput "Removing old build: $($file.Name)" $ColorWarning
            Remove-Item $file.FullName -Force
        }
    }
}

# Create the resource pack zip
Write-ColorOutput "" 
Write-ColorOutput "Building Resource Pack" $ColorInfo
Write-ColorOutput "----------------------" $ColorInfo
Write-ColorOutput "Version: $Version" $ColorInfo
Write-ColorOutput "Pack name: $PackName" $ColorInfo
Write-ColorOutput "Building package..." $ColorInfo

# Use 7-Zip for creating Minecraft-compatible zip files
try {
    # Find 7-Zip executable in common installation paths
    $7zipPath = $null
    $possiblePaths = @(
        "${env:ProgramFiles}\7-Zip\7z.exe",
        "${env:ProgramFiles(x86)}\7-Zip\7z.exe",
        "${env:ProgramW6432}\7-Zip\7z.exe"
    )
        
    foreach ($path in $possiblePaths) {
        if (Test-Path -Path $path) {
            $7zipPath = $path
            break
        }
    }
    
    # Ensure 7-Zip is found
    if (-not $7zipPath) {
        throw "7-Zip executable not found. Please ensure 7-Zip is installed."
    }
    
    # If file exists, remove it first
    if (Test-Path $zipFilePath) {
        Remove-Item $zipFilePath -Force
    }
    
    Write-ColorOutput "Using 7-Zip for compression..." $ColorInfo
    
    # Remember current directory
    $currentDir = Get-Location
    
    # Change to source directory to ensure proper paths in zip
    Set-Location $SourceDir
    
    # Use 7-Zip to create a compatible zip using store method (no compression)
    # a = add files to archive
    # -tzip = specify zip format
    # -mx=0 = no compression (store only)
    # -r = recursive, include all subfolders
    & $7zipPath a -tzip -mx=0 -r $zipFilePath "*" | Out-Null
    
    # Return to original directory
    Set-Location $currentDir
} catch {
    Write-ColorOutput "Error creating archive: $_" $ColorError
    exit 1
}

if (Test-Path -Path $zipFilePath) {
    Write-ColorOutput "" 
    Write-ColorOutput "---------------------" $ColorSuccess
    Write-ColorOutput "| Build Successful! |" $ColorSuccess
    Write-ColorOutput "---------------------" $ColorSuccess
    Write-ColorOutput "Resource pack: $zipFileName" $ColorSuccess
    Write-ColorOutput "Location: $((Get-Item $zipFilePath).FullName)" $ColorSuccess
    Write-ColorOutput "File size: $([math]::Round((Get-Item $zipFilePath).Length / 1KB, 2)) KB" $ColorInfo
    Write-ColorOutput "Created at: $(Get-Date)" $ColorInfo
    exit 0
} else {
    Write-ColorOutput "" 
    Write-ColorOutput "-----------------" $ColorError
    Write-ColorOutput "| Build Failed! |" $ColorError
    Write-ColorOutput "-----------------" $ColorError
    Write-ColorOutput "Unable to create resource pack file." $ColorError
    exit 1
}

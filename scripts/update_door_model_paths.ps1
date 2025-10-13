# Update Door and Trapdoor Model Paths Script (V2)
# This script automatically updates model paths in blockstate files by checking if a corresponding 
# custom model exists in the f1_2_09_inner_edges_for_doors directory
# Features:
# - Preserves original JSON formatting
# - Creates backups of original files
# - Uses hashtables for faster lookups
# - Logs all operations to a log file

# Get the base directory for the project
# Explicitly setting the base directory to ensure correct path resolution
$baseDir = "F:\Repos\mc-eisbaers-res-pack-base-32x"

# Define paths
$blockstatesDir = Join-Path $baseDir "src\assets\minecraft\blockstates"
$customModelsDir = Join-Path $baseDir "src\assets\f1_2_09_inner_edges_for_doors\models\block"
$backupDir = Join-Path $PSScriptRoot "blockstates_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"

# Create a log file
$logFile = Join-Path $PSScriptRoot "update_model_paths_log.txt"
$null = New-Item -Path $logFile -ItemType File -Force

# Create backup directory if needed
if (-not (Test-Path -Path $backupDir)) {
    $null = New-Item -Path $backupDir -ItemType Directory -Force
    Write-Host "Created backup directory: $backupDir"
}

function Write-Log {
    param (
        [string]$message,
        [string]$color = "White"
    )
    
    # Write to console
    Write-Host $message -ForegroundColor $color
    
    # Write to log file
    Add-Content -Path $logFile -Value $message
}

Write-Log "Starting model path update process at $(Get-Date)" "Cyan"
Write-Log "=================================================" "Cyan"

# Get all the blockstate files that are related to doors and trapdoors
$blockstateFiles = Get-ChildItem -Path $blockstatesDir -Filter "*_door.json" 
$blockstateFiles += Get-ChildItem -Path $blockstatesDir -Filter "*_trapdoor.json"

Write-Log "Found $($blockstateFiles.Count) blockstate files to process"

# Build a hashtable of all available custom models for faster lookup
$customModels = @{}
$customModelCount = 0

Get-ChildItem -Path $customModelsDir -Filter "*.json" | ForEach-Object {
    $modelName = $_.BaseName
    $customModels[$modelName] = $true
    $customModelCount++
}

Write-Log "Found $customModelCount custom models available"

# Function to check if a custom model exists - using approved verb "Test"
function Test-CustomModel {
    param (
        [string]$modelName
    )
    
    return $customModels.ContainsKey($modelName)
}

# Function to update model references in a JSON file
function Update-ModelPaths {
    param (
        [string]$filePath
    )
    
    $fileName = Split-Path -Leaf $filePath
    Write-Log "Processing $fileName..." "Cyan"
    
    # Read the JSON file content
    $content = Get-Content -Path $filePath -Raw
    
    # Create a backup of the original file
    $backupPath = Join-Path $backupDir $fileName
    Copy-Item -Path $filePath -Destination $backupPath
    Write-Log "Created backup at $backupPath"
    
    # Rather than using ConvertFrom-Json which can alter formatting, we'll use regex to find and replace
    # model paths while preserving the original file's formatting
    
    # Initialize counters
    $replacements = 0
    $patternMatches = 0
    
    # Match model references in the format: "model": "minecraft:block/something"
    # Use single quotes to make the regex pattern more reliable
    $pattern = '("model"\s*:\s*"minecraft:block/)([^"]+)(")'
    
    
    # Create counters that can be accessed from within the script block
    $script:matchCounter = 0
    $script:replacementCounter = 0
    
    $updatedContent = [regex]::Replace($content, $pattern, {
        param($match)
        $script:matchCounter++
        
        # Extract the model name using the new grouping
        $prefix = $match.Groups[1].Value
        $modelName = $match.Groups[2].Value
        $suffix = $match.Groups[3].Value
        
        # Check if a custom model exists
        $customModelExists = Test-CustomModel $modelName
        
        if ($customModelExists) {
            $script:replacementCounter++
            $newModelPath = "$prefix$modelName$suffix".Replace("minecraft:block", "f1_2_09_inner_edges_for_doors:block")
            Write-Log "  Updating: $prefix$modelName$suffix -> $newModelPath" "DarkGray"
            return $newModelPath
        } else {
            # Return the original if no custom model exists
            return "$prefix$modelName$suffix"
        }
    })
    
    # Update counters from the script block
    $patternMatches = $script:matchCounter
    $replacements = $script:replacementCounter
    
    # Only write back if changes were made
    if ($replacements -gt 0) {
        Set-Content -Path $filePath -Value $updatedContent -NoNewline
        Write-Log "Updated $replacements model paths in $fileName (out of $patternMatches matches)" "Green"
        return $true
    } else {
        Write-Log "No changes needed for $fileName (checked $patternMatches paths)" "Yellow"
        return $false
    }
}

# Process all blockstate files
$updatedCount = 0
foreach ($file in $blockstateFiles) {
    $updated = Update-ModelPaths -filePath $file.FullName
    if ($updated) {
        $updatedCount++
    }
}

Write-Log "=================================================" "Cyan"
Write-Log "Process completed at $(Get-Date)" "Cyan"
Write-Log "Updated $updatedCount out of $($blockstateFiles.Count) blockstate files" "Cyan"
Write-Log "Log saved to $logFile" "Cyan"
Write-Log "Backups saved to $backupDir" "Cyan"

Write-Host ""
Write-Host "Done! Updated $updatedCount blockstate files." -ForegroundColor Green
Write-Host "Backups saved to: $backupDir" -ForegroundColor Cyan
Write-Host "Log saved to: $logFile" -ForegroundColor Cyan

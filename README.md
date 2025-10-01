# Eisbaer's resource pack Base

This is the base resource pack (of the Eisbaer's ResPack Collection) and builds the foundation for the other resource packs.

## Features

- 1.1.01 **Colored Bow Charge**: Visually distinctive bow textures for different charge states
- (Configurable options via Respackopts)

## Scripts & Usage

This repository includes PowerShell scripts to help you build and manage your resource pack. All scripts use a centralized configuration file for easy maintenance:

### 1. `scripts/build.ps1` - Build the Resource Pack

- Creates a zipped resource pack in the `dist` directory
- Automatically manages version history

```powershell
# Command line options
.\scripts\build.ps1 -Version "1.2.0"              # Specify version
.\scripts\build.ps1                               # Interactive prompt for version
.\scripts\build.ps1 -PackName "MyFaithfulPack"    # Custom pack name
.\scripts\build.ps1 -Quiet                        # Non-interactive mode, uses defaults
.\scripts\build.ps1 -Help                         # Show help information
```

### 2. `scripts/export.ps1` - Copy to Minecraft

- Copies the most recently built resource pack to your Minecraft resourcepacks folder
- Confirms the destination path before copying (unless using -Quiet)

```powershell
# Command line options
.\scripts\export.ps1                                       # Use defaults
.\scripts\export.ps1 -PackName "MyFaithfulPack"            # Specify pack name
.\scripts\export.ps1 -MinecraftPath "D:\Games\Minecraft\resourcepacks"  # Custom Minecraft path
.\scripts\export.ps1 -Quiet                               # Skip confirmation prompt
```

### 3. `scripts/buildAndExport.ps1` - One-Step Build & Copy

- Combines the functionality of both scripts above
- Builds the resource pack and then copies it to your Minecraft folder

```powershell
# Command line options
.\scripts\buildAndExport.ps1 -Version "1.2.0"                         # Specify version
.\scripts\buildAndExport.ps1 -PackName "MyCustomPack"                 # Custom pack name 
.\scripts\buildAndExport.ps1 -MinecraftPath "D:\Games\Minecraft\resourcepacks"  # Custom path
.\scripts\buildAndExport.ps1 -Quiet                                   # Non-interactive mode
```

### 4. `scripts/config.ps1` - Centralized Configuration

- Contains all default settings and paths used by the scripts
- Modify this file to change default values for all scripts
- Includes settings for:
  - Default version number
  - Default pack name
  - Source and distribution directories
  - Default Minecraft path
  - Maximum number of previous builds to keep

**Intelligent Build History**

- Automatically renames existing builds with timestamps
- Maintains only 2 previous builds to save disk space
- Prevents accidental overwrites

## Configuration

The resource pack uses the [Respackopts](https://modrinth.com/mod/respackopts) mod for (optional but recommended) configuration.

### Available Options

Feature list:

#### 1.1.01: Colored Bow Charge

Feature #: 1.1.01
Default: disabled
Source: https://github.com/NerdieBirdieYT/coloredbowcharge
Description: Uses colored textures for bow charging states


### How to Configure

1. Install the [Respackopts mod](https://modrinth.com/mod/respackopts)
2. Load Minecraft with this resource pack enabled
3. In the resource pack selection screen, click the gear icon next to "Eisbaer's resource pack Base"
4. Toggle the options according to your preferences

## Changelog

### 0.0.1

- added Colored Bow Charge (ColoredBowCharge_2022-04-17)

## License

This pack is licensed under the [MIT License](https://github.com/eisbaer123/mc-eisbaers-res-pack-base-32x/blob/main/LICENSE).
# Eisbaer's resource pack Base

This is the base resource pack (of the Eisbaer's ResPack Collection) and builds the foundation for the other resource packs.

## Features - Short List

- 1.1.01 **Colored Bow Charge**: Visually distinctive bow textures for different charge states
- 1.2.01 **Variated Cobblestone**: Different textures for cobblestone blocks
- 1.2.02 **Variated Ores**: Different textures for ore blocks
- 1.2.03 **Unlit Redstone Ore**: *CUSTOM* Different textures for unlit redstone ore blockstate
- 1.2.04 **Better Tiled Deepslate Tiles**: *CUSTOM* Better textures for deepslate tiles
- 1.2.05 **Static Lanterns**: Static texture for sea lanterns
- 1.2.06 **Square Barrels**: Square barrels opening instead of round one
- 1.2.07 **Soul Soil Soul Campfire**: Soul soil "ash" texture for soul campfire
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

### How to Activate

1. Install the [Respackopts mod](https://modrinth.com/mod/respackopts)
2. Load Minecraft with this resource pack enabled
3. In the resource pack selection screen, click the gear icon next to "Eisbaer's resource pack Base"
4. Toggle the options according to your preferences

### Features

#### 1.1.01: Colored Bow Charge

Feature #: 1.1.01
Source: [GitHub](https://github.com/NerdieBirdieYT/coloredbowcharge)
Description: Uses three different textures (red, yellow, green) to show the charging state of a bow.

#### 1.2.01: Variated Cobblestone

Feature #: 1.2.01
Source: [FaithfulPack](https://faithfulpack.net/addons/VariatedCobblestone)
Description: Uses different texture variations for cobblestone blocks.

#### 1.2.02: Variated Ores

Feature #: 1.2.02
Source: [PlanetMinecraft](https://www.planetminecraft.com/texture-pack/compliance-variated-ores)
Description: Uses different texture variations for ore blocks.

#### 1.2.03: Unlit Redstone Ore - *Customized*

Feature #: 1.2.03
Source: [FaithfulPack](https://faithfulpack.net/addons/unlit-redstone-ore) | [GitHub](https://github.com/TQNL/TQNL-Faithful-Add-ons)
Description: Uses different textures for redstone ore blockstates. Customized version of the above source to make it compatible with *Feature 1.2.02: Variated Ores*. Inspired by [vanillatweaks.net](https://vanillatweaks.net/).

#### 1.2.04: Better Tiled Deepslate Tiles - *Customized*

Feature #: 1.2.04
Source: [PlanetMinecraft](https://www.planetminecraft.com/texture-pack/compliance-32x-better-tiled-deepslate-tiles)
Description: Uses a different texture to better connect tile blocks. Customized version, which also adds a different texure for Cracked Deepslate Tiles, based on the source to make it look uniform.

#### 1.2.05: Static Lanterns

Feature #: 1.2.05
Source: [FaithfulPack](https://faithfulpack.net/addons/ClearerLanterns) | [GitHub](https://github.com/Hedreon/Addons)
Description: Uses a static texture for sea lanterns.

#### 1.2.06: Square Barrels

Feature #: 1.2.06
Source: [FaithfulPack](https://faithfulpack.net/addons/SquareBarrels) | [GitHub](https://github.com/DMgaming101/SquareBarrels)
Description: Uses a square texture for the barrel opening.

#### 1.2.07: Soul Soil Soul Campfire

Feature #: 1.2.07
Source: [FaithfulPack](https://faithfulpack.net/addons/soul-soil-soul-campfire) | [GitHub](https://github.com/TQNL/TQNL-Faithful-Add-ons)
Description: Uses soul soil as "ash" texture for soul campfire (for better consistency). Inspired by [vanillatweaks.net](https://vanillatweaks.net/).

## Changelog

### 0.0.1

- added Colored Bow Charge (ColoredBowCharge_2022-04-17)
- added Variated Cobblestone (VariatedCobblestone_v1.1)
- added Variated Ores (VariatedOres_v1.18)
- added Unlit Redstone Ore (UnlitRedstoneOre_v1.18)
  - added own/custom adaptions of variated unlit redstone ores
- added Better Tiled Deepslate Tiles (BetterTiledDeepslateTiles_2021-07-01)
  - added own/custom adaption of block Cracked Deepslate Tiles
- added Static Lanterns (ClearerLanterns_1.21.8_2025-09-08)
- added Square Barrels (SquareBarrels_2024-12-05)
- added Soul Soil Soul Campfire (SoulSoilSoulCampfire_2025-01-20)

## License

This pack is licensed under the [MIT License](https://github.com/eisbaer123/mc-eisbaers-res-pack-base-32x/blob/main/LICENSE).
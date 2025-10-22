# Eisbaer's resource pack Base

This is the base resource pack of the "Eisbaer's ResPack Collection" (for Minecraft version **MC 1.21.9**). It builds the foundation for the other packs of the collection. The [Faithful 32x](https://faithfulpack.net/) resource pack needs to be installed and enabled before this pack in the resource pack selection screen.

## Integrated Resource Packs - Overview

| Feature ID | Pack Name | Version |
| --- | --- | --- |
| 1.1.01 | Colored Bow Charge | 2022-04-17 |
| 1.2.01 | Variated Cobblestone | v1.1 |
| 1.2.02 | Variated Ores | MC 1.18 |
| 1.2.03 | Unlit Redstone Ore | 2025-01-20 |
| 1.2.04 | Better Tiled Deepslate Tiles | MC 1.17 |
| 1.2.05 | Static Lanterns | MC 1.21.8 |
| 1.2.06 | Square Barrels | MC 1.21.4 |
| 1.2.07 | Soul Soil Soul Campfire | 2025-01-20 |
| 1.2.08 | Polished Chests | MC 1.16 |
| 1.2.09 | Inner Edges for Doors | MC 1.21.4 v1.1 |
| 1.2.10 | Candles Overhaul | MC 1.20 |
| 1.2.11 | All Consistent Bucket Textures | 2025-03-10 |
| 1.2.12 | Better Bottling (Combined) | Multiple versions |
| 1.2.13 | Unique Powders | 2021-11-11 |
| 1.2.14 | Unique Goat Horns | 2022-07-02 |

## Planned Development

### General To-Do List

- try to expand "Inner Edges for Doors" (and trapdoors) to include the three (currently) missing wood types: `spruce`, `dark oak`, `pale oak`

### New Features and/or Resource Packs

- none atm

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

### 3. `scripts/install.ps1` - One-Step Build & Copy

- Combines the functionality of both scripts above
- Builds the resource pack and then copies it to your Minecraft folder

```powershell
# Command line options
.\scripts\install.ps1 -Version "1.2.0"                         # Specify version
.\scripts\install.ps1 -PackName "MyCustomPack"                 # Custom pack name 
.\scripts\install.ps1 -MinecraftPath "D:\Games\Minecraft\resourcepacks"  # Custom path
.\scripts\install.ps1 -Quiet                                   # Non-interactive mode
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

### 5. [scripts/update_door_model_paths.ps1](cci:7://file:///f:/Repos/mc-eisbaers-res-pack-base-32x/scripts/update_door_model_paths.ps1:0:0-0:0) - Update Door Model Paths

- Automatically updates model paths in blockstate files (in `assets\minecraft\`) for doors and trapdoors
- Checks if corresponding custom models exist in the Inner Edges for Doors feature
- Creates backups of original files before making changes
- Logs all operations to a detailed log file

```powershell
# Command line options
.\scripts\update_door_model_paths.ps1    # Run the script to update door model paths
```

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

### Integrated Resource Packs - Details

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

#### 1.2.08: Polished Chests - *Customized*

Feature #: 1.2.08
Source: [FaithfulPack](https://faithfulpack.net/addons/polished-chests)
Description: Uses a polished golden brown chest texture instead of the old one. Customized version, which also adds the polished chest textures to chest boats (entities + items).

#### 1.2.09: Inner Edges for Doors - *Customized*

Feature #: 1.2.09
Source: [FaithfulPack](https://faithfulpack.net/addons/inner-edges-for-doors)
Description: Adds faces to the insides of the windows of doors and trapdoors and gives it a three-dimensional effect. Customized version, which also fixes the different copper door and trapdoor models (exposed, weathered, oxidized, and all waxed versions).

#### 1.2.10: Candles Overhaul - *Customized*

Source: [PlanetMinecraft](https://www.planetminecraft.com/texture-pack/candles-overhaul/)
Description: Uses a different candle model for candles (including candles on cakes). Since in newer versions of Minecraft the candles no longer use the translucent property, the version in this resource pack is a stripped-down version of the source without the wax overlay. For the wax overlay to show, you additionally need the [Eisbaer's Candle Overlay Fix](https://github.com/PSahner/mc-eisbaers-mods_candleOverlayFix) mod.

#### 1.2.11: All Consistent Bucket Textures

Source: [FaithfulPack](https://faithfulpack.net/addons/all-consistent-bucket-textures)
Description: Adds uniform bucket texture alignment and introduces a clearer water appearance for tadpoles in buckets. Inspired by [vanillatweaks.net](https://vanillatweaks.net/).

#### 1.2.12: Better Bottling - *Combined & Customized*

Feature #: 1.2.12
Sources (Combined):
- A Bit of Better Bottling (Faithful 32x) MC 1.19.3 v1.0
- Leo's Unique Potions v1.1
- Visual Potions Effect v1.1.1

Description: A comprehensive potion enhancement pack that combines three different bases into a unified system. Adds unique textures and overlays for various potion types (normal, splash, lingering), custom font characters for potion effects display, and visual enhancements. Originally designed for Optifine CIT but converted to use the native Minecraft 1.21.6+ item model system. Only potion-related content was integrated (buckets excluded). Features unique textures for awkward, water, thick/mundane, and fire resistance potions, plus special overlays for long and strong variants.

#### 1.2.13: Unique Powders

Feature #: 1.2.13
Source: [PlanetMinecraft](https://www.planetminecraft.com/texture-pack/unique-powder-5369494/) - By Alkatreize
Description: Gives distinct item textures for redstone, glowstone dust, gunpowder, and sugar to make each powder visually unique.

#### 1.2.14: Unique Goat Horns - *Customized*

Source: [PlanetMinecraft](https://www.planetminecraft.com/texture-pack/goat-horns-32x/) - By Scutoel
Description: Adds unique item textures for goat horns to make each horn visually unique. Customized version, which uses the new item model system instead of Optifine CIT.

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
- added Polished Chests (PolishedChests_2024-12-05)
  - added own/custom polished chest textures to chest boats
- updated Resource Pack (`pack.mcmeta`) for MC 1.21.9
- added Inner Edges for Doors (InnerEdgesForDoors_1.21.4_v1.1)
  - fixed different copper door and trapdoor models (exposed, weathered, oxidized, and all waxed versions)
- restructured resource pack architecture to use own namespaces for each feature
- added Candles Overhaul (CandlesOverhaul_2023-07-30)
  - stripped-down version of the source without the wax overlay
- added All Consistent Bucket Textures (AllConsistentBucketTextures_2025-03-10)
- added Better Bottling (combined from three bases)
  - bases\1.2.12_BetterPotions_Custom\1.2.12.1_BetterBottling_1.19.3_v1.0
  - bases\1.2.12_BetterPotions_Custom\1.2.12.2_LeoUniquePotions_v1.1
  - bases\1.2.12_BetterPotions_Custom\1.2.12.3_VisualPotionsEffect_v1.1.1
  - converted from Optifine CIT to native MC 1.21.6+ item model system
  - only potion-related content integrated (buckets excluded)
- added Unique Powders (UniquePowders_2021-11-11)
- added Unique Goat Horns (UniqueGoatHorns_2022-07-02)
  - added new vanilla item model system (without Optifine CIT)

## License

This pack is licensed under the [MIT License](https://github.com/eisbaer123/mc-eisbaers-res-pack-base-32x/blob/main/LICENSE).
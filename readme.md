# RetroSix Game & Watch Scripts

This script is a single run script that fully sets up everything on a linux machine (tested on Ubuntu 22) for you to be ready to backup, restore and flash the Game & Watch devices with Retro Go firmware or original backups.

Benefits include:

- Works on latest code repositories (as of Oct 2023)
- Fixes bugs in setup scripts, image resize scripts and more
- Lets you put ROMs in a folder before running setup to fully configure retro-go automatically
- Lets you put your backup firmware in a folder to fully configure backup and patch repositories automatically
- Fully defaulted to STLink and Mario without any configuration needed
- Handy build scripts in `game-and-watch-patch` and `game-and-watch-retro-go` so no need to remember specific build commands

## ROMs

Put your desired game ROMs and images (png files) in the `roms` folder.

Make sure to name the images and rom files the exact same name.

## Firmware Dumps

Put your backups if you have them already (`flash_backup_*.bin`, `internal_flash_backup_*.bin`, `itcm_backup_*.bin`) in the `firmware/mario` and `firmware/zelda` folders.

If you do this, the `game-and-watch-backup` and `game-and-watch-patch` repositories will be automatically configured to include the backup files where they are needed. Meaning you can run unlock, restore and patch commands instantly without the need for all the previous steps.

## Running Setup

Clone this repository and run the setup script:

```
git clone https://github.com/angelsix/game-and-watch-retrosix
cd game-and-watch-retrosix
chmod +x setup.sh
./setup.sh stlink mario
```

Replace `stlink` with `jlink` and `mario` with `zelda` as needed.

> NOTE: If `stlink` and `mario` are not specified they will default to that anyway, so you could just run `./setup.sh`

## Backup & Restore

Once the setup script is run, there will be a new folder called `build`. Inside that includes the repository `game-and-watch-backup`. 

Go into the folder and run the scripts as needed:

- 1_sanity_check.sh stlink mario
- 2_backup_flash.sh stlink mario
- 3_backup_internal_flash.sh stlink mario
- 4_unlock_device.sh stlink mario
- 5_restore.sh stlink mario

Again, changing the `stlink` and `mario` as needed.

If you already placed the firmware files in the folders at the start, you can just run steps 4 and 5.

## Patching (Ready for Dual Boot)

Once the setup script is run, there will be a new folder called `build`. Inside that includes the repository `game-and-watch-patch`. 

This is for patching the existing firmware to allow for dual boot by pressing **Game + Left** on the Game & Watch. You can skip this step if you only play to run the retro go emulator and not dual boot.

Go into the folder and run the scripts as needed:

```
./flash-patch.sh stlink mario
```

Replace `stlink` with `jlink` and `mario` with `zelda` as needed.

> NOTE: If `stlink` and `mario` are not specified they will default to that anyway, so you could just run `./flash-patch.sh.sh`

## Retro Go

Once the setup script is run, there will be a new folder called `build`. Inside that includes the repository `game-and-watch-retro-go`. 

This is for flashing the retro go emulator to the Game & Watch, either with the existing firmware to allow for dual boot by pressing **Game + Left** on the Game & Watch, or just directly.

### Dual Boot Flashing

Go into the folder and run the scripts as needed:

```
./flash-dual-boot.sh stlink mario
```

Replace `stlink` with `jlink` and `mario` with `zelda` as needed.

> NOTE: If `stlink` and `mario` are not specified they will default to that anyway, so you could just run `./flash-dual-boot.sh.sh`

### Single Boot Flashing

Go into the folder and run the scripts as needed:

```
./flash-single-boot.sh stlink mario
```

Replace `stlink` with `jlink` and `mario` with `zelda` as needed.

> NOTE: If `stlink` and `mario` are not specified they will default to that anyway, so you could just run `./flash-single-boot.sh.sh`
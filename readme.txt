# Super Easy Game & Watch Retro Go Setup Scripts

This script is a single run script that fully sets up everything on a linux machine (tested on Ubuntu 22) for you to be ready to backup, restore and flash the Game & Watch devices with Retro Go firmware or original backups.

Put your ROMS in the roms folder.
Put your backups if you have them already (flash_backup_*.bin, internal_flash_backup_*.bin, itcm_backup_*.bin) in the firmware mario and zelda folders.

Run `setup.sh stlink mario` to fully clone and setup all repos, roms and backups in a folder called "build".

Replace `stlink` with `jlink` and `mario` with `zelda` as needed.
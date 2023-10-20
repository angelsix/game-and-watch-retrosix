ADAPTER=$1
TARGET=$2

if [ $# -eq 0 ]
  then
    ADAPTER=stlink
    TARGET=mario
fi

echo " "
echo "-------------------------------------------------"
echo "    RetroSix Easy Game & Watch Retro Go Setup"
echo "-------------------------------------------------"
echo " "
echo " ADAPTER = $ADAPTER"
echo " TARGET  = $TARGET"
echo " "
echo " IMPORTANT: Before running this, make sure:"
echo " "
echo "  - You have placed your ROMs"
echo "    in the 'roms' folder."
echo " "
echo "  - You have placed your firmware bins"
echo "    in the 'firmware' folder (if available)."
echo " "
echo " "
read -p "Do you want to proceed? (y/n) " yn

case $yn in 
	[yY] ) echo Running Setup...;
		;;
	* ) exit;;
esac

echo " "
echo " "

rm -rf build
mkdir build
cd build

# Update all packages
sudo apt-get -y update
sudo apt-get -y upgrade

# Install Prerequisites
sudo apt-get -y install wget git binutils-arm-none-eabi python3 python3-pip libhidapi-hidraw0 libftdi1 libftdi1-2 lz4 libncurses5

# Install OpenOCD
wget -nc --progress=bar https://nightly.link/kbeckmann/ubuntu-openocd-git-builder/workflows/docker/master/openocd-git.deb.zip
unzip openocd-git.deb.zip
sudo dpkg -i openocd-git_*_amd64.deb
sudo apt-get -y -f install

# Install GCC
wget -nc --progress=bar https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2
tar -jxvf gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2 --directory .
sudo mv gcc-arm-none-eabi-10-2020-q4-major /opt/gcc-arm-none-eabi

# Set paths and cleanup
export OPENOCD=/opt/openocd-git/bin/openocd
export GCC_PATH=/opt/gcc-arm-none-eabi/bin
sudo apt autoremove
sudo rm *.deb *.zip *.bz2

# Clone Backup
git clone --recurse-submodules https://github.com/ghidraninja/game-and-watch-backup

# Clone Patch
git clone https://github.com/BrianPugh/game-and-watch-patch
cd game-and-watch-patch
pip3 install -r requirements.txt
make download_sdk
cd ..

# Clone Retro Go (sylverb)
git clone --recurse-submodules https://github.com/sylverb/game-and-watch-retro-go
cd game-and-watch-retro-go
python3 -m pip install -r requirements.txt
make romdef
cd ..

echo "$PWD"

# Copy firmware
if [[ $TARGET == "mario" ]]; then
    cp -r ../firmware/mario/* game-and-watch-patch
    mkdir game-and-watch-backup/backups
    cp -r ../firmware/mario/* game-and-watch-backup/backups
else 
    cp -r ../firmware/zelda/* game-and-watch-patch
    mkdir game-and-watch-backup/backups
    cp -r ../firmware/zelda/* game-and-watch-backup/backups
fi

# Patch up faulty retro go image resize
rm game-and-watch-retro-go/parse_roms.py
cp ../scripts/parse_roms.py game-and-watch-retro-go/

# Copy helper scripts
cp ../scripts/flash-patch.sh game-and-watch-patch/
chmod +x game-and-watch-patch/flash-patch.sh

cp ../scripts/flash-single-boot.sh game-and-watch-retro-go/
chmod +x game-and-watch-retro-go/flash-single-boot.sh

cp ../scripts/flash-dual-boot.sh game-and-watch-retro-go/
chmod +x game-and-watch-retro-go/flash-dual-boot.sh

# Copy roms
rm -rf game-and-watch-retro-go/roms
cp -r ../roms game-and-watch-retro-go


echo " "
echo " "
echo " "
echo " ............................................................. "
echo " ............................................................. "
echo " "
echo " All done."
echo " Your new folder is 'build' with everything you need"
echo " "
echo " Go into 'build' and run the following scripts in order"
echo " "
echo " This example is using STLink and a Mario game and watch"
echo " "
echo " game-and-watch-backup"
echo "   ./1_sanity_check.sh stlink mario"
echo "   (turn on G&W, hold power button) "
echo "   ./2_backup_flash.sh stlink mario"
echo "   ./3_backup_internal_flash.sh stlink mario"
echo "   ./4_unlock_device.sh stlink mario"
echo "   (power cycle G&W, then turn on and hold power button) "
echo "   ./5_restore.sh stlink mario"
echo " "
echo " game-and-watch-patch"
echo "   (replace SPI with larger SPI)"
echo "   (power cycle G&W, then turn on and hold power button) "
echo "   ./flash-patch.sh stlink mario"
echo " "
echo " game-and-watch-retro-go"
echo "   (power cycle G&W, then turn on and hold power button) "
echo "   ./flash-dual-boot.sh stlink mario"
echo " "
echo " ............................................................. "
echo " ............................................................. "
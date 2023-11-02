export OPENOCD=/opt/openocd-git/bin/openocd
export GCC_PATH=/opt/gcc-arm-none-eabi/bin

ADAPTER=$1
TARGET=$2

if [ $# -eq 0 ]
  then
    ADAPTER=stlink
    TARGET=mario
fi

echo " "
echo " ADAPTER = $ADAPTER"
echo " TARGET  = $TARGET"
echo " "

make clean

if [[ $TARGET == "mario" ]]; then
    make -j8 flash GNW_TARGET=mario ADAPTER=$ADAPTER EXTFLASH_SIZE_MB=63 COVERFLOW=1 EXTFLASH_OFFSET=1048576 INTFLASH_BANK=2
else
    make -j8 flash GNW_TARGET=zelda ADAPTER=$ADAPTER EXTFLASH_SIZE_MB=60 COVERFLOW=1 EXTFLASH_OFFSET=4194304 INTFLASH_BANK=2
fi

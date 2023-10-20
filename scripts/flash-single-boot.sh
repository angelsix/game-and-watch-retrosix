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
make -j8 flash GNW_TARGET=$TARGET ADAPTER=$ADAPTER EXTFLASH_SIZE_MB=64 COVERFLOW=1
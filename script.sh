#!/bin/bash
mkdir -p  ~/bios-firmware

PROGRAMMER=ch341a_spi

if [ $# -ne 1 ]; then 
    echo "Accepts only one argument!"
    exit 1

fi

BIOS_DUMP="$1"

if [ ! -f "$BIOS_DUMP" ] ; then
    echo "File does not exist!"
    exit 1

fi

echo "==== ====Detecting chip ===== ===="

sudo flashrom -p $PROGRAMMER || echo "Bios chip not detected! Reset clip" && exit 1

echo "==== ==== Reading chip contents ==== ===="

sudo flashrom -p $PROGRAMMER -r ~/bios-firmware/bak1.bin || echo "Could not read chip contents" && exit 1
sudo flashrom -p $PROGRAMMER -r ~/bios-firmware/bak2.bin || echo "Could not read chip contents" && exit 1
 
#compare  backup1 (bak1.bin) and backup2(bak2.bin) are similar
cmp ~/bios-firmware/bak1.bin ~/bios-firmware/bak2.bin

if [ "$?" -eq  0 ]; then
#if bak1.bin and bak2.bin are similar read the firmware one more time
    sudo flashrom -p $PROGRAMMER -r ~/bios-firmware/bak3.bin || echo "Could not read chip contents" && exit 1
else
    echo "[ERROR] DUMPS ARE DIFFERENT!"
    exit 1
fi

#compare  bak2.bin to bak3.bin
cmp  ~/bios-firmware/bak2.bin  ~/bios-firmware/bak3.bin

if [ "$?" -eq 0 ]; then 
    flashrom -p $PROGRAMMER -E
    flashrom -p $PROGRAMMER -w $BIOS_DUMP
else
    echo "Could not write new firmware!"
    exit 1
fi




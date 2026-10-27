#!/bin/bash
mkdir -p  ~/bios-firmware

# detect chip
# This assumes the programmer in use is a ch341a
sudo flashrom -p ch341a_spi

#Read the contents of the  bios chip at least 3 times

sudo flashrom -p ch341a_spi -r ~/bios-firmware/bak1.bin
sudo flashrom -p ch341a_spi -r ~/bios-firmware/bak2.bin
 
#compare  backup1 (bak1.bin) and backup2(bak2.bin) are similar
cmp ~/bios-firmware/bak1.bin ~/bios-firmware/bak2.bin

if [ "$?" -eq  0 ]; then
#if bak1.bin and bak2.bin are similar read the firmware one more time
    sudo flashrom -p ch341a_spi -r ~/bios-firmware/bak3.bin
else
    echo "[ERROR] DUMPS ARE DIFFERENT!"
    exit 1
fi

#compare  bak2.bin to bak3.bin
cmp  ~/bios-firmware/bak2.bin  ~/bios-firmware/bak3.bin

if [ "$?" -eq 0 ]; then 
    flashrom -p ch341a_spi -E
    flashrom -p ch341a_spi -w 
else
    echo "Could not write new firmware!"
    exit 1
fi




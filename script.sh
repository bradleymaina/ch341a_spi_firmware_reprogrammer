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

#if bak1.bin and bak2.bin are similar read the firmware one more time
sudo flashrom -p ch341a_spi -r ~/bios-firmware/bak3.bin

#compare  bak2.bin to bak3.bin
cmp  ~/bios-firmware/bak2.bin  ~/bios-firmware/bak3.bin

#if bak3 is not similar  to bak2 ....

#if bak3.bin is similar to bak2.bin , erase the firmware
flashrom -p ch341a_spi -E

#collect confirmation message

#write new firmware
flashrom -p ch341a_spi -w #name of the file 





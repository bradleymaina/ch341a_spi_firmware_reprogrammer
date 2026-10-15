## FLASHROM SCRIPT
This is a custom script for flashing firmware using a ch341a programmer. 

# Why would anyone need this?
1. If you bought a refurbished laptop with a bios password and you need to remove it

2. Laptop showing signs of life , but does not boot up , could be a bios issue and flashing new bios dump could fix it .

# Caveats
This is a risky move and the ch341a is the worst programmer for this job . I recommend a T48 programmer but again , I am not about to spend 15000kes on one.

You should always confirm the  input voltage of the chip  and that of the programmer. In my first encounter , I used the programmer trying to dump firmware to a chip whose input voltage was 1.8v , the ch341a outputs 3.3v. It wwas a mess. To avoid this , always check for the datasheet of the chip and confirm the input voltage.

Before writing any firmware , make sure you have at least 3 backups, compare the three backups and ensure there is no difference. Only then can you flash the new firmware. 

# Requirements
This is only customized for my operating system ie arch ...make sure to use the right package manager for your own operating system .

```bash
sudo pacman -S flashrom 
```

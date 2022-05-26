#!/usr/bin/env bash

DISK=/dev/sdc
DRIVE=/dev/sdc1
DATA_MOUNTPOINT=/mnt
EFI_MOUNTPOINT=$DATA_MOUNTPOINT
FILE_SYSTEM=vfat
UUID=8FA9-F800

get_uuid()
{
    if [ "${1%%/[hs]d?[0-9]}" != "${1}" ]; then
        echo "$(blkid -s UUID -o value ${1})"
    fi
}

# sudo mount -t $FILE_SYSTEM $DRIVE $DATA_MOUNTPOINT
# sudo mount -t $FILE_SYSTEM /dev/disk/by-uuid/$UUID $DATA_MOUNTPOINT

umount /dev/sdc1

parted /dev/sdc1 mklabel msdos

mkfs.vfat -F 32 -n MULTIBOOT /dev/sdc1

# Install a MBR (master boot record) to your USB disk.
sudo syslinux -fma /dev/sdc1 

# Install Syslinux to the partition you wish to boot from.
sudo syslinux -i /dev/sdc1 

sudo parted /dev/sdc set 1 boot on 
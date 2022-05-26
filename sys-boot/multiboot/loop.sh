#!/bin/bash

avaialable_disks=$(ls /sys/block)
# echo "All disks are : $avaialable_disks"
usb_disks=0
for disks in ${avaialable_disks[@]}; do
    # echo "Disk is $disks"
    if [ $(cat /sys/block/${disks}/removable) == 1 ]; then
            # echo "Removeable disks are : $disks"
            var[usb_disks++]="$disks";
        fi
done

echo "USB disk is : /dev/${var[@]}"

get_device_size() {
    local disk_sector_num=$(cat /sys/block/${1}/size)
    local disk_size_gb=$(expr $disk_sector_num / 2097152)
    echo ${disk_size_gb}
}

get_device_model() {
    echo $(cat /sys/block/${1}/device/model)
}

get_device_vendor() {
    echo $(cat /sys/block/${1}/device/vendor)
}

echo "Disk size is : $(get_device_size ${var[0]}) GB"
echo "Disk model is : $(get_device_model ${var[0]})"
echo "Disk vendor is : $(get_device_vendor ${var[0]})"

echo "Partitions are : $(ls /sys/block/${var[0]})" 
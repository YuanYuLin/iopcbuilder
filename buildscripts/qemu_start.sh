#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "qemu_start.sh [zImage] [SD card image]"
    exit 1
fi

TEST_CTX=`hexdump -n 4 -e '/1 "%02x"' -s 0x24 $1`
if [ "$TEST_CTX" != "18286f01" ]; then
    echo "Invalid kernel image"
    exit 1
fi

#NET_DEV="-net nic -net user,id=mynet0,net=192.168.122.0/24,dhcpstart=192.168.122.100"
NET_DEV="-m 512 -net nic -net user,hostfwd=tcp:127.0.0.1:8080-:8080"
KERNEL="-kernel $1" #output_pandaboard_qemu_a9/images/zImage"
SDCARD="-sd $2" #sdcard.img"
MACHINE="-serial stdio  -M vexpress-a9"

echo "qemu-system-arm $MACHINE $NET_DEV $KERNEL $SDCARD $APPEND"
qemu-system-arm $MACHINE $NET_DEV $KERNEL $SDCARD -append 'root=/dev/mmcblk0p1 rw physmap.enabled=0 console=ttyAMA0 init=/sbin/init'

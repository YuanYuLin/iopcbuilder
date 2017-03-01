#!/bin/bash

if [ "$#" == "0" ]; then
    echo "emu_arm <kernel> <hda> <hdb> <hdc>"
    exit 1
fi

MACHINE="-M versatilepb"
KERNEL="-kernel $1"
#HDD="-hda $2"
HDD="-hda $2 -hdb $3 -hdc $4 "
#INITRD="-initrd $3"
APPEND="-append console=ttyAMA0,115200"
NETDEV="-net nic -net tap,ifname=tap0,script=no,downscript=no"
#NETDEV="-netdev tap,id=tap0"
GRAPHIC="-nographic"
#GRAPHIC="-vnc 0::0"
OPTS="-m 256"
#OPTS=""

qemu-system-arm $MACHINE $KERNEL $HDD $GRAPHIC $OPTS $INITRD $NETDEV $APPEND

#!/bin/bash

#MACHINE="-M pc-q35-2.0 -cpu core2duo"

MACHINE="-M pc-q35-2.0 -cpu qemu64"
KERNEL="-kernel $1"
HDD="-hda $2"
#INITRD="-initrd $3"
APPEND="-append console=ttyS0,115200"
NETDEV="-net nic,model=e1000 -net tap,ifname=tap0,script=no,downscript=no"
#NETDEV="-netdev tap,id=tap0"
GRAPHIC="-vnc 0::0 -nographic"
#GRAPHIC="-vnc 0::0"
OPTS="-m 64"

qemu-system-x86_64 $MACHINE $KERNEL $HDD $GRAPHIC $OPTS $INITRD $NETDEV $APPEND
#kvm $MACHINE $KERNEL $HDD $GRAPHIC $OPTS $INITRD $NETDEV $APPEND

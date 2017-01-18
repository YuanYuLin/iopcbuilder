#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "create_config_img.sh [src rootfs] [output image]"
    echo "[src format] : "
    exit 1
fi

IMAGE_SIZE=16
SRC_ROOTFS=$1
OUTPUT_IMG=$2
MOUNT_PATH="/mnt"


function create_image()
{
    dd if=/dev/zero of=${OUTPUT_IMG} bs=1M count=${IMAGE_SIZE}
    mkfs.ext4 -F -L "config" ${OUTPUT_IMG}
    mount -t ext4 ${OUTPUT_IMG} ${MOUNT_PATH}
    cp -avr ${SRC_ROOTFS}/. ${MOUNT_PATH}
    umount ${MOUNT_PATH}
}

create_image

echo "Create config image at ${OUTPUT_IMG}!"


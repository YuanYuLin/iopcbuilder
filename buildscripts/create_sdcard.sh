#!/bin/bash

if [ "$#" -ne 4 ]; then
    echo "Illegal number of parameters"
    echo "create_sc.sh [src format] [filesystem type] [src rootfs] [project name]"
    echo "[src format] : "
    echo "IMAGE"
    echo "TARBALL"
    echo "[filesystem type]"
    echo "EXT4"
    echo "VFAT"
    exit 1
fi

SRC_FORMAT=$1
FS_TYPE=$2
SRC_ROOTFS=$3
SDCARD_PATH="/tmp/$4.img"
MOUNT_PATH="/tmp/$4"
SDCARD_COUNT=128 #128MB
SDCARD_SIZE=0
SDCARD_HEADS=0
SDCARD_SECTORS=0
SDCARD_CYLINDERS=0

function check_tarball()
{
    TEST_CTX=`hexdump -n 5 -e '/1 "%02x"' -s 0x101 ${SRC_ROOTFS}`
    if [ "$TEST_CTX" != "7573746172" ]; then
        echo "Invalid tarball image"
        exit 1
    fi
}

function create_sdcard_image()
{
    mkdir -p ${MOUNT_PATH}
    dd if=/dev/zero of=${SDCARD_PATH} bs=1M count=${SDCARD_COUNT}
    SDCARD_SIZE=`fdisk -l ${SDCARD_PATH} | grep Disk | awk '{print $5}'`
    SDCARD_HEADS=`fdisk -l ${SDCARD_PATH} | grep heads | awk '{print $1}'`
    SDCARD_SECTORS=`fdisk -l ${SDCARD_PATH} | grep heads | awk '{print $3}'`
    SDCARD_CYLINDERS=`fdisk -l ${SDCARD_PATH} | grep heads | awk '{print $5}'`
    echo "DISK size ${SDCARD_SIZE}, cylinders ${SDCARD_CYLINDERS}"
}

function create_sdcard_partition()
{
    if [ "${FS_TYPE}" == "EXT4" ]; then
        echo CYLINDERS - ${SDCARD_CYLINDERS}
        {
            echo ,,,*
        } | sfdisk -D -H ${SDCARD_HEADS} -S ${SDCARD_SECTORS} -C ${SDCARD_CYLINDERS} ${SDCARD_PATH} &> /dev/null
    fi

    if [ "${FS_TYPE}" == "VFAT" ]; then
        echo CYLINDERS - ${SDCARD_CYLINDERS}
        {
            echo ,,0x0C,*
        } | sfdisk -D -H ${SDCARD_HEADS} -S ${SDCARD_SECTORS} -C ${SDCARD_CYLINDERS} ${SDCARD_PATH} &> /dev/null
    fi
}

function format_sdcard_image()
{
    TEST_CTX=`kpartx -av ${SDCARD_PATH}`
    TEST_CTX=`echo $TEST_CTX | cut -d ' ' -f 3`

    if [ "${FS_TYPE}" == "EXT4" ]; then
        mkfs.ext4 -L "root" "/dev/mapper/$TEST_CTX"
        mount -t ext4 "/dev/mapper/$TEST_CTX" ${MOUNT_PATH}
    fi

    if [ "${FS_TYPE}" == "VFAT" ]; then
        mkfs.vfat -n "root" "/dev/mapper/$TEST_CTX"
        mount -t vfat "/dev/mapper/$TEST_CTX" ${MOUNT_PATH}
    fi
}
function copy_files_to_sdcard()
{
    if [ "${SRC_FORMAT}" == "IMAGE" ]; then
        cp ${SRC_ROOTFS} ${MOUNT_PATH}
    fi

    if [ "${SRC_FORMAT}" == "TARBALL" ]; then
        tar xvf ${SRC_ROOTFS} -C ${MOUNT_PATH}
    fi

    sync
    umount ${MOUNT_PATH}
    rm -rf ${MOUNT_PATH}
    kpartx -d ${SDCARD_PATH}
}

create_sdcard_image
create_sdcard_partition
format_sdcard_image
copy_files_to_sdcard

echo "Create SD Card image at ${SDCARD_PATH}!"


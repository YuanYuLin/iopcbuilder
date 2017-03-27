#!/bin/bash

MOUNT1="0"
MOUNT2="0"

UPPER_DIR="./buildsystem/buildroot_top"
BASE_DIR="./buildsystem/buildroot-2015.11.1"

mkdir -p $UPPER_DIR

if [ "$MOUNT1" == "1" ]; then
    WORK_DIR="./buildsystem/buildroot"
    LOWER_DIR="./buildroot_default"

    mkdir -p $WORK_DIR
    UPPER_DIR_RW="$UPPER_DIR=RW"

    unionfs-fuse -o nonempty $UPPER_DIR_RW:$LOWER_DIR:$BASE_DIR $WORK_DIR
fi

if [ "$MOUNT2" == "1" ]; then
    WORK_DIR="./buildsystem/buildroot2"

    mkdir -p $WORK_DIR
    UPPER_DIR_RW="$UPPER_DIR=RW"

    unionfs-fuse -o nonempty $UPPER_DIR_RW:$BASE_DIR $WORK_DIR
fi

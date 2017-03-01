#!/bin/bash

UPPER_DIR="./buildsystem/buildroot_top"
BASE_DIR="./buildsystem/buildroot-2015.11.1"
WORK_DIR="./buildsystem/buildroot"

LOWER_DIR="./buildroot_default"

mkdir -p $UPPER_DIR
mkdir -p $WORK_DIR

UPPER_DIR_RW="$UPPER_DIR=RW"

unionfs-fuse -o nonempty $UPPER_DIR_RW:$LOWER_DIR:$BASE_DIR $WORK_DIR


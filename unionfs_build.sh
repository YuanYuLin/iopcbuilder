#!/bin/bash

UPPER_DIR="./buildsystem/buildroot_top=RW"
BASE_DIR="./buildsystem/buildroot-2015.11.1"
WORK_DIR="./buildsystem/buildroot"

LOWER_DIR="./buildroot_default"

unionfs-fuse -o nonempty $UPPER_DIR:$LOWER_DIR:$BASE_DIR $WORK_DIR


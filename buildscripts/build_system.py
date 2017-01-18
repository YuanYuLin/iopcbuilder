#!/usr/bin/python2.7

import sys
import os
from BuildRoot.BuildRoot import BuildRoot

def main_func():
    if len(sys.argv) != 5:
        print len(sys.argv), " build_system [buildroot] [project config] [output name] [action]"
        return -1

    BUILDSCRIPT = sys.argv[0]
    BUILDROOT_TOP = sys.argv[1]
    PROJECT_CFG = sys.argv[2]
    OUTPUT_NAME = sys.argv[3]
    ACTION = sys.argv[4]

    build_system = BuildRoot()
    build_system.build_action(ACTION, build_system.get_config_obj(BUILDSCRIPT, BUILDROOT_TOP, PROJECT_CFG, OUTPUT_NAME))

if __name__ == "__main__":
   main_func()

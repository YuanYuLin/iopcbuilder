import os
import sys
from stat import *

class ScriptBuilder:
    def generate_buildscript(self, config_obj, dest_file):
        build_root = os.path.abspath(config_obj.get_output_link() + os.sep + "..")
        build_script_path = config_obj.get_buildscript()
        buildroot_path = config_obj.get_buildroot_top()
        project_ini_path = config_obj.get_project_config()
        output_name = config_obj.get_output_name()
        str_ptr = build_script_path
        if(len(build_script_path) > len(buildroot_path)):
            str_ptr = buildroot_path

        if(len(str_ptr) > len(project_ini_path)):
            str_ptr = project_ini_path

        idx = 0
        while True:
            #print " - " + build_script_path[idx] + " - " + buildroot_path[idx] + " - " + project_ini_path[idx] + " - " + str(idx)
            if(build_script_path[idx] == buildroot_path[idx] == project_ini_path[idx]):
                idx += 1
                continue
            else:
                break

        str_ptr = str_ptr[0:idx]
        idx = str_ptr.rfind(os.sep)
        str_ptr = str_ptr[0:idx]

        #print "IDX=" + str_ptr
        #return
        #print "---===--*********************"
        #print build_script_path
        #print buildroot_path
        #print project_ini_path
        #print output_name
        #print "---===--*********************"
        #print 'SAVE to ' + dest_file
        if os.path.exists(dest_file):
            return

        f = open(dest_file, 'w')
        line = ''
        line += '#!/bin/bash'
        line += os.linesep
        line += 'if [ "$#" -ne 1 ]; then'
        line += os.linesep
        line += 'PARAM="HELP"'
        line += os.linesep
        line += 'else'
        line += os.linesep
        line += 'PARAM=$1'
        line += os.linesep
        line += 'fi'
        line += os.linesep
        line += 'BUILD_TOP_PATH="' + str_ptr + '"'
        line += os.linesep
        line += build_script_path.replace(str_ptr, '$BUILD_TOP_PATH') + ' ' 
        line += buildroot_path.replace(str_ptr, '$BUILD_TOP_PATH') + ' ' 
        line += project_ini_path.replace(str_ptr, '$BUILD_TOP_PATH') + ' ' 
        line += output_name + ' $PARAM'
        line += os.linesep
        f.write(line)
        f.close()
        os.chmod(dest_file, S_IWUSR | S_IRUSR | S_IXUSR | S_IXGRP | S_IXOTH)

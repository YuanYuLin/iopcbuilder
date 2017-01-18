import os
import shutil
from Configs import Configs
from DefconfigParser import DefconfigParser
from BuildRootCommandHandler_Prepare import BuildRootCommandHandler_Prepare
from BuildRootCommandHandler_Menuconfig import BuildRootCommandHandler_Menuconfig
from BuildRootCommandHandler_ShowProjectInfo import BuildRootCommandHandler_ShowProjectInfo
from BuildRootCommandHandler_Buildproject import BuildRootCommandHandler_Buildproject
from BuildRootCommandHandler_Deleteproject import BuildRootCommandHandler_Deleteproject
from BuildRootCommandHandler_ShowBuildrootDefconfig import BuildRootCommandHandler_ShowBuildrootDefconfig
from BuildRootCommandHandler_SaveBuildrootDefconfig import BuildRootCommandHandler_SaveBuildrootDefconfig

class BuildRoot:
    method_table = None

    def __init__(self):
        self.method_table = {
            'MENUCONFIG'                : self.__make_menuconfig,
            'BUILD_PROJECT'             : self.__build_project,
            'DELETE_PROJECT'            : self.__delete_project,
            'SAVE_BUILDROOT_DEFCONFIG'  : self.__save_buildroot_defconfig,
            'SHOW_PROJECT_INFO'         : self.__show_project_info,
            'SHOW_BUILDROOT_DEFCONFIG'  : self.__show_buildroot_defconfig,
            'GENERATE_BUILD_SCRIPT'	: self.__generate_build_script,
            'HELP'                      : self.__show_help,
        }

    def __show_project_info(self, config_obj):
        cmd_hndlr = BuildRootCommandHandler_ShowProjectInfo(None)
        return cmd_hndlr.action(config_obj)

    def __build_project(self, config_obj):
        cmd_hndlr = BuildRootCommandHandler_Prepare(BuildRootCommandHandler_Buildproject(None))
        return cmd_hndlr.action(config_obj)

    def __delete_project(self, config_obj):
        cmd_hndlr = BuildRootCommandHandler_Deleteproject(None)
        return cmd_hndlr.action(config_obj)

    def __make_menuconfig(self, config_obj):
	cmd_hndlr = BuildRootCommandHandler_Prepare(BuildRootCommandHandler_Menuconfig(None))
        return cmd_hndlr.action(config_obj)

    def __show_buildroot_defconfig(self, config_obj):
        cmd_hndlr = BuildRootCommandHandler_ShowBuildrootDefconfig(None)
        return cmd_hndlr.action(config_obj)

    def __save_buildroot_defconfig(self, config_obj):
        cmd_hndlr = BuildRootCommandHandler_SaveBuildrootDefconfig(None)
        return cmd_hndlr.action(config_obj)

    def __generate_build_script(self, config_obj):
        cmd_hndlr = BuildRootCommandHandler_Prepare(None)
        return cmd_hndlr.action(config_obj)

    def __show_help(self, config_obj):
        method_table_in_project = config_obj.get_method_table()
        print method_table_in_project
        print "========================================="
        print "Supported action in project:"
        for item in sorted(method_table_in_project.keys()):
            print "    '" + item + "'"
        print "========================================="

    def get_config_obj(self, buildscript, build_root_top, project_ini, output_top):
        return Configs(buildscript, build_root_top, project_ini, output_top)

    def build_action(self, action, config_obj):
        method_table_in_project = config_obj.get_method_table()
        handler = None
        if action in method_table_in_project:
            if action in self.method_table.keys():
                print "Do Handler " + action
                handler = self.method_table[action]
                handler(config_obj)
            else:
                print action + ' NOT implemented in BuildRoot.py'
        else:
            print "Error " + action 
            self.__show_help(config_obj)

import os
import ConfigParser
from Singleton import Singleton

class Configs(Singleton):
    flags = {
        "IS_DEFAULT_ROOT_OVERRIDE"	:True,
            }
    dicts = {
        "BUILDROOT_TOP"			:"",
        "BUILDSCRIPT"			:"",
        "PROJECT_TOP"			:"",
        "OUTPUT_TOP"			:"",
        "OUTPUT_LINK"			:"",
        "PROJECT_CONFIG"		:"",
        "DEFAULT_CONFIG_BUILDROOT"	:"",
        "DEFAULT_CONFIG_BUSYBOX"	:"",
        "DEFAULT_CONFIG_LINUX"		:"",
        "DEFAULT_ROOTFS"		:{},
        "ROOTFS_SKELETON"		:"",
        "PROJECT_NAME"			:"",
        "DOWNLOAD_TOP"			:"",
        "OUTPUT_NAME"			:"",
        "METHOD_TABLE"			:{},
            }

    '''
    Begin 
    '''
    def get_buildroot_top(self):
        return self.dicts["BUILDROOT_TOP"]

    def get_buildscript(self):
        return self.dicts["BUILDSCRIPT"]

    def get_project_top(self):
        return self.dicts["PROJECT_TOP"]

    def get_output_top(self):
        return self.dicts["OUTPUT_TOP"]

    def get_output_link(self):
        return self.dicts["OUTPUT_LINK"]

    def get_project_config(self):
        return self.dicts["PROJECT_CONFIG"]

    def get_project_name(self):
        return self.dicts["PROJECT_NAME"]

    def get_download_top(self):
        return self.dicts["DOWNLOAD_TOP"]

    def get_default_config_buildroot(self):
        return self.dicts["DEFAULT_CONFIG_BUILDROOT"]

    def get_default_config_busybox(self):
        return self.dicts["DEFAULT_CONFIG_BUSYBOX"]

    def get_default_config_linux(self):
        return self.dicts["DEFAULT_CONFIG_LINUX"]

    def get_default_rootfs(self):
        return self.dicts["DEFAULT_ROOTFS"]

    def get_rootfs_skeleton(self):
        return self.dicts["ROOTFS_SKELETON"]

    def is_default_rootfs_override(self):
        return self.flags["IS_DEFAULT_ROOT_OVERRIDE"]

    def get_method_table(self):
        return self.dicts["METHOD_TABLE"]

    def get_output_name(self):
        return self.dicts["OUTPUT_NAME"]

    '''
    End
    '''

    def __default_rootfs_init(self, iniparser):
	rootfs_list = {}
        try:
            ''' Section DEFAULT_ROOTFS_OVERRIDE '''
            rootfs_list = iniparser.items("DEFAULT_ROOTFS_OVERRIDE")

            self.flags["IS_DEFAULT_ROOT_OVERRIDE"] = True
        except ConfigParser.Error, e:
            self.flags["IS_DEFAULT_ROOT_OVERRIDE"] = False

        try:
            ''' Section DEFAULT_ROOTFS '''
            rootfs_list = iniparser.items("DEFAULT_ROOTFS_OVERLAY")

            self.flags["IS_DEFAULT_ROOT_OVERRIDE"] = False
        except ConfigParser.Error, e:
            self.flags["IS_DEFAULT_ROOT_OVERRIDE"] = True

        return rootfs_list

    def _constructor(self, buildscript, buildroot_top, project_config, output_name):
        buildroot_folder = os.path.abspath(buildroot_top + os.sep + "..") + os.sep
        self.dicts["OUTPUT_NAME"] = output_name
        self.dicts["BUILDSCRIPT"] = os.path.abspath(buildscript)
        self.dicts["BUILDROOT_TOP"] = os.path.abspath(buildroot_top)
        self.dicts["PROJECT_CONFIG"] = os.path.abspath(project_config)
        self.dicts["PROJECT_TOP"] = os.path.abspath(os.path.dirname(project_config))
        self.dicts["OUTPUT_TOP"] = os.path.abspath(buildroot_top + os.sep + output_name)
        self.dicts["OUTPUT_LINK"] = os.path.abspath(buildroot_folder + os.sep + ".." + os.sep + output_name)

        try:
            project_top = self.dicts["PROJECT_TOP"] + os.sep
            iniparser = ConfigParser.ConfigParser()
            iniparser.read(project_config)
            ''' Section PROJECT_INFO '''
            self.dicts["PROJECT_NAME"] = iniparser.get("PROJECT_INFO", "PROJECT_NAME")
            self.dicts["DOWNLOAD_TOP"] = buildroot_folder + iniparser.get("PROJECT_INFO", "DOWNLOAD_TOP")

            ''' Section DEFAULT_CONFIGS '''
            self.dicts["DEFAULT_CONFIG_BUILDROOT"] = project_top + iniparser.get("DEFAULT_CONFIGS", "DEFAULT_CONFIG_BUILDROOT")
            self.dicts["DEFAULT_CONFIG_BUSYBOX"] = project_top + iniparser.get("DEFAULT_CONFIGS", "DEFAULT_CONFIG_BUSYBOX")
            self.dicts["DEFAULT_CONFIG_LINUX"] = project_top + iniparser.get("DEFAULT_CONFIGS", "DEFAULT_CONFIG_LINUX")

            ''' Set DEFAULT_ROOTFS'''
            rootfs_list = {}
            for root in self.__default_rootfs_init(iniparser):
                name = root[0].upper()
                value = root[1]
                rootfs_list[name] = project_top + value

            self.dicts["DEFAULT_ROOTFS"] = rootfs_list
            self.dicts["ROOTFS_SKELETON"] = self.dicts["OUTPUT_TOP"] + os.sep + "rootfs_skeleton"

            ''' Section METHOD_TABLE '''
            self.dicts["METHOD_TABLE"] = iniparser.items("METHOD_TABLE")
            supported_method_in_project = {}
            for method in self.dicts["METHOD_TABLE"]:
                name = method[0].upper()
                value = method[1]
                if value == 'YES':
                    supported_method_in_project[name] = value

            self.dicts["METHOD_TABLE"] = supported_method_in_project

        except ConfigParser.Error, e:
            print e


    def __init__(self, buildscript, buildroot_top, project_config, output_name):
        self._constructor(buildscript, buildroot_top, project_config, output_name)

    def get_configs(self):
        return self.dicts

    def get_config(self, key):
        return self.dicts[key]

    def get_config_keys(self):
        return self.dicts.keys()


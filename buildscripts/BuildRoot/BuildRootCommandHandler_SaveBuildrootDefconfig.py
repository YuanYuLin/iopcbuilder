import os
import shutil
from DefconfigParser import DefconfigParser
from BuildRootCommandHandler import BuildRootCommandHandler

class BuildRootCommandHandler_SaveBuildrootDefconfig(BuildRootCommandHandler):
    def __init__(self, next_command_handler):
        BuildRootCommandHandler.__init__(self, next_command_handler)

    def action(self, config_obj):
        print 'BuildRootCommandHandler_SaveBuildrootDefconfig'

        src_defconfig_file_name = config_obj.get_output_top() + os.sep + ".config"
        dst_defconfig_file_name = config_obj.get_default_config_buildroot()
        shutil.copyfile(src_defconfig_file_name, dst_defconfig_file_name)

        self.do_next_command_handler(config_obj)


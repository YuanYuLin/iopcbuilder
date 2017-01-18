import os
import shutil
from DefconfigParser import DefconfigParser
from BuildRootCommandHandler import BuildRootCommandHandler

class BuildRootCommandHandler_ShowBuildrootDefconfig(BuildRootCommandHandler):
    def __init__(self, next_command_handler):
        BuildRootCommandHandler.__init__(self, next_command_handler)

    def action(self, config_obj):
        print 'BuildRootCommandHandler_ShowBuildrootDefconfig'

        defconfig_file_name = config_obj.get_output_top() + os.sep + ".config"
        parser = DefconfigParser(defconfig_file_name)
        parser.parse()
        parser.show_configs()

        self.do_next_command_handler(config_obj)


import os
import shutil
from DefconfigParser import DefconfigParser
from BuildRootCommandHandler import BuildRootCommandHandler

class BuildRootCommandHandler_ShowProjectInfo(BuildRootCommandHandler):
    def __init__(self, next_command_handler):
        BuildRootCommandHandler.__init__(self, next_command_handler)

    def action(self, config_obj):
        print 'BuildRootCommandHandler_ShowProjectInfo'

        print "------------------------------------------------------------"
        for key in config_obj.get_config_keys():
            print key,"\n\t: ", config_obj.get_config(key)
        print "------------------------------------------------------------"

        self.do_next_command_handler(config_obj)

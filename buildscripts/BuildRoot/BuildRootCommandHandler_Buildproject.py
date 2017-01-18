import os
import shutil
from DefconfigParser import DefconfigParser
from BuildRootCommandHandler import BuildRootCommandHandler

class BuildRootCommandHandler_Buildproject(BuildRootCommandHandler):
    def __init__(self, next_command_handler):
        BuildRootCommandHandler.__init__(self, next_command_handler)

    def action(self, config_obj):
        print 'BuildRootCommandHandler_Buildproject'

        args =  " O=" + config_obj.get_output_top() + " -C " + config_obj.get_buildroot_top() + " V=1 "
        command = "make " + args
        print "execute: " + command
        os.system(command)

        self.do_next_command_handler(config_obj)


import os
import shutil
from DefconfigParser import DefconfigParser
from BuildRootCommandHandler import BuildRootCommandHandler

class BuildRootCommandHandler_Deleteproject(BuildRootCommandHandler):
    def __init__(self, next_command_handler):
        BuildRootCommandHandler.__init__(self, next_command_handler)

    def action(self, config_obj):
        print 'BuildRootCommandHandler_Deleteproject'

        output_top = config_obj.get_output_top()
        output_link = config_obj.get_output_link()
        shutil.rmtree(output_top)
        os.unlink(output_link)

        self.do_next_command_handler(config_obj)


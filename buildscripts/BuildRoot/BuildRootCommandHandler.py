import os
import shutil
from DefconfigParser import DefconfigParser

class BuildRootCommandHandler:
    def __init__(self, next_command_handler):
        self.next_command_handler = next_command_handler

    def do_next_command_handler(self, config_obj):
        if self.next_command_handler:
            self.next_command_handler.action(config_obj)


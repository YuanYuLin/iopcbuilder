import os
import shutil
from DefconfigParser import DefconfigParser

class BuildRootCommandHandler:
    def __init__(self, next_command_handler):
        self.next_command_handler = next_command_handler

    def do_next_command_handler(self, config_obj):
        if self.next_command_handler:
            self.next_command_handler.action(config_obj)


class BuildRootCommandHandler_Prepare(BuildRootCommandHandler):
    def __init__(self, next_command_handler):
        BuildRootCommandHandler.__init__(self, next_command_handler)

    def action(self, config_obj):
        print 'BuildRootCommandHandler_Prepare'

        self._generate_buildroot_defconfig(config_obj)
        self._create_link_and_output(config_obj)
        self._create_rootfs_skeleton(config_obj)
        self._set_os_environ(config_obj)

        self.do_next_command_handler(config_obj)

    def _generate_buildroot_defconfig(self, config_obj):
        project_buildroot_cfg = config_obj.get_project_top() + os.sep + config_obj.get_default_config_buildroot()
        parser = DefconfigParser(config_obj.get_default_config_buildroot())
        parser.parse()
        parser.set_config("BR2_DEFCONFIG", config_obj.get_default_config_buildroot())
        parser.set_config("BR2_DL_DIR", config_obj.get_download_top())
        parser.set_config("BR2_ROOTFS_SKELETON_CUSTOM_PATH", config_obj.get_rootfs_skeleton())
        parser.set_config("BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE", config_obj.get_default_config_linux())
        parser.set_config("BR2_PACKAGE_BUSYBOX_CONFIG", config_obj.get_default_config_busybox())
        parser.save_configs(config_obj.get_default_config_buildroot())

    def _create_rootfs_skeleton(self, config_obj):
        rootfs_top = config_obj.get_rootfs_skeleton()

        if not os.path.exists(rootfs_top):
            print 'Create ' + rootfs_top
            os.makedirs(rootfs_top)

        rootfs_list = config_obj.get_default_rootfs()
        for rootfs_name in sorted(rootfs_list.keys()):
            rootfs = rootfs_list[rootfs_name]
            print 'Copy ' + rootfs
            self.copy_tree(rootfs, rootfs_top)

    def copy_tree(self, src, dst):
        names = os.listdir(src)
        errors = []
        for name in names:
            srcname = os.path.join(src, name)
            dstname = os.path.join(dst, name)
            try:
                if os.path.islink(srcname):
                    linkto = os.readlink(srcname)
                    os.symlink(linkto, dstname)
                elif os.path.isdir(srcname):
                    os.makedirs(dstname)
                    self.copy_tree(srcname, dstname)
                else:
                    shutil.copy2(srcname, dstname)
                # XXX What about devices, sockets etc.?
            except (IOError, os.error) as why:
                errors.append((srcname, dstname, str(why)))
        try:
            shutil.copystat(src, dst)
        except OSError as why:
            errors.extend((src, dst, str(why)))

    def _create_link_and_output(self, config_obj):
        output_top = config_obj.get_output_top()
        output_link = config_obj.get_output_link()

        if (not os.path.exists(output_top)) and (not os.path.exists(output_link)):
            os.mkdir(output_top)
            os.symlink(output_top, output_link)
            print "create output and link"
        elif not os.path.exists(output_top):
            print "output is not exist ", output_top
        elif not os.path.exists(output_link):
            print "link is not exist ", output_link
        else:
            print "link and output are exist "

        buildroot_defconfig = output_top + os.sep + ".config"
        if not os.path.exists(buildroot_defconfig):
            os.symlink(config_obj.get_default_config_buildroot(), buildroot_defconfig)

        return 0

    def _set_os_environ(self, config_obj):
        os.environ["BR2_DEFCONFIG"] = config_obj.get_default_config_buildroot()

class BuildRootCommandHandler_Menuconfig(BuildRootCommandHandler):
    def __init__(self, next_command_handler):
        BuildRootCommandHandler.__init__(self, next_command_handler)

    def action(self, config_obj):
        print 'BuildRootCommandHandler_Menuconfig'

        args =  " O=" + config_obj.get_output_top() + " -C " + config_obj.get_buildroot_top()
        command = "make menuconfig " + args
        print "execute: " + command
        os.system(command)

        self.do_next_command_handler(config_obj)

class BuildRootCommandHandler_Buildproject(BuildRootCommandHandler):
    def __init__(self, next_command_handler):
        BuildRootCommandHandler.__init__(self, next_command_handler)

    def action(self, config_obj):
        print 'BuildRootCommandHandler_Buildproject'

        args =  " O=" + config_obj.get_output_top() + " -C " + config_obj.get_buildroot_top()
        command = "make " + args
        print "execute: " + command
        os.system(command)

        self.do_next_command_handler(config_obj)

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

class BuildRootCommandHandler_ShowBuildrootDefconfig(BuildRootCommandHandler):
    def __init__(self, next_command_handler):
        BuildRootCommandHandler.__init__(self, next_command_handler)

    def action(self, config_obj):
        print 'BuildRootCommandHandler_ShowBuildrootDefconfig'

        defconfig_file_name = config_obj.get_output_config_buildroot()
        parser = DefconfigParser(defconfig_file_name)
        parser.parse()
        parser.show_configs()

        self.do_next_command_handler(config_obj)

class BuildRootCommandHandler_SaveBuildrootDefconfig(BuildRootCommandHandler):
    def __init__(self, next_command_handler):
        BuildRootCommandHandler.__init__(self, next_command_handler)

    def action(self, config_obj):
        print 'BuildRootCommandHandler_SaveBuildrootDefconfig'

        src_defconfig_file_name = config_obj.get_output_config_buildroot()
        dst_defconfig_file_name = config_obj.get_default_config_buildroot()
        parser = DefconfigParser(src_defconfig_file_name)
        parser.parse()
        parser.save_configs(dst_defconfig_file_name)

        self.do_next_command_handler(config_obj)

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

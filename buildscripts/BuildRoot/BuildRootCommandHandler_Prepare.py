import os
import shutil
from DefconfigParser import DefconfigParser
from BuildRootCommandHandler import BuildRootCommandHandler
from ScriptBuilder import ScriptBuilder

class BuildRootCommandHandler_Prepare(BuildRootCommandHandler):
    def __init__(self, next_command_handler):
        BuildRootCommandHandler.__init__(self, next_command_handler)

    def action(self, config_obj):
        print 'BuildRootCommandHandler_Prepare'

        self._generate_buildroot_defconfig(config_obj)
        self._create_link_and_output(config_obj)
        self._create_rootfs_skeleton(config_obj)
        self._set_os_environ(config_obj)
        self._create_build_script(config_obj)

        self.do_next_command_handler(config_obj)

    def _generate_buildroot_defconfig(self, config_obj):
        project_buildroot_cfg = config_obj.get_project_top() + os.sep + config_obj.get_default_config_buildroot()
        parser = DefconfigParser(config_obj.get_default_config_buildroot())
        parser.parse()

        parser.set_config("BR2_DEFCONFIG", config_obj.get_default_config_buildroot())

        parser.set_config("BR2_DL_DIR", config_obj.get_download_top())

        if config_obj.is_default_rootfs_override():
            print "----------------------"
            parser.set_config("BR2_ROOTFS_SKELETON_CUSTOM_PATH", config_obj.get_rootfs_skeleton())
            parser.set_config("BR2_ROOTFS_OVERLAY", "")
        else:
            print "====================="
            parser.set_config("BR2_ROOTFS_SKELETON_CUSTOM_PATH", "")
            parser.set_config("BR2_ROOTFS_OVERLAY", config_obj.get_rootfs_skeleton())

        parser.set_config("BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE", config_obj.get_default_config_linux())

        parser.set_config("BR2_PACKAGE_BUSYBOX_CONFIG", config_obj.get_default_config_busybox())

        parser.set_config("BR2_TARGET_GENERIC_ISSUE", "")

        parser.set_config("BR2_TARGET_GENERIC_HOSTNAME", "")

        #parser.show_configs()
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
            self._copy_tree(rootfs, rootfs_top)

    def _copy_tree(self, src, dst):
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
                    if not os.path.exists(dstname):
                        os.makedirs(dstname)
                    self._copy_tree(srcname, dstname)
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

    def _create_build_script(self, config_obj):
        output_top = config_obj.get_output_top()
        output_link = config_obj.get_output_link()
        build_script_path = output_top + os.sep + "BuildScript"
        builder = ScriptBuilder()
        builder.generate_buildscript(config_obj, build_script_path)


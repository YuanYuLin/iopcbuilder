################################################################################
#
# kmod_hello
#
################################################################################

KMOD_HELLO_VERSION       = d45bc3ae35584d441d93515d82244016eb43128b
KMOD_HELLO_SITE          = $(call github,YuanYuLin,buildroot_kernel_module_helloworld,$(KMOD_HELLO_VERSION))
KMOD_HELLO_LICENSE       = GPLv2+
KMOD_HELLO_LICENSE_FILES = COPYING

KMOD_HELLO_DEPENDENCIES  = linux

KMOD_HELLO_MAKE_OPTS += ARCH=$(KERNEL_ARCH)
KMOD_HELLO_MAKE_OPTS += CROSS_COMPILE=$(TARGET_CROSS)
KMOD_HELLO_MAKE_OPTS += -C $(LINUX_DIR)
KMOD_HELLO_MAKE_OPTS += M=$(@D)

KMOD_HELLO_INSTALL_MOD_DIR = helloworld

define KMOD_HELLO_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) $(KMOD_HELLO_MAKE_OPTS)
endef

define KMOD_HELLO_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) $(KMOD_HELLO_MAKE_OPTS) \
		INSTALL_MOD_PATH=$(TARGET_DIR) \
		INSTALL_MOD_STRIP=1 \
		INSTALL_MOD_DIR=$(KMOD_HELLO_INSTALL_MOD_DIR) \
		modules_install
endef

define KMOD_HELLO_UNINSTALL_TARGET_CMDS
        rm -rf $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/$(KMOD_HELLO_INSTALL_MOD_DIR)
endef

#$(eval $(call GENTARGETS,package,kmod_hello))
$(eval $(generic-package))

################################################################################
#
# platform_pandaboard
#
################################################################################

#PLATFORM_PANDABOARD_VERSION = 1.0.0
#PLATFORM_PANDABOARD_SOURCE = platform_pandaboard-$(PLATFORM_VERSATILE_VERSION).tar.xz
#PLATFORM_PANDABOARD_SITE = $(BR2_KERNEL_MIRROR)/linux/utils/raid/mdadm
PLATFORM_PANDABOARD_SOURCE = 
PLATFORM_PANDABOARD_LICENSE = GPLv2+
PLATFORM_PANDABOARD_LICENSE_FILES = COPYING

PLATFORM_PANDABOARD_PACKAGE_DIR = $(BASE_DIR)/packages/platform

ifeq ($(BR2_PACKAGE_PLATFORM_PANDABOARD_AS_HOST),y)
define PLATFORM_PANDABOARD_PACKAGE_INSTALL
	cp -avr package/platform_pandaboard/host/* $(PLATFORM_PANDABOARD_PACKAGE_DIR)/etc/iopc

endef
endif

ifeq ($(BR2_PACKAGE_PLATFORM_PANDABOARD_AS_GUEST),y)
define PLATFORM_PANDABOARD_PACKAGE_INSTALL
	cp -avr package/platform_pandaboard/guest/* $(PLATFORM_PANDABOARD_PACKAGE_DIR)/etc/iopc
endef
endif

define PLATFORM_PANDABOARD_INSTALL_TARGET_DIR
	mkdir -p $(TARGET_DIR)/etc/iopc
	mkdir -p $(TARGET_DIR)/persist
	cp -avr $(PLATFORM_PANDABOARD_PACKAGE_DIR)/etc/iopc/* $(TARGET_DIR)/etc/iopc/
endef

define PLATFORM_PANDABOARD_INSTALL_TARGET_CMDS
	mkdir -p $(PLATFORM_PANDABOARD_PACKAGE_DIR)/etc/iopc
	$(PLATFORM_PANDABOARD_PACKAGE_INSTALL)
	$(PLATFORM_PANDABOARD_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

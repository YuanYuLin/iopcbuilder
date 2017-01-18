################################################################################
#
# platform_raspberrypi2
#
################################################################################

#PLATFORM_RASPBERRYPI2_VERSION = 1.0.0
#PLATFORM_RASPBERRYPI2_SOURCE = platform_versatile-$(PLATFORM_VERSATILE_VERSION).tar.xz
#PLATFORM_RASPBERRYPI2_SITE = $(BR2_KERNEL_MIRROR)/linux/utils/raid/mdadm
PLATFORM_RASPBERRYPI2_SOURCE = 
PLATFORM_RASPBERRYPI2_LICENSE = GPLv2+
PLATFORM_RASPBERRYPI2_LICENSE_FILES = COPYING

PLATFORM_RASPBERRYPI2_PACKAGE_DIR = $(BASE_DIR)/packages/platform

ifeq ($(BR2_PACKAGE_PLATFORM_RASPBERRYPI2_AS_HOST),y)
define PLATFORM_RASPBERRYPI2_PACKAGE_INSTALL
	cp -avr package/platform_raspberrypi2/host/* $(PLATFORM_RASPBERRYPI2_PACKAGE_DIR)/etc/iopc

endef
endif

ifeq ($(BR2_PACKAGE_PLATFORM_RASPBERRYPI2_AS_GUEST),y)
define PLATFORM_RASPBERRYPI2_PACKAGE_INSTALL
	cp -avr package/platform_raspberrypi2/guest/* $(PLATFORM_RASPBERRYPI2_PACKAGE_DIR)/etc/iopc
endef
endif

define PLATFORM_RASPBERRYPI2_INSTALL_TARGET_DIR
	mkdir -p $(TARGET_DIR)/etc/iopc
	mkdir -p $(TARGET_DIR)/persist
	cp -avr $(PLATFORM_RASPBERRYPI2_PACKAGE_DIR)/etc/iopc/* $(TARGET_DIR)/etc/iopc/
endef

define PLATFORM_RASPBERRYPI2_INSTALL_TARGET_CMDS
	mkdir -p $(PLATFORM_RASPBERRYPI2_PACKAGE_DIR)/etc/iopc
	$(PLATFORM_RASPBERRYPI2_PACKAGE_INSTALL)
	$(PLATFORM_RASPBERRYPI2_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

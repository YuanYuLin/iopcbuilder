################################################################################
#
# platform_raspberrypi
#
################################################################################

#PLATFORM_RASPBERRYPI_VERSION = 1.0.0
#PLATFORM_RASPBERRYPI_SOURCE = platform_versatile-$(PLATFORM_VERSATILE_VERSION).tar.xz
#PLATFORM_RASPBERRYPI_SITE = $(BR2_KERNEL_MIRROR)/linux/utils/raid/mdadm
PLATFORM_RASPBERRYPI_SOURCE = 
PLATFORM_RASPBERRYPI_LICENSE = GPLv2+
PLATFORM_RASPBERRYPI_LICENSE_FILES = COPYING

PLATFORM_RASPBERRYPI_PACKAGE_DIR = $(BASE_DIR)/packages/platform

ifeq ($(BR2_PACKAGE_PLATFORM_RASPBERRYPI_AS_HOST),y)
define PLATFORM_RASPBERRYPI_PACKAGE_INSTALL
	cp -avr package/platform_raspberrypi/host/* $(PLATFORM_RASPBERRYPI_PACKAGE_DIR)/etc/iopc

endef
endif

ifeq ($(BR2_PACKAGE_PLATFORM_RASPBERRYPI_AS_GUEST),y)
define PLATFORM_RASPBERRYPI_PACKAGE_INSTALL
	cp -avr package/platform_raspberrypi/guest/* $(PLATFORM_RASPBERRYPI_PACKAGE_DIR)/etc/iopc
endef
endif

define PLATFORM_RASPBERRYPI_INSTALL_TARGET_DIR
	mkdir -p $(TARGET_DIR)/etc/iopc
	mkdir -p $(TARGET_DIR)/persist
	cp -avr $(PLATFORM_RASPBERRYPI_PACKAGE_DIR)/etc/iopc/* $(TARGET_DIR)/etc/iopc/
endef

define PLATFORM_RASPBERRYPI_INSTALL_TARGET_CMDS
	mkdir -p $(PLATFORM_RASPBERRYPI_PACKAGE_DIR)/etc/iopc
	$(PLATFORM_RASPBERRYPI_PACKAGE_INSTALL)
	$(PLATFORM_RASPBERRYPI_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

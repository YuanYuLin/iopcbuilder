################################################################################
#
# platform_versatile
#
################################################################################

#PLATFORM_VERSATILE_VERSION = 1.0.0
#PLATFORM_VERSATILE_SOURCE = platform_versatile-$(PLATFORM_VERSATILE_VERSION).tar.xz
#PLATFORM_VERSATILE_SITE = file:///tmp
PLATFORM_VERSATILE_SOURCE =
PLATFORM_VERSATILE_LICENSE = GPLv2+
PLATFORM_VERSATILE_LICENSE_FILES = COPYING

PLATFORM_VERSATILE_PACKAGE_DIR = $(BASE_DIR)/packages/platform

ifeq ($(BR2_PACKAGE_PLATFORM_VERSATILE_AS_HOST),y)
define PLATFORM_VERSATILE_PACKAGE_INSTALL
	cp -avr package/platform_versatile/host/* $(PLATFORM_VERSATILE_PACKAGE_DIR)/etc/iopc

endef
endif

ifeq ($(BR2_PACKAGE_PLATFORM_VERSATILE_AS_GUEST),y)
define PLATFORM_VERSATILE_PACKAGE_INSTALL
	cp -avr package/platform_versatile/guest/* $(PLATFORM_VERSATILE_PACKAGE_DIR)/etc/iopc
endef
endif

define PLATFORM_VERSATILE_INSTALL_TARGET_DIR
	mkdir -p $(TARGET_DIR)/etc/iopc
	mkdir -p $(TARGET_DIR)/persist
	cp -avr $(PLATFORM_VERSATILE_PACKAGE_DIR)/etc/iopc/* $(TARGET_DIR)/etc/iopc/
endef

define PLATFORM_VERSATILE_INSTALL_TARGET_CMDS
	mkdir -p $(PLATFORM_VERSATILE_PACKAGE_DIR)/etc/iopc
	$(PLATFORM_VERSATILE_PACKAGE_INSTALL)
	$(PLATFORM_VERSATILE_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

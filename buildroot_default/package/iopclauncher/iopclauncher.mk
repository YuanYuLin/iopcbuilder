
# iopclanucher
#
################################################################################

IOPCLAUNCHER_VERSION       = 91b17bf50ef85fb3896ca70b2c9b76ffc31c9f6b
IOPCLAUNCHER_SITE          = $(call github,YuanYuLin,iopclauncher,$(IOPCLAUNCHER_VERSION))
#IOPCLAUNCHER_SITE          = file:///tmp
IOPCLAUNCHER_LICENSE       = GPLv2+
IOPCLAUNCHER_LICENSE_FILES = COPYING
#IOPCLAUNCHER_SOURCE = iopclauncher.tar.bz2

IOPCLAUNCHER_PACKAGE_DIR   = $(BASE_DIR)/packages/iopclauncher
IOPCLAUNCHER_DEPENDENCIES += libiopccommon

IOPCLAUNCHER_MAKE_ENV = \
	CROSS_COMPILE=$(TARGET_CROSS)       \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(TARGET_DIR)              \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)
#	$(TARGET_CONFIGURE_OPTS)            \
#	CFLAGS="$(TARGET_CFLAGS) $(IOPCLAUNCHER_EXTRA_CFLAGS)"

ifeq ($(BR2_PACKAGE_LIBMICROHTTPD),y)
IOPCLAUNCHER_MAKE_ENV += SUPPORT_LIBMICROHTTPD=y
IOPCLAUNCHER_DEPENDENCIES  += libmicrohttpd
endif
ifeq ($(BR2_PACKAGE_PLATFORM_AS_HOST),y)
IOPCLAUNCHER_MAKE_ENV += SUPPORT_PLATFORM_AS_HOST=y
IOPCLAUNCHER_DEPENDENCIES  += lxc
endif
ifeq ($(BR2_PACKAGE_PLATFORM_AS_GUEST),y)
IOPCLAUNCHER_MAKE_ENV += SUPPORT_PLATFORM_AS_GUEST=y
endif

define IOPCLAUNCHER_BUILD_CMDS
	$(IOPCLAUNCHER_MAKE_ENV) $(MAKE) -C $(@D)
endef

define IOPCLAUNCHER_INSTALL_TARGET_DIR
	cp -avf $(IOPCLAUNCHER_PACKAGE_DIR)/bin/iopclauncher	$(TARGET_DIR)/bin/
	rm -f $(TARGET_DIR)/init
	ln -s bin/iopclauncher $(TARGET_DIR)/init
endef

define IOPCLAUNCHER_INSTALL_TARGET_CMDS
	mkdir -p $(IOPCLAUNCHER_PACKAGE_DIR)/bin
	$(INSTALL) -m 0755 -D $(@D)/iopclauncher.elf $(IOPCLAUNCHER_PACKAGE_DIR)/bin/iopclauncher
	$(IOPCLAUNCHER_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

################################################################################
#
# libiopcmsgbus
#
################################################################################

LIBIOPCMSGBUS_VERSION       = 141ec8fa48917eb356d1e134b7ffbdbf27fc7e4e
LIBIOPCMSGBUS_SITE          = $(call github,YuanYuLin,libiopcmsgbus,$(LIBIOPCMSGBUS_VERSION))
LIBIOPCMSGBUS_LICENSE       = GPLv2+
LIBIOPCMSGBUS_LICENSE_FILES = COPYING
LIBIOPCMSGBUS_INSTALL_STAGING = YES

LIBIOPCMSGBUS_DEPENDENCIES  = host-pkgconf 

LIBIOPCMSGBUS_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \


LIBIOPCMSGBUS_MAKE_ENV =                    \
	CROSS_COMPILE=$(TARGET_CROSS)       \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(TARGET_DIR)              \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(LIBIOPCMSGBUS_EXTRA_CFLAGS)"

define LIBIOPCMSGBUS_BUILD_CMDS
	$(LIBIOPCMSGBUS_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBIOPCMSGBUS_INSTALL_STAGING_CMDS
	$(INSTALL) -m 0755 -D $(@D)/libiopcmsgbus.so* $(STAGING_DIR)/usr/lib/
	@mkdir -p $(STAGING_DIR)/usr/include/iopcmsgbus
	$(INSTALL) -m 0644 -D $(@D)/*.h $(STAGING_DIR)/usr/include/iopcmsgbus
endef

define LIBIOPCMSGBUS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/libiopcmsgbus.so $(TARGET_DIR)/usr/lib/
endef

$(eval $(generic-package))

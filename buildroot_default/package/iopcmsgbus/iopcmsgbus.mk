################################################################################
#
# iopcmsgbus
#
################################################################################

IOPCMSGBUS_VERSION       = a64edfd66317519baff44231970d12f638268677
IOPCMSGBUS_SITE          = $(call github,YuanYuLin,iopcmsgbus,$(IOPCMSGBUS_VERSION))
IOPCMSGBUS_LICENSE       = GPLv2+
IOPCMSGBUS_LICENSE_FILES = COPYING

IOPCMSGBUS_DEPENDENCIES  = host-pkgconf libiopcmsgbus

IOPCMSGBUS_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \


IOPCMSGBUS_MAKE_ENV =                       \
	CROSS_COMPILE=$(TARGET_CROSS)       \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(TARGET_DIR)              \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(IOPCMSGBUS_EXTRA_CFLAGS)"

define IOPCMSGBUS_BUILD_CMDS
	$(IOPCMSGBUS_MAKE_ENV) $(MAKE) -C $(@D)
endef

define IOPCMSGBUS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/iopcmsgbus.elf $(TARGET_DIR)/usr/local/bin/iopcmsgbus
endef

$(eval $(generic-package))

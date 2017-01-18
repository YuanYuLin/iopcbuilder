################################################################################
#
# mame4all
#
################################################################################

MAME4ALL_VERSION       = e2a26e0f78d815397e4ac7601bdc46df04285710
MAME4ALL_SITE          = $(call github,RetroPie,mame4all-pi,$(MAME4ALL_VERSION))
MAME4ALL_LICENSE       = GPLv2+
MAME4ALL_LICENSE_FILES = COPYING

MAME4ALL_DEPENDENCIES  += alsa-lib

MAME4ALL_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \


MAME4ALL_MAKE_ENV =                          \
	CROSS_COMPILE=$(TARGET_CROSS)       \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(TARGET_DIR)              \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(MAME4ALL_EXTRA_CFLAGS)"

define MAME4ALL_BUILD_CMDS
	$(MAME4ALL_MAKE_ENV) $(MAKE) -C $(@D)
endef

define MAME4ALL_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/iopccfg.elf	$(TARGET_DIR)/usr/local/bin/iopccfg
endef

$(eval $(generic-package))

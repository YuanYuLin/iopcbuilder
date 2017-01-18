################################################################################
#
# dial_server
#
################################################################################

#DIAL_SERVER_VERSION       = db2c9a171842bf871c34ce30f9579f2ce6772d6a
DIAL_SERVER_SOURCE        = dial_server.tar.bz2
DIAL_SERVER_SITE          = file:///home/vanish/data/devel/
DIAL_SERVER_LICENSE       = GPLv2+
DIAL_SERVER_LICENSE_FILES = COPYING
DIAL_SERVER_INSTALL_STAGING = YES

DIAL_SERVER_DEPENDENCIES  = 

DIAL_SERVER_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \


DIAL_SERVER_MAKE_ENV =                       \
	CROSS_COMPILE=$(TARGET_CROSS)       \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(TARGET_DIR)              \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(DIAL_SERVER_EXTRA_CFLAGS)"

define DIAL_SERVER_BUILD_CMDS
	$(DIAL_SERVER_MAKE_ENV) $(MAKE) -C $(@D)
endef

define DIAL_SERVER_INSTALL_STAGING_CMDS
endef

define DIAL_SERVER_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/dial_server.elf $(TARGET_DIR)/usr/local/bin/dial_server
endef

$(eval $(generic-package))

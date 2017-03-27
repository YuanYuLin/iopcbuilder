################################################################################
#
# libiopctaskshell
#
################################################################################

LIBIOPCTASKSHELL_VERSION       = 9b3b1cfca7d32ff65b5d5e089eec471ec0553302
LIBIOPCTASKSHELL_VERSION_MAJOR = 1
LIBIOPCTASKSHELL_VERSION_MINOR = 0
LIBIOPCTASKSHELL_SITE          = $(call github,YuanYuLin,libiopctaskshell,$(LIBIOPCTASKSHELL_VERSION))
#LIBIOPCTASKSHELL_SITE          = file:///tmp
#LIBIOPCTASKSHELL_SOURCE        = libiopctaskshell.tar.bz2
LIBIOPCTASKSHELL_LICENSE       = GPLv2+
LIBIOPCTASKSHELL_LICENSE_FILES = COPYING

LIBIOPCTASKSHELL_PACKAGE_DIR	= $(BASE_DIR)/packages/libiopctaskshell

LIBIOPCTASKSHELL_DEPENDENCIES  = libiopccommon

LIBIOPCTASKSHELL_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \


LIBIOPCTASKSHELL_MAKE_ENV =                       \
	CROSS_COMPILE=$(TARGET_CROSS)       \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(LIBIOPCTASKSHELL_PACKAGE_DIR)  \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(LIBIOPCTASKSHELL_EXTRA_CFLAGS)"

define LIBIOPCTASKSHELL_BUILD_CMDS
	$(LIBIOPCTASKSHELL_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBIOPCTASKSHELL_INSTALL_TARGET_DIR
	mkdir -p $(TARGET_DIR)/usr/local/lib/
	cp -avr $(LIBIOPCTASKSHELL_PACKAGE_DIR)/usr/local/lib/* $(TARGET_DIR)/usr/local/lib/
endef

define LIBIOPCTASKSHELL_INSTALL_TARGET_CMDS
	rm -rf $(LIBIOPCTASKSHELL_PACKAGE_DIR)
	mkdir -p $(LIBIOPCTASKSHELL_PACKAGE_DIR)/usr/local/lib/
	$(INSTALL) -m 0755 -D $(@D)/libiopctaskshell.so $(LIBIOPCTASKSHELL_PACKAGE_DIR)/usr/local/lib/
	$(LIBIOPCTASKSHELL_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

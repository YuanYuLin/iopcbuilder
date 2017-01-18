################################################################################
#
# libiopctaskmqhandler
#
################################################################################

#LIBIOPCTASKMQHANDLER_VERSION       = 29423707bd9f8759fa85dd331ce31d4612c62d26
LIBIOPCTASKMQHANDLER_VERSION_MAJOR = 1
LIBIOPCTASKMQHANDLER_VERSION_MINOR = 0
#LIBIOPCTASKMQHANDLER_SITE          = $(call github,YuanYuLin,libiopctaskmqhandler,$(LIBIOPCTASKMQHANDLER_VERSION))
LIBIOPCTASKMQHANDLER_SITE          = file:///tmp
LIBIOPCTASKMQHANDLER_SOURCE        = libiopctaskmqhandler.tar.bz2
LIBIOPCTASKMQHANDLER_LICENSE       = GPLv2+
LIBIOPCTASKMQHANDLER_LICENSE_FILES = COPYING

LIBIOPCTASKMQHANDLER_PACKAGE_DIR	= $(BASE_DIR)/packages/libiopctaskmqhandler

LIBIOPCTASKMQHANDLER_DEPENDENCIES  = libiopccommon

LIBIOPCTASKMQHANDLER_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \


LIBIOPCTASKMQHANDLER_MAKE_ENV =                       \
	CROSS_COMPILE=$(TARGET_CROSS)       \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(LIBIOPCTASKMQHANDLER_PACKAGE_DIR)  \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(LIBIOPCTASKMQHANDLER_EXTRA_CFLAGS)"

define LIBIOPCTASKMQHANDLER_BUILD_CMDS
	$(LIBIOPCTASKMQHANDLER_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBIOPCTASKMQHANDLER_INSTALL_TARGET_DIR
	cp -avr $(LIBIOPCTASKMQHANDLER_PACKAGE_DIR)/usr/local/lib/* $(TARGET_DIR)/usr/local/lib/
endef

define LIBIOPCTASKMQHANDLER_INSTALL_TARGET_CMDS
	rm -rf $(LIBIOPCTASKMQHANDLER_PACKAGE_DIR)
	mkdir -p $(LIBIOPCTASKMQHANDLER_PACKAGE_DIR)/usr/local/lib/
	$(INSTALL) -m 0755 -D $(@D)/libiopctaskmqhandler.so $(LIBIOPCTASKMQHANDLER_PACKAGE_DIR)/usr/local/lib/
	$(LIBIOPCTASKMQHANDLER_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

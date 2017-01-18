################################################################################
#
# libiopctaskhttp
#
################################################################################

#LIBIOPCTASKHTTP_VERSION       = 29423707bd9f8759fa85dd331ce31d4612c62d26
LIBIOPCTASKHTTP_VERSION_MAJOR = 1
LIBIOPCTASKHTTP_VERSION_MINOR = 0
#LIBIOPCTASKHTTP_SITE          = $(call github,YuanYuLin,libiopctaskhttp,$(LIBIOPCTASKHTTP_VERSION))
LIBIOPCTASKHTTP_SITE          = file:///tmp
LIBIOPCTASKHTTP_SOURCE        = libiopctaskhttp.tar.bz2
LIBIOPCTASKHTTP_LICENSE       = GPLv2+
LIBIOPCTASKHTTP_LICENSE_FILES = COPYING

LIBIOPCTASKHTTP_PACKAGE_DIR	= $(BASE_DIR)/packages/libiopctaskhttp

LIBIOPCTASKHTTP_DEPENDENCIES  = libiopccommon libmicrohttpd

LIBIOPCTASKHTTP_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \


LIBIOPCTASKHTTP_MAKE_ENV =                       \
	CROSS_COMPILE=$(TARGET_CROSS)       \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(LIBIOPCTASKHTTP_PACKAGE_DIR)  \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(LIBIOPCTASKHTTP_EXTRA_CFLAGS)"

define LIBIOPCTASKHTTP_BUILD_CMDS
	$(LIBIOPCTASKHTTP_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBIOPCTASKHTTP_INSTALL_TARGET_DIR
	cp -avr $(LIBIOPCTASKHTTP_PACKAGE_DIR)/usr/local/lib/* $(TARGET_DIR)/usr/local/lib/
endef

define LIBIOPCTASKHTTP_INSTALL_TARGET_CMDS
	rm -rf $(LIBIOPCTASKHTTP_PACKAGE_DIR)
	mkdir -p $(LIBIOPCTASKHTTP_PACKAGE_DIR)/usr/local/lib/
	$(INSTALL) -m 0755 -D $(@D)/libiopctaskhttp.so $(LIBIOPCTASKHTTP_PACKAGE_DIR)/usr/local/lib/
	$(LIBIOPCTASKHTTP_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

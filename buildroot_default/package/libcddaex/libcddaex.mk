################################################################################
#
# libcddaex
#
################################################################################

#LIBCDDAEX_VERSION       = 29423707bd9f8759fa85dd331ce31d4612c62d26
LIBCDDAEX_VERSION_MAJOR = 1
LIBCDDAEX_VERSION_MINOR = 0
#LIBCDDAEX_SITE          = $(call github,YuanYuLin,libcddaex,$(LIBCDDAEX_VERSION))
LIBCDDAEX_SITE          = file:///tmp
LIBCDDAEX_SOURCE        = libcddaex.tar.bz2
LIBCDDAEX_LICENSE       = GPLv2+
LIBCDDAEX_LICENSE_FILES = COPYING
LIBCDDAEX_INSTALL_STAGING = YES

LIBCDDAEX_PACKAGE_DIR	= $(BASE_DIR)/packages/libcddaex

LIBCDDAEX_DEPENDENCIES  = libiopccommon

LIBCDDAEX_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \


LIBCDDAEX_MAKE_ENV =                       \
	CROSS_COMPILE=$(TARGET_CROSS)       \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(LIBCDDAEX_PACKAGE_DIR)  \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(LIBCDDAEX_EXTRA_CFLAGS)"

define LIBCDDAEX_BUILD_CMDS
	$(LIBCDDAEX_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBCDDAEX_INSTALL_STAGING_CMDS
	$(INSTALL) -m 0755 -D $(@D)/libcddaex.so* $(STAGING_DIR)/usr/lib/
	@mkdir -p $(STAGING_DIR)/usr/include/cddaex
	$(INSTALL) -m 0644 -D $(@D)/*.h $(STAGING_DIR)/usr/include/cddaex
endef

define LIBCDDAEX_INSTALL_TARGET_DIR
	cp -avr $(LIBCDDAEX_PACKAGE_DIR)/usr/lib/* $(TARGET_DIR)/usr/lib/
endef

define LIBCDDAEX_INSTALL_TARGET_CMDS
	rm -rf $(LIBCDDAEX_PACKAGE_DIR)
	mkdir -p $(LIBCDDAEX_PACKAGE_DIR)/usr/lib/
	$(INSTALL) -m 0755 -D $(@D)/libcddaex.so $(LIBCDDAEX_PACKAGE_DIR)/usr/lib/libcddaex.so.$(LIBCDDAEX_VERSION_MAJOR).$(LIBCDDAEX_VERSION_MINOR)
	ln -s libcddaex.so.$(LIBCDDAEX_VERSION_MAJOR).$(LIBCDDAEX_VERSION_MINOR) $(LIBCDDAEX_PACKAGE_DIR)/usr/lib/libcddaex.so.$(LIBCDDAEX_VERSION_MAJOR)
	ln -s libcddaex.so.$(LIBCDDAEX_VERSION_MAJOR) $(LIBCDDAEX_PACKAGE_DIR)/usr/lib/libcddaex.so
	$(LIBCDDAEX_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

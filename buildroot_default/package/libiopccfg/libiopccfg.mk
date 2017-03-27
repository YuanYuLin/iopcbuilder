################################################################################
#
# libiopccfg
#
################################################################################

LIBIOPCCFG_VERSION       = 29423707bd9f8759fa85dd331ce31d4612c62d26
LIBIOPCCFG_VERSION_MAJOR = 1
LIBIOPCCFG_VERSION_MINOR = 0
LIBIOPCCFG_SITE          = $(call github,YuanYuLin,libiopccfg,$(LIBIOPCCFG_VERSION))
#LIBIOPCCFG_SITE          = file:///tmp
#LIBIOPCCFG_SOURCE        = libiopccfg.tar.bz2
LIBIOPCCFG_LICENSE       = GPLv2+
LIBIOPCCFG_LICENSE_FILES = COPYING
LIBIOPCCFG_INSTALL_STAGING = YES

LIBIOPCCFG_PACKAGE_DIR	= $(BASE_DIR)/packages/libiopccfg

LIBIOPCCFG_DEPENDENCIES  = host-pkgconf json-c

LIBIOPCCFG_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \


LIBIOPCCFG_MAKE_ENV =                       \
	CROSS_COMPILE=$(TARGET_CROSS)       \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(LIBIOPCCFG_PACKAGE_DIR)  \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(LIBIOPCCFG_EXTRA_CFLAGS)"

define LIBIOPCCFG_BUILD_CMDS
	$(LIBIOPCCFG_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBIOPCCFG_INSTALL_STAGING_CMDS
	$(INSTALL) -m 0755 -D $(@D)/libiopccfg.so* $(STAGING_DIR)/usr/lib/
	@mkdir -p $(STAGING_DIR)/usr/include/iopccfg
	$(INSTALL) -m 0644 -D $(@D)/*.h $(STAGING_DIR)/usr/include/iopccfg
endef

define LIBIOPCCFG_INSTALL_TARGET_DIR
	cp -avr $(LIBIOPCCFG_PACKAGE_DIR)/usr/lib/* $(TARGET_DIR)/usr/lib/
endef

define LIBIOPCCFG_INSTALL_TARGET_CMDS
	rm -rf $(LIBIOPCCFG_PACKAGE_DIR)
	mkdir -p $(LIBIOPCCFG_PACKAGE_DIR)/usr/lib/
	$(INSTALL) -m 0755 -D $(@D)/libiopccfg.so $(LIBIOPCCFG_PACKAGE_DIR)/usr/lib/libiopccfg.so.$(LIBIOPCCFG_VERSION_MAJOR).$(LIBIOPCCFG_VERSION_MINOR)
	ln -s libiopccfg.so.$(LIBIOPCCFG_VERSION_MAJOR).$(LIBIOPCCFG_VERSION_MINOR) $(LIBIOPCCFG_PACKAGE_DIR)/usr/lib/libiopccfg.so.$(LIBIOPCCFG_VERSION_MAJOR)
	ln -s libiopccfg.so.$(LIBIOPCCFG_VERSION_MAJOR) $(LIBIOPCCFG_PACKAGE_DIR)/usr/lib/libiopccfg.so
	$(LIBIOPCCFG_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

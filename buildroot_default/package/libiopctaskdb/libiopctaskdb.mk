################################################################################
#
# libiopctaskdb
#
################################################################################

#LIBIOPCTASKDB_VERSION       = 29423707bd9f8759fa85dd331ce31d4612c62d26
LIBIOPCTASKDB_VERSION_MAJOR = 1
LIBIOPCTASKDB_VERSION_MINOR = 0
#LIBIOPCTASKDB_SITE          = $(call github,YuanYuLin,libiopctaskdb,$(LIBIOPCTASKDB_VERSION))
LIBIOPCTASKDB_SITE          = file:///tmp
LIBIOPCTASKDB_SOURCE        = libiopctaskdb.tar.bz2
LIBIOPCTASKDB_LICENSE       = GPLv2+
LIBIOPCTASKDB_LICENSE_FILES = COPYING

LIBIOPCTASKDB_PACKAGE_DIR	= $(BASE_DIR)/packages/libiopctaskdb

LIBIOPCTASKDB_DEPENDENCIES  = libiopccommon

LIBIOPCTASKDB_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \


LIBIOPCTASKDB_MAKE_ENV =                       \
	CROSS_COMPILE=$(TARGET_CROSS)       \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(LIBIOPCTASKDB_PACKAGE_DIR)  \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(LIBIOPCTASKDB_EXTRA_CFLAGS)"

define LIBIOPCTASKDB_BUILD_CMDS
	$(LIBIOPCTASKDB_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBIOPCTASKDB_INSTALL_TARGET_DIR
	cp -avr $(LIBIOPCTASKDB_PACKAGE_DIR)/usr/local/lib/* $(TARGET_DIR)/usr/local/lib/
endef

define LIBIOPCTASKDB_INSTALL_TARGET_CMDS
	rm -rf $(LIBIOPCTASKDB_PACKAGE_DIR)
	mkdir -p $(LIBIOPCTASKDB_PACKAGE_DIR)/usr/local/lib/
	$(INSTALL) -m 0755 -D $(@D)/libiopctaskdb.so $(LIBIOPCTASKDB_PACKAGE_DIR)/usr/local/lib/
	$(LIBIOPCTASKDB_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

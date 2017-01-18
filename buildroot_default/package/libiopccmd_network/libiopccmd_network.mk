################################################################################
#
# libiopccmd_network
#
################################################################################

#LIBIOPCCMD_NETWORK_VERSION       = 29423707bd9f8759fa85dd331ce31d4612c62d26
LIBIOPCCMD_NETWORK_VERSION_MAJOR = 1
LIBIOPCCMD_NETWORK_VERSION_MINOR = 0
#LIBIOPCCMD_NETWORK_SITE          = $(call github,YuanYuLin,libiopccmd_network,$(LIBIOPCCMD_NETWORK_VERSION))
LIBIOPCCMD_NETWORK_SITE          = file:///tmp
LIBIOPCCMD_NETWORK_SOURCE        = libiopccmd_network.tar.bz2
LIBIOPCCMD_NETWORK_LICENSE       = GPLv2+
LIBIOPCCMD_NETWORK_LICENSE_FILES = COPYING

LIBIOPCCMD_NETWORK_PACKAGE_DIR	= $(BASE_DIR)/packages/libiopccmd_network

LIBIOPCCMD_NETWORK_DEPENDENCIES  = libiopccommon

LIBIOPCCMD_NETWORK_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \


LIBIOPCCMD_NETWORK_MAKE_ENV =                       \
	CROSS_COMPILE=$(TARGET_CROSS)       \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(LIBIOPCCMD_NETWORK_PACKAGE_DIR)  \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(LIBIOPCCMD_NETWORK_EXTRA_CFLAGS)"

define LIBIOPCCMD_NETWORK_BUILD_CMDS
	$(LIBIOPCCMD_NETWORK_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBIOPCCMD_NETWORK_INSTALL_TARGET_DIR
	cp -avr $(LIBIOPCCMD_NETWORK_PACKAGE_DIR)/usr/local/lib/* $(TARGET_DIR)/usr/local/lib/
endef

define LIBIOPCCMD_NETWORK_INSTALL_TARGET_CMDS
	rm -rf $(LIBIOPCCMD_NETWORK_PACKAGE_DIR)
	mkdir -p $(LIBIOPCCMD_NETWORK_PACKAGE_DIR)/usr/local/lib/
	$(INSTALL) -m 0755 -D $(@D)/libiopccmd_network.so $(LIBIOPCCMD_NETWORK_PACKAGE_DIR)/usr/local/lib/
	$(LIBIOPCCMD_NETWORK_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

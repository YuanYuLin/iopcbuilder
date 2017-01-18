################################################################################
#
# omxplayer
#
################################################################################

OMXPLAYER_VERSION       = 1091db2c87b480fc074fb780e507db18798a2613
OMXPLAYER_SITE          = $(call github,popcornmix,omxplayer,$(OMXPLAYER_VERSION))
OMXPLAYER_LICENSE       = GPLv2+
OMXPLAYER_LICENSE_FILES = COPYING

OMXPLAYER_DEPENDENCIES  = host-pkgconf boost dbus ffmpeg2 freetype libidn \
			  libusb pcre rpi-userland rpi-firmware zlib

OMXPLAYER_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \
	$(shell $(PKG_CONFIG_HOST_BINARY) --cflags bcm_host)    \
	$(shell $(PKG_CONFIG_HOST_BINARY) --cflags freetype2)   \
	$(shell $(PKG_CONFIG_HOST_BINARY) --cflags dbus-1)      \

# OMXplayer has support for building in Buildroot, but that
# procedure is, well, tainted. Fix this by forcing the real,
# correct values.
OMXPLAYER_MAKE_ENV =                        \
	USE_BUILDROOT=1                     \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(TARGET_DIR)              \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(OMXPLAYER_EXTRA_CFLAGS)"

define OMXPLAYER_BUILD_CMDS
	$(OMXPLAYER_MAKE_ENV) $(MAKE) -C $(@D)
endef

define OMXPLAYER_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/omxplayer.bin $(TARGET_DIR)/usr/bin/omxplayer
endef

$(eval $(generic-package))

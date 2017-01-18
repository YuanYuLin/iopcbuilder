################################################################################
#
# libmicrohttpd
#
################################################################################

LIBMICROHTTPD_VERSION = 0.9.45
LIBMICROHTTPD_SITE = $(BR2_GNU_MIRROR)/libmicrohttpd
LIBMICROHTTPD_LICENSE_FILES = COPYING
LIBMICROHTTPD_INSTALL_STAGING = YES
LIBMICROHTTPD_CONF_OPTS = --disable-curl --disable-spdy --disable-examples
LIBMICROHTTPD_PACKAGE_DIR = $(BASE_DIR)/packages/libmicrohttpd

ifeq ($(BR2_PACKAGE_LIBMICROHTTPD_SSL),y)
LIBMICROHTTPD_LICENSE = LGPLv2.1+
LIBMICROHTTPD_DEPENDENCIES += host-pkgconf gnutls libgcrypt
LIBMICROHTTPD_CONF_ENV += LIBS="`$(PKG_CONFIG_HOST_BINARY) --libs gnutls`"
LIBMICROHTTPD_CONF_OPTS += --enable-https --with-gnutls=$(STAGING_DIR)/usr \
	--with-libgcrypt-prefix=$(STAGING_DIR)/usr
else
LIBMICROHTTPD_LICENSE = LGPLv2.1+ or eCos
LIBMICROHTTPD_CONF_OPTS += --disable-https
endif

define LIBMICROHTTPD_INSTALL_TARGET_DIR
	mkdir -p $(TARGET_DIR)/usr/lib
	cp -avr $(LIBMICROHTTPD_PACKAGE_DIR)/usr/lib/libmicrohttpd.so.11 $(TARGET_DIR)/usr/lib/libmicrohttpd.so.11
	cp -avr $(LIBMICROHTTPD_PACKAGE_DIR)/usr/lib/libmicrohttpd.so $(TARGET_DIR)/usr/lib/libmicrohttpd.so
	cp -avr $(LIBMICROHTTPD_PACKAGE_DIR)/usr/lib/libmicrohttpd.so.11.34.0 $(TARGET_DIR)/usr/lib/libmicrohttpd.so.11.34.0

endef

define LIBMICROHTTPD_INSTALL_TARGET_CMDS
	mkdir -p $(LIBMICROHTTPD_PACKAGE_DIR)/usr/lib
	cp -avr $(STAGING_DIR)/usr/lib/libmicrohttpd.so.11 $(LIBMICROHTTPD_PACKAGE_DIR)/usr/lib/libmicrohttpd.so.11
	cp -avr $(STAGING_DIR)/usr/lib/libmicrohttpd.so $(LIBMICROHTTPD_PACKAGE_DIR)/usr/lib/libmicrohttpd.so
	cp -avr $(STAGING_DIR)/usr/lib/libmicrohttpd.so.11.34.0 $(LIBMICROHTTPD_PACKAGE_DIR)/usr/lib/libmicrohttpd.so.11.34.0

	$(LIBMICROHTTPD_INSTALL_TARGET_DIR)
endef

$(eval $(autotools-package))

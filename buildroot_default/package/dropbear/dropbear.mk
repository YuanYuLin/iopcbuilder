################################################################################
#
# dropbear
#
################################################################################

DROPBEAR_VERSION = 2015.71
DROPBEAR_SITE = http://matt.ucc.asn.au/dropbear/releases
DROPBEAR_SOURCE = dropbear-$(DROPBEAR_VERSION).tar.bz2
DROPBEAR_LICENSE = MIT, BSD-2c-like, BSD-2c
DROPBEAR_LICENSE_FILES = LICENSE
DROPBEAR_TARGET_BINS = dropbearkey dropbearconvert scp
DROPBEAR_PROGRAMS = dropbear $(DROPBEAR_TARGET_BINS)
DROPBEAR_PACKAGE_DIR = $(BASE_DIR)/packages/dropbear

ifeq ($(BR2_PACKAGE_DROPBEAR_CLIENT),y)
# Build dbclient, and create a convenience symlink named ssh
DROPBEAR_PROGRAMS += dbclient
DROPBEAR_TARGET_BINS += dbclient ssh
endif

DROPBEAR_MAKE = \
	$(MAKE) MULTI=1 SCPPROGRESS=1 \
	PROGRAMS="$(DROPBEAR_PROGRAMS)"

define DROPBEAR_FIX_XAUTH
	$(SED) 's,^#define XAUTH_COMMAND.*/xauth,#define XAUTH_COMMAND "/usr/bin/xauth,g' $(@D)/options.h
endef

DROPBEAR_POST_EXTRACT_HOOKS += DROPBEAR_FIX_XAUTH

define DROPBEAR_ENABLE_REVERSE_DNS
	$(SED) 's:.*\(#define DO_HOST_LOOKUP\).*:\1:' $(@D)/options.h
endef

define DROPBEAR_BUILD_SMALL
	$(SED) 's:.*\(#define NO_FAST_EXPTMOD\).*:\1:' $(@D)/options.h
endef

define DROPBEAR_BUILD_FEATURED
	$(SED) 's:^#define DROPBEAR_SMALL_CODE::' $(@D)/options.h
	$(SED) 's:.*\(#define DROPBEAR_BLOWFISH\).*:\1:' $(@D)/options.h
	$(SED) 's:.*\(#define DROPBEAR_TWOFISH128\).*:\1:' $(@D)/options.h
	$(SED) 's:.*\(#define DROPBEAR_TWOFISH256\).*:\1:' $(@D)/options.h
endef
#DROPBEAR_POST_EXTRACT_HOOKS += DROPBEAR_ENABLE_REVERSE_DNS

DROPBEAR_POST_EXTRACT_HOOKS += DROPBEAR_BUILD_FEATURED
DROPBEAR_DEPENDENCIES += zlib

#DROPBEAR_CONF_OPTS += --disable-wtmp
#DROPBEAR_CONF_OPTS += --disable-lastlog

define DROPBEAR_INSTALL_TARGET_DIR
	mkdir -p $(TARGET_DIR)/usr/sbin
	mkdir -p $(TARGET_DIR)/usr/bin
	cp -avr $(DROPBEAR_PACKAGE_DIR)/usr/sbin/dropbear $(TARGET_DIR)/usr/sbin
	for f in $(DROPBEAR_TARGET_BINS); do \
		cp -avr $(DROPBEAR_PACKAGE_DIR)/usr/bin/$$f $(TARGET_DIR)/usr/bin ; \
	done
endef

define DROPBEAR_INSTALL_TARGET_CMDS
	mkdir -p $(DROPBEAR_PACKAGE_DIR)
	mkdir -p $(DROPBEAR_PACKAGE_DIR)/usr/sbin/
	mkdir -p $(DROPBEAR_PACKAGE_DIR)/usr/bin/
	mkdir -p $(DROPBEAR_PACKAGE_DIR)/etc/dropbear
	$(INSTALL) -m 755 $(@D)/dropbearmulti $(DROPBEAR_PACKAGE_DIR)/usr/sbin/dropbear
	for f in $(DROPBEAR_TARGET_BINS); do \
		ln -snf ../sbin/dropbear $(DROPBEAR_PACKAGE_DIR)/usr/bin/$$f ; \
	done
#	ln -snf /var/run/dropbear $(DROPBEAR_PACKAGE_DIR)/etc/dropbear
	$(DROPBEAR_INSTALL_TARGET_DIR)
endef

$(eval $(autotools-package))

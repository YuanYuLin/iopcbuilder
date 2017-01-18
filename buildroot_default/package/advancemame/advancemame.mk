################################################################################
#
## Advance MAME
#
#################################################################################
#ADVANCEMAME_
ADVANCEMAME_VERSION = 1.4
#ADVANCEMAME_SITE = ftp://ftp.mirrorservice.org/sites/downloads.sourceforge.net/a/ad/advancemame/advancemame/$(ADVANCEMAME_VERSION)/advancemame-$(ADVANCEMAME_VERSION).tar.gz
ADVANCEMAME_SITE = https://github.com/amadvance/advancemame/releases/download/advancemame-$(ADVANCEMAME_VERSION)
ADVANCEMAME_DEPENDENCIES += alsa-lib

ADVANCEMAME_LICENSE = GPLv2
ADVANCEMAME_LICENSE_FILES = COPYING
ADVANCEMAME_INSTALL_STAGING = YES
ADVANCEMAME_AUTORECONF = YES

ADVANCEMAME_PACKAGE_DIR  = $(BASE_DIR)/packages/advancemame

ADVANCEMAME_CONF_OPTS = --exec-prefix=$(ADVANCEMAME_PACKAGE_DIR) --prefix=$(ADVANCEMAME_PACKAGE_DIR)

ADVANCEMAME_TARGETS_ =
ADVANCEMAME_TARGETS_y =

ADVANCEMAME_TARGETS_y += bin/advmame

define ADVANCEMAME_INSTALL_TARGET_CMDS
	$(Q)mkdir -p $(TARGET_DIR)/usr/bin
	$(Q)for file in $(ADVANCEMAME_TARGETS_y); do 	\
	$(INSTALL) -m 0755 $(ADVANCEMAME_PACKAGE_DIR)/$$file $(TARGET_DIR)/usr/bin; 	\
	done
endef

$(eval $(autotools-package))


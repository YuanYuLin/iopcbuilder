################################################################################
#
# mdadm
#
################################################################################

MDADM_VERSION = 3.3.4
MDADM_SOURCE = mdadm-$(MDADM_VERSION).tar.xz
MDADM_SITE = $(BR2_KERNEL_MIRROR)/linux/utils/raid/mdadm
MDADM_LICENSE = GPLv2+
MDADM_LICENSE_FILES = COPYING

MDADM_PACKAGE_DIR = $(BASE_DIR)/packages/mdadm

MDADM_MAKE_OPTS = \
	CFLAGS="$(TARGET_CFLAGS)" CC="$(TARGET_CC)" CHECK_RUN_DIR=0 -C $(MDADM_DIR) mdadm

#MDADM_INSTALL_TARGET_OPTS = \
	DESTDIR=$(MDADM_PACKAGE_DIR)/usr -C $(MDADM_DIR) install-mdadm

define MDADM_INSTALL_TARGET_DIR
	mkdir -p $(TARGET_DIR)/usr/sbin
	cp -avr $(MDADM_PACKAGE_DIR)/usr/sbin/mdadm $(TARGET_DIR)/usr/sbin/
endef

define MDADM_INSTALL_TARGET_CMDS
	$(MDADM_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(MDADM_PACKAGE_DIR)/usr install-mdadm

	$(MDADM_INSTALL_TARGET_DIR)
endef

define MDADM_CONFIGURE_CMDS
	# Do nothing
endef

$(eval $(autotools-package))

################################################################################
#
# initscripts
#
################################################################################

# source included in buildroot
INITSCRIPTS_SOURCE =

INITSCRIPTS_PACKAGE_DIR = $(BASE_DIR)/packages/initscripts

define INITSCRIPTS_INSTALL_TARGET_DIR
	cp -avr $(INITSCRIPTS_PACKAGE_DIR)/* $(TARGET_DIR)/
endef

define INITSCRIPTS_INSTALL_TARGET_CMDS
	mkdir -p  $(INITSCRIPTS_PACKAGE_DIR)/etc
	ln -s /tmp/resolv.conf $(INITSCRIPTS_PACKAGE_DIR)/etc/resolv.conf
	mkdir -p $(INITSCRIPTS_PACKAGE_DIR)/proc
	mkdir -p $(INITSCRIPTS_PACKAGE_DIR)/mnt
	mkdir -p $(INITSCRIPTS_PACKAGE_DIR)/sys

	$(INITSCRIPTS_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

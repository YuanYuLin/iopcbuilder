################################################################################
#
# libiopccfg_host
#
################################################################################

LIBIOPCCFG_HOST_VERSION       = ba4d35563a631f1f34cd9b70fc3debaf64e09838
LIBIOPCCFG_HOST_SITE          = $(call github,YuanYuLin,libiopccfg_host,$(LIBIOPCCFG_HOST_VERSION))
LIBIOPCCFG_HOST_LICENSE       = GPLv2+
LIBIOPCCFG_HOST_LICENSE_FILES = COPYING

LIBIOPCCFG_HOST_DEPENDENCIES  = iopccfg


define LIBIOPCCFG_HOST_INSTALL_TARGET_CMDS

	mkdir -p $(TARGET_DIR)/iopc/defconfig/
	cp -avr $(@D)/def_cfgs/*	$(TARGET_DIR)/iopc/defconfig/

	mkdir -p $(TARGET_DIR)/iopc/scripts/
	$(INSTALL) -m 0755 -D $(@D)/scripts/*	$(TARGET_DIR)/iopc/scripts/

	mkdir -p $(TARGET_DIR)/iopc/www/
	cp -avr $(@D)/www/*	$(TARGET_DIR)/iopc/www/
endef

define LIBIOPCCFG_HOST_INSTALL_INIT_SYSTEMD
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants 

	$(INSTALL) -D -m 644 $(@D)/systemd/network.service $(TARGET_DIR)/etc/systemd/system/network.service
	ln -fs ../network.service $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/network.service

	$(INSTALL) -D -m 644 $(@D)/systemd/vm.service $(TARGET_DIR)/etc/systemd/system/vm.service
	ln -fs ../vm.service $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/vm.service

	$(INSTALL) -D -m 644 $(@D)/systemd/lighttpd.service $(TARGET_DIR)/etc/systemd/system/lighttpd.service
	ln -fs ../lighttpd.service $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/lighttpd.service

	$(INSTALL) -D -m 644 $(@D)/systemd/webservercfg.service $(TARGET_DIR)/etc/systemd/system/webservercfg.service
	ln -fs ../webservercfg.service $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/webservercfg.service
endef

$(eval $(generic-package))

################################################################################
#
# lxc
#
################################################################################

LXC_VERSION = 1.1.4
LXC_SITE = https://linuxcontainers.org/downloads
LXC_LICENSE = LGPLv2.1+
LXC_LICENSE_FILES = COPYING
LXC_DEPENDENCIES = libcap host-pkgconf
LXC_PACKAGE_DIR = $(BASE_DIR)/packages/lxc
# we're patching configure.ac
LXC_AUTORECONF = YES
#LXC_INSTALL_STAGING = YES
LXC_CONF_OPTS = --disable-apparmor --with-distro=buildroot \
	--disable-lua --disable-python --disable-examples \
	$(if $(BR2_PACKAGE_BASH),,--disable-bash)
#--disable-examples
#LXC_INSTALL_TARGET_OPTS = DESTDIR=$(LXC_PACKAGE_DIR) -C $(LXC_DIR) install

#define LXC_INSTALL_STAGING_CMDS
#	cp -avr $(LXC_PACKAGE_DIR)/usr/include/* $(STAGING_DIR)/usr/include/
#	cp -avr $(LXC_PACKAGE_DIR)/usr/lib/* $(STAGING_DIR)/usr/lib/
#endef

define LXC_INSTALL_TARGET_DIR
	mkdir -p $(TARGET_DIR)/usr/bin
	cp -avr $(LXC_PACKAGE_DIR)/usr/bin/* $(TARGET_DIR)/usr/bin/

	mkdir -p $(TARGET_DIR)/usr/lib
	cp -avr $(LXC_PACKAGE_DIR)/usr/lib/liblxc.so* $(TARGET_DIR)/usr/lib/

	mkdir -p $(TARGET_DIR)/usr/libexec
	cp -avr $(LXC_PACKAGE_DIR)/usr/libexec/* $(TARGET_DIR)/usr/libexec/

	mkdir -p $(TARGET_DIR)/usr/sbin
	cp -avr $(LXC_PACKAGE_DIR)/usr/sbin/init.lxc $(TARGET_DIR)/usr/sbin/

	mkdir -p $(TARGET_DIR)/usr/share/lxc/
	cp -avr $(LXC_PACKAGE_DIR)/usr/share/lxc/lxc.functions $(TARGET_DIR)/usr/share/lxc/lxc.functions

	mkdir -p $(TARGET_DIR)/var/
	cp -avr $(LXC_PACKAGE_DIR)/var/* $(TARGET_DIR)/var/

	cp -avr $(LXC_PACKAGE_DIR)/usr/include/* $(STAGING_DIR)/usr/include/
	cp -avr $(LXC_PACKAGE_DIR)/usr/lib/* $(STAGING_DIR)/usr/lib/
#endef
endef

define LXC_INSTALL_TARGET_CMDS
	$(LXC_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(LXC_PACKAGE_DIR) install

	$(LXC_INSTALL_TARGET_DIR)
endef


$(eval $(autotools-package))

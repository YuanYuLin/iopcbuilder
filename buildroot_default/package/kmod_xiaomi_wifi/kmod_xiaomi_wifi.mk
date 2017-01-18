################################################################################
#
# kmod_xiaomi_wifi
#
################################################################################

KMOD_XIAOMI_WIFIVERSION       = 982005acde1d72e4e0666c2e364d536b7fb6be57
KMOD_XIAOMI_WIFI_SITE          = $(call github,imZack,mt7601,$(KMOD_XIAOMI_WIFIVERSION))
KMOD_XIAOMI_WIFI_LICENSE       = GPLv2+
KMOD_XIAOMI_WIFI_LICENSE_FILES = COPYING

KMOD_XIAOMI_WIFIDEPENDENCIES  = linux


define KMOD_XIAOMI_WIFI_BUILD_CMDS
	export ARCH=arm && \
	export LINUX_SRC=$(LINUX_DIR) && \
	export CROSS_COMPILE=$(TARGET_CROSS) && \
	cd $(@D)/src && \
	make
endef

define KMOD_XIAOMI_WIFI_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/lib/modules/exdrivers/
	mkdir -p $(TARGET_DIR)/etc/Wireless/RT2870STA/
	cp $(@D)/src/os/linux/mt7601Usta.ko $(TARGET_DIR)/lib/modules/exdrivers/
	cp $(@D)/src/RT2870STA.dat $(TARGET_DIR)/etc/Wireless/RT2870STA/RT2870STA.dat
endef

#define KMOD_XIAOMI_WIFI_UNINSTALL_TARGET_CMDS
#        rm -rf $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/$(KMOD_XIAOMI_WIFIINSTALL_MOD_DIR)
#endef

$(eval $(generic-package))

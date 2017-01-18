################################################################################
#
# webgui
#
################################################################################

WEBGUI_VERSION       = b310650de540855ab8f4b239fa34dad21a0c31ff
WEBGUI_SITE          = $(call github,YuanYuLin,webgui,$(WEBGUI_VERSION))
WEBGUI_LICENSE       = GPLv2+
WEBGUI_LICENSE_FILES = COPYING

WEBGUI_DEPENDENCIES  = lighttpd

define WEBGUI_INSTALL_TARGET_CMDS
	@cp -avr $(@D)/* $(TARGET_DIR)/var/www/
endef

$(eval $(generic-package))

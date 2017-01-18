################################################################################
#
# webkitdfb
#
################################################################################

WEBKITDFB_VERSION = c93583f
WEBKITDFB_SOURCE = WebKitDFB-$(WEBKITDFB_VERSION).tar.gz
WEBKITDFB_SITE = file:///home/vanish/data/devel/iopc/buildsystem/dl/
WEBKITDFB_LICENSE = GPLv2
WEBKITDFB_LICENSE_FILES = LICENSE
WEBKITDFB_DEPENDENCIES = directfb lite sqlite libxml2 libxslt icu libglib2 libcurl harfbuzz


WEBKITDFB_CONF_OPTS += -DCMAKE_SYSTEM_PROCESSOR=arm
WEBKITDFB_CONF_OPTS += -DWITH_XKBFILE=OFF
WEBKITDFB_CONF_OPTS += -DPORT=DirectFB
WEBKITDFB_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release
WEBKITDFB_CONF_OPTS += -DUSE_ILIXI=OFF
WEBKITDFB_CONF_OPTS += -DENABLE_FUSIONDALE=OFF
WEBKITDFB_CONF_OPTS += -DDLADDR=OFF
WEBKITDFB_CONF_OPTS += -DCAIRO_HAS_DIRECTFB_SURFACE=1
WEBKITDFB_CONF_OPTS += -DENABLE_WEBGL=OFF

define WEBKITDFB_INSTALL_TARGET_CMDS
        $(INSTALL) -m 0755 -D $(@D)/iopccfg.elf $(TARGET_DIR)/usr/local/bin/
endef

$(eval $(cmake-package))

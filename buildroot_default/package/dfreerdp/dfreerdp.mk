################################################################################
#
# dfreerdp
#
################################################################################

DFREERDP_VERSION = 1.0.2
DFREERDP_SOURCE = $(DFREERDP_VERSION).tar.gz
DFREERDP_SITE = https://github.com/FreeRDP/FreeRDP/archive
DFREERDP_DEPENDENCIES = openssl zlib directfb alsa-lib
DFREERDP_LICENSE = Apache-2.0
DFREERDP_LICENSE_FILES = LICENSE

DFREERDP_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release

DFREERDP_CONF_OPTS += -DWITH_FFMPEG=OFF
DFREERDP_CONF_OPTS += -DWITH_XINERAMA=OFF 
DFREERDP_CONF_OPTS += -DWITH_XCURSOR=OFF 
DFREERDP_CONF_OPTS += -DWITH_DIRECTFB=ON 

DFREERDP_CONF_OPTS += -DWITH_ALSA=ON
DFREERDP_CONF_OPTS += -DWITH_PULSEAUDIO=OFF
DFREERDP_CONF_OPTS += -DWITH_PCSC=OFF
DFREERDP_CONF_OPTS += -DWITH_CUPS=OFF
DFREERDP_CONF_OPTS += -DWITH_X11=OFF
DFREERDP_CONF_OPTS += -DWITH_XKBFILE=OFF
$(eval $(cmake-package))

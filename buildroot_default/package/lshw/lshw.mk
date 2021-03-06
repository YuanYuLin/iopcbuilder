################################################################################
#
# lshw
#
################################################################################

LSHW_VERSION = B.02.16
LSHW_SITE = http://ezix.org/software/files
LSHW_LICENSE = GPLv2
LSHW_LICENSE_FILES = COPYING

LSHW_PACKAGE_DIR = $(BASE_DIR)/packages/lshw

LSHW_CFLAGS = $(TARGET_CFLAGS)
ifeq ($(BR2_ENABLE_LOCALE),)
LSHW_CFLAGS += -DNONLS
endif

LSHW_MAKE_OPTS = CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" AR="$(TARGET_AR)" \
	RPM_OPT_FLAGS="$(LSHW_CFLAGS)" all
LSHW_MAKE_ENV = LIBS="$(if $(BR2_NEEDS_GETTEXT_IF_LOCALE),-lintl)"
LSHW_DEPENDENCIES = $(if $(BR2_NEEDS_GETTEXT_IF_LOCALE),gettext)

define LSHW_BUILD_CMDS
	$(LSHW_MAKE_ENV) $(MAKE) -C $(@D)/src $(LSHW_MAKE_OPTS)
endef

define LSHW_INSTALL_TARGET_DIR
	cp -avr $(LSHW_PACKAGE_DIR)/* $(TARGET_DIR)/
endef

define LSHW_INSTALL_TARGET_CMDS
	$(LSHW_MAKE_ENV) $(MAKE) -C $(@D)/src DESTDIR=$(LSHW_PACKAGE_DIR) \
		$(LSHW_MAKE_OPTS) install

	$(LSHW_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

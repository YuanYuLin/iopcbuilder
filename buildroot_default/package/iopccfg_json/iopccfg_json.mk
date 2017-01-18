################################################################################
#
# iopccfg_json
#
################################################################################

#IOPCCFG_JSON_VERSION       = 5787182c973b086a81e550177af3e1a8e2e73eec
#IOPCCFG_JSON_SITE          = $(call github,YuanYuLin,iopccfg_json,$(IOPCCFG_JSON_VERSION))
IOPCCFG_JSON_SITE          = file:///tmp
IOPCCFG_JSON_SOURCE        = iopccfg_json.tar.bz2
IOPCCFG_JSON_LICENSE       = GPLv2+
IOPCCFG_JSON_LICENSE_FILES = COPYING

IOPCCFG_JSON_DEPENDENCIES  = host-pkgconf libiopccommon
IOPCCFG_JSON_PACKAGE_DIR  = $(BASE_DIR)/packages/iopccfg_json

IOPCCFG_JSON_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \


IOPCCFG_JSON_MAKE_ENV =                          \
	CROSS_COMPILE=$(TARGET_CROSS)       \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(IOPCCFG_JSON_PACKAGE_DIR)     \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(IOPCCFG_JSON_EXTRA_CFLAGS)"

define IOPCCFG_JSON_BUILD_CMDS
	$(IOPCCFG_JSON_MAKE_ENV) $(MAKE) -C $(@D)
endef

define IOPCCFG_JSON_INSTALL_TARGET_DIR
	cp -avr $(IOPCCFG_JSON_PACKAGE_DIR)/usr/local/bin/iopccfg_json $(TARGET_DIR)/usr/local/bin/iopccfg_json
endef

define IOPCCFG_JSON_INSTALL_TARGET_CMDS
	mkdir -p $(IOPCCFG_JSON_PACKAGE_DIR)/usr/local/bin/
	$(INSTALL) -m 0755 -D $(@D)/iopccfg_json.elf	$(IOPCCFG_JSON_PACKAGE_DIR)/usr/local/bin/iopccfg_json
	$(IOPCCFG_JSON_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

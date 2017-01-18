################################################################################
#
# iopccfg
#
################################################################################

#IOPCCFG_VERSION       = 5787182c973b086a81e550177af3e1a8e2e73eec
#IOPCCFG_SITE          = $(call github,YuanYuLin,iopccfg,$(IOPCCFG_VERSION))
IOPCCFG_SITE          = file:///tmp
IOPCCFG_SOURCE        = iopccfg.tar.bz2
IOPCCFG_LICENSE       = GPLv2+
IOPCCFG_LICENSE_FILES = COPYING

IOPCCFG_DEPENDENCIES  = host-pkgconf libiopccommon
IOPCCFG_PACKAGE_DIR  = $(BASE_DIR)/packages/iopccfg

IOPCCFG_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \


IOPCCFG_MAKE_ENV =                          \
	CROSS_COMPILE=$(TARGET_CROSS)       \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(IOPCCFG_PACKAGE_DIR)     \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(IOPCCFG_EXTRA_CFLAGS)"

define IOPCCFG_BUILD_CMDS
	$(IOPCCFG_MAKE_ENV) $(MAKE) -C $(@D)
endef

define IOPCCFG_INSTALL_TARGET_DIR
	cp -avr $(IOPCCFG_PACKAGE_DIR)/usr/local/bin/iopccfg $(TARGET_DIR)/usr/local/bin/iopccfg
endef

define IOPCCFG_INSTALL_TARGET_CMDS
	mkdir -p $(IOPCCFG_PACKAGE_DIR)/usr/local/bin/
	$(INSTALL) -m 0755 -D $(@D)/iopccfg.elf	$(IOPCCFG_PACKAGE_DIR)/usr/local/bin/iopccfg
	$(IOPCCFG_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

################################################################################
#
# iopccfg_bdb
#
################################################################################

IOPCCFG_BDB_VERSION       = 7569dada006fe217aa6253f5448d3f764d9b9e60
IOPCCFG_BDB_SITE          = $(call github,YuanYuLin,iopccfg_bdb,$(IOPCCFG_BDB_VERSION))
#IOPCCFG_BDB_SITE          = file:///tmp
#IOPCCFG_BDB_SOURCE        = iopccfg_bdb.tar.bz2
IOPCCFG_BDB_LICENSE       = GPLv2+
IOPCCFG_BDB_LICENSE_FILES = COPYING

IOPCCFG_BDB_DEPENDENCIES  = host-pkgconf libiopccommon
IOPCCFG_BDB_PACKAGE_DIR  = $(BASE_DIR)/packages/iopccfg_bdb

IOPCCFG_BDB_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \


IOPCCFG_BDB_MAKE_ENV =                          \
	CROSS_COMPILE=$(TARGET_CROSS)       \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(IOPCCFG_BDB_PACKAGE_DIR)     \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(IOPCCFG_BDB_EXTRA_CFLAGS)"

define IOPCCFG_BDB_BUILD_CMDS
	$(IOPCCFG_BDB_MAKE_ENV) $(MAKE) -C $(@D)
endef

define IOPCCFG_BDB_INSTALL_TARGET_DIR
	mkdir -p $(TARGET_DIR)/usr/local/bin/
	cp -avr $(IOPCCFG_BDB_PACKAGE_DIR)/usr/local/bin/iopccfg_bdb $(TARGET_DIR)/usr/local/bin/iopccfg_bdb
endef

define IOPCCFG_BDB_INSTALL_TARGET_CMDS
	mkdir -p $(IOPCCFG_BDB_PACKAGE_DIR)/usr/local/bin/
	$(INSTALL) -m 0755 -D $(@D)/iopccfg_bdb.elf	$(IOPCCFG_BDB_PACKAGE_DIR)/usr/local/bin/iopccfg_bdb
	$(IOPCCFG_BDB_INSTALL_TARGET_DIR)
endef

$(eval $(generic-package))

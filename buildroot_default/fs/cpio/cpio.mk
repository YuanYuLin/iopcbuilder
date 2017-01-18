################################################################################
#
# cpio to archive target filesystem
#
################################################################################

# devtmpfs does not get automounted when initramfs is used.
# Add a pre-init script to mount it before running init
define ROOTFS_CPIO_ADD_INIT
	@echo "============================================"
	@echo "ELSE"
	@echo "============================================"
	if [ ! -e $(TARGET_DIR)/init ]; then \
		$(INSTALL) -m 0755 fs/cpio/init $(TARGET_DIR)/init; \
	fi
endef
PACKAGES_PERMISSIONS_TABLE += /dev/console c 622 0 0 5 1 - - -$(sep)

ifeq ($(BR2_ROOTFS_DEVICE_CREATION_STATIC),y)
define ROOTFS_CPIO_ADD_INIT
	@echo "============================================"
	@echo "STATIC"
	@echo "============================================"
	if [ ! -e $(TARGET_DIR)/init ]; then \
		ln -sf sbin/init $(TARGET_DIR)/init; \
	fi
endef
endif

ifeq ($(BR2_TARGET_ROOTFS_CHROOT),y)
define ROOTFS_CPIO_ADD_INIT
	@echo "============================================"
	@echo "CHROOT"
	@echo "============================================"
	if [ ! -e $(TARGET_DIR)/init ]; then \
		$(INSTALL) -m 0755 fs/cpio/init_chroot $(TARGET_DIR)/init; \
	fi
endef
endif

ifeq ($(BR2_TARGET_ROOTFS_IOPCLAUNCHER),y)
define ROOTFS_CPIO_ADD_INIT
	@echo "============================================"
	@echo "IOPCLAUNCHER"
	@echo "============================================"
	rm -f $(TARGET_DIR)/init
	if [ ! -e $(TARGET_DIR)/init ]; then \
		ln -sf bin/iopclauncher $(TARGET_DIR)/init; \
	fi
endef
endif

ifeq ($(BR2_TARGET_ROOTFS_GOBOX),y)
define ROOTFS_CPIO_ADD_INIT
	@echo "============================================"
	@echo "GOBOX"
	@echo "============================================"
	rm $(TARGET_DIR)/init
	if [ ! -e $(TARGET_DIR)/init ]; then \
		ln -sf bin/gobox $(TARGET_DIR)/init; \
	fi
endef
endif

ROOTFS_CPIO_PRE_GEN_HOOKS += ROOTFS_CPIO_ADD_INIT

define ROOTFS_CPIO_CMD
	cd $(TARGET_DIR) && find . | cpio --quiet -o -H newc > $@
endef

$(BINARIES_DIR)/rootfs.cpio.uboot: $(BINARIES_DIR)/rootfs.cpio host-uboot-tools
	$(MKIMAGE) -A $(MKIMAGE_ARCH) -T ramdisk \
		-C none -d $<$(ROOTFS_CPIO_COMPRESS_EXT) $@

ifeq ($(BR2_TARGET_ROOTFS_CPIO_UIMAGE),y)
ROOTFS_CPIO_POST_TARGETS += $(BINARIES_DIR)/rootfs.cpio.uboot
endif

$(eval $(call ROOTFS_TARGET,cpio))

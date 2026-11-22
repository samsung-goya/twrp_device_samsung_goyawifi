# SPDX-License-Identifier: GPL-3.0-or-later
#
# Custom recovery.img / boot.img packer for Samsung Galaxy Tab 3 Lite 7.0 (goyawifi).
# Packs prebuilt zImage + DTB + /chosen/bootargs + ramdisk for Samsung S-Boot.

GOYA_MKBOOTIMG := $(DEVICE_PATH)/bootimg/goyawifi-mkbootimg.py
GOYA_KERNEL_DTB := $(TARGET_PREBUILT_DTB)

define build-goyawifi-bootimg
	$(hide) python3 $(GOYA_MKBOOTIMG) \
		--kernel $(1) \
		--dtb $(GOYA_KERNEL_DTB) \
		--ramdisk $(2) \
		--cmdline "$(INTERNAL_KERNEL_CMDLINE)" \
		--base $(BOARD_KERNEL_BASE) \
		--kernel_offset $(BOARD_KERNEL_OFFSET) \
		--ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
		--second_offset $(BOARD_SECOND_OFFSET) \
		--tags_offset $(BOARD_TAGS_OFFSET) \
		--pagesize $(BOARD_KERNEL_PAGESIZE) \
		-o $(3)
endef

$(INSTALLED_BOOTIMAGE_TARGET): $(INTERNAL_BOOTIMAGE_FILES) $(GOYA_MKBOOTIMG) $(GOYA_KERNEL_DTB) $(MKBOOTIMG)
	$(call pretty,"Target boot image: $@")
	$(call build-goyawifi-bootimg,$(INSTALLED_KERNEL_TARGET),$(INSTALLED_RAMDISK_TARGET),$@)
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)

$(INSTALLED_RECOVERYIMAGE_TARGET): $(recovery_ramdisk) $(recovery_kernel) $(GOYA_KERNEL_DTB) $(RECOVERYIMAGE_EXTRA_DEPS) $(GOYA_MKBOOTIMG)
	@echo "----- Making TWRP recovery image (XZ ramdisk) ------"
	$(hide) if [ "$$(/usr/bin/head -c 2 $(recovery_ramdisk) | /usr/bin/od -An -tx1 | tr -d ' \n')" = "1f8b" ]; then \
		/usr/bin/gzip -dc $(recovery_ramdisk) | /usr/bin/xz --check=crc32 -9 -T0 > $(recovery_ramdisk).xz; \
	else \
		cp $(recovery_ramdisk) $(recovery_ramdisk).xz; \
	fi
	$(call build-goyawifi-bootimg,$(recovery_kernel),$(recovery_ramdisk).xz,$@)
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)

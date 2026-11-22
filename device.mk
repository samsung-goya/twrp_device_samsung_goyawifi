# SPDX-License-Identifier: GPL-3.0-or-later
#
# Device configuration for TWRP on Samsung Galaxy Tab 3 Lite 7.0 Wi-Fi (SM-T110 / goyawifi)

LOCAL_PATH := device/samsung/goyawifi

# Screen & Density
PRODUCT_AAPT_CONFIG := normal large xlarge mdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

# System properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.adb.secure=0 \
    ro.sf.lcd_density=160 \
    ro.sf.hwrotation=270 \
    ro.minui.default_rotation=ROTATION_LEFT \
    persist.sys.usb.config=mtp,adb

# F2FS & filesystem utilities
PRODUCT_PACKAGES += \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs

# Recovery init & ueventd scripts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.pxa988.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.pxa988.rc \
    $(LOCAL_PATH)/recovery/root/ueventd.pxa988.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.pxa988.rc

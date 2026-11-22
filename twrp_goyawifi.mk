# SPDX-License-Identifier: GPL-3.0-or-later
#
# Modern TWRP product configuration for Samsung Galaxy Tab 3 Lite 7.0 Wi-Fi (SM-T110 / goyawifi)

# Inherit base AOSP & TWRP common configurations
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit device-specific configuration
$(call inherit-product, device/samsung/goyawifi/device.mk)

# Product identity
PRODUCT_NAME := twrp_goyawifi
PRODUCT_DEVICE := goyawifi
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_MODEL := SM-T110

PRODUCT_CHARACTERISTICS := tablet

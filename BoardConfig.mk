#
# Copyright 2017 - 2022 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

COMMON_PATH := device/google/taimen

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a73

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a73

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := taimen
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true #?

# Crypto
BOARD_USES_QCOM_FBE_DECRYPTION := true
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

#Kernel
BOARD_KERNEL_CMDLINE += console=ttyMSM0,115200,n8 earlycon=msm_serial_dm,0xc1b0000
BOARD_KERNEL_CMDLINE += androidboot.hardware=$(TARGET_BOOTLOADER_BOARD_NAME) androidboot.console=ttyMSM0 lpm_levels.sleep_disabled=1
BOARD_KERNEL_CMDLINE += user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3
BOARD_KERNEL_CMDLINE += service_locator.enable=1
BOARD_KERNEL_CMDLINE += swiotlb=2048
BOARD_KERNEL_CMDLINE += firmware_class.path=/vendor/firmware
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += raid=noautodetect
BOARD_KERNEL_CMDLINE += usbcore.autosuspend=7
BOARD_KERNEL_CMDLINE += androidboot.dtbo_idx=12

BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000 #?
BOARD_RAMDISK_OFFSET     := 0x02000000 #?

BOARD_RAMDISK_USE_XZ := true
TARGET_NO_BOOTLOADER ?= true
TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := true
TARGET_RECOVERY_DENSITY := xhdpi
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_USES_METADATA_PARTITION := true

BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
TARGET_PREBUILT_KERNEL := $(COMMON_PATH)/kernel/Image.gz-dtb

# Platform
TARGET_BOARD_PLATFORM := msm8998
TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_BOARD_PLATFORM_GPU := qcom-adreno540 #?

# Partitions
TARGET_RECOVERY_WIPE := device/google/taimen/recovery.wipe
TARGET_RECOVERY_FSTAB := device/google/taimen/recovery.fstab

BOARD_FLASH_BLOCK_SIZE := 131072

BOARD_BOOTIMAGE_PARITION_SIZE := 41943040
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2684354560
BOARD_SYSTEMIMAGE_JOURNAL_SIZE := 0
ifneq ($(PRODUCT_INCREASE_INODE_COUNT),true)
BOARD_SYSTEMIMAGE_EXTFS_INODE_COUNT := 5120
else
BOARD_SYSTEMIMAGE_EXTFS_INODE_COUNT := 8192
endif
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 26503790080
BOARD_VENDORIMAGE_PARTITION_SIZE := 524288000

TARGET_USERIMAGES_USE_EXT4 := true

BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Recovery
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
#BOARD_HAS_LARGE_FILESYSTEM := true?
#BOARD_HAS_NO_SELECT_BUTTON := true?
BOARD_SUPPRESS_SECURE_ERASE := true

# TWRP specific build flags
BOARD_HAS_NO_REAL_SDCARD := true
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
#TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"?
#TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file?
#TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"?
TW_DEFAULT_BRIGHTNESS := "80"
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true?
#TW_INCLUDE_NTFS_3G := true?
TW_THEME := portrait_hdpi
TW_INCLUDE_CRYPTO := true
#TW_INCLUDE_RESETPROP := true?
TW_USE_TOOLBOX := true
#TW_HAS_EDL_MODE := true?
TW_OVERRIDE_SYSTEM_PROPS := "ro.build.version.security_patch;ro.build.version.release"
TW_INCLUDE_REPACKTOOLS := true

# TWRP Debug Flags
TWRP_INCLUDE_LOGCAT:= true
TARGET_USES_LOGD := true
TARGET_RECOVERY_DEVICE_MODULES += debuggerd
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/debuggerd
TARGET_RECOVERY_DEVICE_MODULES += strace
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/strace


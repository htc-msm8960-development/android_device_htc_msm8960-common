# Copyright 2006 The Android Open Source Project

ifeq ($(BOARD_PROVIDES_LIBRIL),true)
ifeq ($(TARGET_BOARD_PLATFORM),msm8960)
ifeq ($(BOARD_VENDOR),htc)

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_VENDOR_MODULE := true

LOCAL_SRC_FILES:= \
    ril.cpp \
    ril_event.cpp\
    RilSapSocket.cpp \
    ril_service.cpp \
    sap_service.cpp

LOCAL_SHARED_LIBRARIES := \
    liblog \
    libutils \
    libcutils \
    libhardware_legacy \
    librilutils \
    android.hardware.radio@1.0 \
    android.hardware.radio@1.1 \
    libhidlbase \

LOCAL_STATIC_LIBRARIES := \
    libprotobuf-c-nano-enable_malloc-32bit \

LOCAL_CFLAGS += -Wall -Wextra -Wno-unused-parameter -Werror
LOCAL_CFLAGS += -DPB_FIELD_32BIT

ifeq ($(SIM_COUNT), 2)
    LOCAL_CFLAGS += -DANDROID_MULTI_SIM -DDSDA_RILD1
    LOCAL_CFLAGS += -DANDROID_SIM_COUNT_2
endif

ifneq ($(DISABLE_RILD_OEM_HOOK),)
    LOCAL_CFLAGS += -DOEM_HOOK_DISABLED
endif

ifneq ($(TARGET_USES_OLD_MNC_FORMAT),)
    LOCAL_CFLAGS += -DOLD_MNC_FORMAT
endif

LOCAL_C_INCLUDES += external/nanopb-c
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../include
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/../include

LOCAL_MODULE:= libril
LOCAL_LICENSE_KINDS:= SPDX-license-identifier-Apache-2.0
LOCAL_LICENSE_CONDITIONS:= notice
LOCAL_NOTICE_FILE:= $(LOCAL_PATH)/NOTICE
LOCAL_SANITIZE := integer

include $(BUILD_SHARED_LIBRARY)

endif # BOARD_VENDOR
endif # TARGET_BOARD_PLATFORM
endif # BOARD_PROVIDES_LIBRIL

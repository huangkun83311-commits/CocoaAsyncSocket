include $(THEOS)/makefiles/common.mk

TWEAK_NAME = huangkuntweak
huangkuntweak_FILES = Tweak.xm Source/GCD/GCDAsyncSocket.m
huangkuntweak_FRAMEWORKS = Foundation UIKit
huangkuntweak_CFLAGS = -I./Source

include $(THEOS_MAKE_PATH)/tweak.mk

# 添加这一行来明确指定编译目标
export TARGET = iphone:latest:12.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = huangkuntweak
huangkuntweak_FILES = Tweak.xm Source/GCD/GCDAsyncSocket.m
huangkuntweak_FRAMEWORKS = Foundation UIKit
huangkuntweak_CFLAGS = -I./Source -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

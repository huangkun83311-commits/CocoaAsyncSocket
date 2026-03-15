export TARGET = iphone:clang:latest:14.0
export ARCHS = arm64 arm64e
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = huangkuntweak
huangkuntweak_FILES = Tweak.xm Source/GCD/GCDAsyncSocket.m
huangkuntweak_FRAMEWORKS = Foundation UIKit CoreFoundation CFNetwork Security
huangkuntweak_CFLAGS = -I./Source -fobjc-arc -Wno-error

include $(THEOS_MAKE_PATH)/tweak.mk

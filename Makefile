MODULE_NAME := demo
INC_DIR := include
SRC_DIR := src

ifneq ($(KERNELRELEASE),)
	ccflags-y += -target aarch64
	ccflags-y += -fandroid-kernel-driver-mode
	ccflags-y += -flto
	ccflags-y += -O2
	ccflags-y += -Wall -Wno-error -Wno-unused-value
	ccflags-y += -D__ANDROID_COMMON_KERNEL__
	ccflags-y += -I$(PWD)/$(INC_DIR)
	
	EXTRA_LDFLAGS += $(ANDROID_OLLVM_INSTALLER)lib/linux/libclang_rt.builtins-aarch64.a

	$(MODULE_NAME)-objs:= $(SRC_DIR)/main.o
	obj-m := $(MODULE_NAME).o

else
	KIT_DIR := $(ANDROID_KERNEL_PATH)out/$(ANDROID_KERNEL_BRANCH)/common
	KIT_CLANG_PATH := $(ANDROID_OLLVM_INSTALLER)bin/
	KIT_CLANG := $(KIT_CLANG_PATH)clang
	KIT_LLD := $(KIT_CLANG_PATH)ld.lld
	KIT_AR := $(KIT_CLANG_PATH)llvm-ar
	KIT_CLANG_FORMAT := $(KIT_CLANG_PATH)clang-format

.PHONY: all clean format

all:
	$(MAKE) -C $(KIT_DIR) PATH=$(KIT_CLANG_PATH):$(PATH) ARCH=arm64 SUBARCH=arm64 CC=$(KIT_CLANG) LD=$(KIT_LLD) AR=$(KIT_AR) LLVM=1 LLVM_IAS=1 CROSS_COMPILE=aarch64-linux-gnu- CLANG_TRIPLE=aarch64-linux-gnu- M=$(PWD) modules

clean:
	rm -f *.o *.mod.o *.mod.c *.symvers *.order .*.o.cmd .*.cmd  ./src/.*.o.cmd ./src/*.o *.mod
	$(KIT_CLANG_PATH)llvm-strip --strip-debug $(MODULE_NAME).ko

format:
	find $(PWD)/$(INC_DIR) $(PWD)/$(SRC_DIR) -iname "*.h" -o -iname "*.c" | xargs $(KIT_CLANG_FORMAT) -i
endif


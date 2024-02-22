# Define the module name
MODULE_NAME := demo
# Define the directory for header files
INC_DIR := include
# Define the directory for source files
SRC_DIR := src

# Check if we are being invoked by the kernel build system
ifneq ($(KERNELRELEASE),)
# Compiler flags for targeting a specific architecture
	ccflags-y += -target aarch64
# Flags for Android kernel driver mode
	ccflags-y += -fandroid-kernel-driver-mode
# Enable link-time optimization
	ccflags-y += -flto
# Optimization level and warnings
	ccflags-y += -O2
	ccflags-y += -Wall -Wno-error -Wno-unused-value
# Define for Android common kernel
	ccflags-y += -D__ANDROID_COMMON_KERNEL__
	
# Include directory for header files
	ccflags-y += -I$(PWD)/$(INC_DIR)
# Extra linker flags, specifying a library for linker
	EXTRA_LDFLAGS += $(ANDROID_OLLVM_INSTALLER)lib/linux/libclang_rt.builtins-aarch64.a

# Specify the object files required for the module
	$(MODULE_NAME)-objs:= $(SRC_DIR)/main.o
# Specify that this is a module target
	obj-m := $(MODULE_NAME).o

else
# Directories and tools for building outside the kernel build system
	KIT_DIR := $(ANDROID_KERNEL_PATH)common
	KIT_CLANG_PATH := $(ANDROID_OLLVM_INSTALLER)bin/
	KIT_CLANG := $(KIT_CLANG_PATH)clang
	KIT_LLD := $(KIT_CLANG_PATH)ld.lld
	KIT_AR := $(KIT_CLANG_PATH)llvm-ar
	KIT_STRIP := $(KIT_CLANG_PATH)llvm-strip
	KIT_CLANG_FORMAT := $(KIT_CLANG_PATH)clang-format

# Phony targets for make
.PHONY: all clean format

# Target for building the module
all:
	$(MAKE) -C $(KIT_DIR) PATH=$(KIT_CLANG_PATH):$(PATH) ARCH=arm64 SUBARCH=arm64 CC=$(KIT_CLANG) LD=$(KIT_LLD) AR=$(KIT_AR) LLVM=1 LLVM_IAS=1 CROSS_COMPILE=aarch64-linux-gnu- CLANG_TRIPLE=aarch64-linux-gnu- M=$(PWD) modules

# Target for cleaning up build artifacts
clean:
	rm -f *.o *.mod.o *.mod.c *.symvers *.order .*.o.cmd .*.cmd  ./src/.*.o.cmd ./src/*.o *.mod ./src/.*.o.d
	$(KIT_STRIP) --strip-debug $(MODULE_NAME).ko

# Target for formatting source code
format:
	find $(PWD)/$(INC_DIR) $(PWD)/$(SRC_DIR) -iname "*.h" -o -iname "*.c" | xargs $(KIT_CLANG_FORMAT) -i
endif

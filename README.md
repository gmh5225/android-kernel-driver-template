# `android-kernel-driver-template`

[![build](https://github.com/gmh5225/android-kernel-driver-template/actions/workflows/build.yml/badge.svg)](https://github.com/gmh5225/android-kernel-driver-template/actions/workflows/build.yml)
[![GitHub license](https://img.shields.io/github/license/gmh5225/android-kernel-driver-template)](https://github.com/gmh5225/android-kernel-driver-template/blob/main/LICENSE)

This is a GKI Android kernel driver(AArch64) template compiled using ``llvm-msvc``, aimed at facilitating the development of GKI Android kernel drivers.The development environment used is ``Win11``+``WSL2``+``VSCode``.

### What's [Android GKI](https://source.android.com/docs/core/architecture/kernel/generic-kernel-image)?
A product kernel, also known as a device kernel or OEM kernel, is the kernel that you ship on your device. Prior to GKI, the product kernel was derived from a series of upstream kernel changes. Following shows how kernel additions yield a product kernel (OEM/device kernel):
![image](https://github.com/gmh5225/android-kernel-driver-template/assets/13917777/612e37d0-341a-4f90-9038-c366a05e72fa)


### Requirements
- Rooted Android devices with [Magisk](https://github.com/topjohnwu/Magisk) or [KernelSU](https://github.com/tiann/KernelSU)
- ADB
- VSCode
- WSL/WSL2
- WSL plugin for VSCode
- [llvm-msvc](https://github.com/backengineering/llvm-msvc/releases)
- [GKI Kit](https://github.com/gmh5225/common-android12-5.10-KernelSU/releases)


### Building
```
sudo apt-get install build-essential make cmake
sudo apt-get install p7zip-full p7zip-rar
wget -nv https://github.com/gmh5225/common-android12-5.10-KernelSU/releases/download/v1.0.0/GKI-android12-5.10-kit.zip && 7z x GKI-android12-5.10-kit.zip
wget -nv https://github.com/backengineering/llvm-msvc/releases/download/llvm-msvc-v3.2.9/android-wrapper-llvm-msvc.zip && 7z x android-wrapper-llvm-msvc.zip

export ANDROID_KERNEL_PATH=$(pwd)/common-android12-5.10-KernelSU/
export ANDROID_OLLVM_INSTALLER=$(pwd)/install/

git clone --recursive https://github.com/gmh5225/android-kernel-driver-template
cd android-kernel-driver-template
make && make clean
```

## Testing on android12-5.10
```
adb push demo.ko /data/local/tmp
adb shell su -c insmod /data/local/tmp/demo.ko
adb shell su -c "lsmod |grep demo"
adb shell su -c rmmod /data/local/tmp/demo.ko
```

## Credits
- ``Linux``
- ``Android``
- Some anonymous people

# `android-kernel-driver-template`

[![build](https://github.com/gmh5225/android-kernel-driver-template/actions/workflows/build.yml/badge.svg)](https://github.com/gmh5225/android-kernel-driver-template/actions/workflows/build.yml)
[![GitHub license](https://img.shields.io/github/license/gmh5225/android-kernel-driver-template)](https://github.com/gmh5225/android-kernel-driver-template/blob/main/LICENSE)

This is a GKI Android kernel driver(``ARMv8.3``) template compiled using ``llvm-msvc``, aimed at facilitating the development of GKI Android kernel drivers.The development environment used is ``Win11``+``WSL2``+``VSCode``.

### What's [Android GKI](https://source.android.com/docs/core/architecture/kernel/generic-kernel-image)?
A product kernel, also known as a device kernel or OEM kernel, is the kernel that you ship on your device. Prior to GKI, the product kernel was derived from a series of upstream kernel changes. Following shows how kernel additions yield a product kernel (OEM/device kernel):
![image](https://github.com/gmh5225/android-kernel-driver-template/assets/13917777/612e37d0-341a-4f90-9038-c366a05e72fa)


### Requirements
- Rooted Android devices``(ARMv8.3)`` with [Magisk](https://github.com/topjohnwu/Magisk) or [KernelSU](https://github.com/tiann/KernelSU)
- [AndroidDriveSignity](https://github.com/gmh5225/AndroidDriveSignity)
- ADB
- VSCode
- WSL/WSL2
- [clangd plugin for VSCode](https://marketplace.visualstudio.com/items?itemName=llvm-vs-code-extensions.vscode-clangd)
- [WSL plugin for VSCode](https://code.visualstudio.com/docs/remote/wsl)
- [llvm-msvc](https://github.com/backengineering/llvm-msvc/releases)
- [GKI Kit](https://github.com/gmh5225/common-android12-5.10-KernelSU/releases)


### Setup build deps for your WSL/WSL2
```
sudo passwd root
sudo apt update
sudo apt install python-is-python3
sudo apt install build-essential make cmake
sudo apt install p7zip-full p7zip-rar
sudo apt install bear
```

### Remove environment variables on windows
Open ``wsl.conf`` by running:
```
sudo vim /etc/wsl.conf
```
Append the following lines to the end of the file:
```
[interop]
appendWindowsPath = false
```
Restart your WSL instance by executing:
```
wsl --terminate <distro>
```
Replace <distro> with the name of your distribution, which can be found using the command:
```
wsl --list --verbose
```

### Building
```
wget -nv https://github.com/gmh5225/common-android12-5.10-KernelSU/releases/download/v1.0.1/GKI-android12-5.10-kit.zip && 7z x GKI-android12-5.10-kit.zip
wget -nv https://github.com/backengineering/llvm-msvc/releases/download/llvm-msvc-v3.3.1/android-wrapper-llvm-msvc.zip && 7z x android-wrapper-llvm-msvc.zip

export ANDROID_GKI_KIT_PATH=$(pwd)/GKI-android12-5.10-kit/
export ANDROID_OLLVM_INSTALLER=$(pwd)/install/

git clone --recursive https://github.com/gmh5225/android-kernel-driver-template
cd android-kernel-driver-template
bear -- make && make clean
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

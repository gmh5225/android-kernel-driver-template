# `android-kernel-driver-template`

[![GitHub license](https://img.shields.io/github/license/gmh5225/android-kernel-driver-template)](https://github.com/gmh5225/android-kernel-driver-template/blob/main/LICENSE)

This is a GKI Android kernel driver(AArch64) template compiled using ``llvm-msvc``, aimed at facilitating the development of GKI Android kernel drivers.The development environment used is ``Win11``+``WSL2``+``VSCode``.



### Requirements
- VSCode
- WSL/WSL2
- WSL plugin for VSCode
- [llvm-msvc](https://github.com/backengineering/llvm-msvc/releases)
- [GKI Kit](https://github.com/gmh5225/common-android12-5.10-KernelSU/releases)


### Building AArch64 driver with llvm-msvc
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

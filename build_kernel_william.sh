#!/bin/bash

export ARCH=arm64
export CROSS_COMPILE=/home/williamkosasih/aarch64-linux-android-4.9/bin/aarch64-linux-android-
exoirt ANDROID_MAJOR_VERSION=p
export PLATFORM_VERSION=9.0.0

make -C $(pwd) O=$(pwd)/out KCFLAGS=-mno-android william_defconfig
make -j64 -C $(pwd) O=$(pwd)/out KCFLAGS=-mno-android

cd anyKernel3

rm kernel.zip

cp ../out/arch/arm64/boot/Image.gz-dtb zImage

zip -r kernel.zip .
#!/bin/bash

export ARCH=arm64
export CROSS_COMPILE=/home/kali/linux/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export ANDROID_MAJOR_VERSION=p
export PLATFORM_VERSION=9.0.0

make -C $(pwd) O=$(pwd)/out KCFLAGS=-mno-android william_defconfig
make -j8 -C $(pwd) O=$(pwd)/out KCFLAGS=-mno-android

modules=$(find . -name '*ko')

for module in $modules
do
	cp $module anyKernel3/modules/system/lib/modules/
done

cd anyKernel3

rm kernel.zip

cp ../out/arch/arm64/boot/Image.gz-dtb zImage

zip -r kernel.zip *

cd anyKernel3

rm kernel.zip

cp ../out/arch/arm64/boot/Image.gz-dtb zImage

zip -r kernel.zip *
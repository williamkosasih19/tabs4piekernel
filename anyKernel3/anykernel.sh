# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=TestKernel1 by WilliamKosasih
do.devicecheck=0
do.modules=1
do.cleanup=1
do.cleanuponabort=0
device.name1=SM-T835
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/platform/soc/1da4000.ufshc/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;


## AnyKernel install
dump_boot;

ui_print "patching ramdisk...";
unpack_ramdisk;

replace_file init.rc 755 $ramdisk/init.rc;

repack_ramdisk;

ui_print "succesfully patched ramdisk!";

write_boot;

ui_print "Installing Magisk and UKM(Synapse)..."
## end install


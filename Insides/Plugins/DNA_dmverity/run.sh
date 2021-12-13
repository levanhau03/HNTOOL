#!/bin/bash

#
#    Copyright (C) 2021
#    2021-11-26 21:39:06
#


PROJECT=${1}					#Project catalog
SHELL=$(readlink -f "$0")			#Script file
SHELL_PATH=$(dirname $SHELL)		#Script path

#functions
getprop() { grep "$1" "$2" | cut -d "=" -f 2; }

#
#
if [ -d $PROJECT/system/system ]; then
system=system/system
systemroot=true
else
system=system
systemroot=false
fi;

echo "- Name = $(getprop ro.product.system.model $PROJECT/$system/build.prop)"
echo "- Device = $(getprop ro.product.vendor.device $PROJECT/vendor/build.prop)"
echo "- System as-root = $systemroot"
echo "=================================================="

sed -i 's/secure=0/secure=1/' $PROJECT/vendor/default.prop
for file in `find $PROJECT/vendor/etc/*stab* -type f` ;do
	fstab="$file"
	echo "- Encryption: $fstab"
	sed -i "s/fileencryption=/encryptable=/g" $file
	sed -i 's/forceencrypt=/encryptable=/' $fstab
	sed -i 's/forcefdeorfbe=/encryptable=/' $fstab
	sed -i 's/.dmverity=true/.dmverity=false/' $fstab
	sed -i 's/,avb_keys=\/avb\/q-gsi.avbpubkey:\/avb\/r-gsi.avbpubkey:\/avb\/s-gsi.avbpubkey//g' $fstab
	sed -i 's/ro,/ro,noatime,/g' $fstab
	sed -i 's/,avb=vbmeta_system//g' $fstab
	sed -i 's/,avb=vbmeta//g' $fstab
	sed -i 's/,avb//g' $fstab
done

#!/bin/bash

#
#    Copyright (C) 2021
#    2021-11-26 21:39:06
#


PROJECT=${1}					#Project catalog
SHELL=$(readlink -f "$0")			#Script file
SHELL_PATH=$(dirname $SHELL)		#Script path
SYSTEM=system/system

rm -rf $PROJECT/$SYSTEM/framework/oat/arm64/services.art
rm -rf $PROJECT/$SYSTEM/framework/oat/arm64/services.odex
rm -rf $PROJECT/$SYSTEM/framework/oat/arm64/services.vdex

getProp() { grep "$1" "${PROJECT}/system/system/build.prop" | cut -d "=" -f 2; }
ApkTools="java -jar -Xms2048m -Xmx2048m $SHELL_PATH/SmallPatchLib/apktool.jar"
AndroidApi=$(getProp 'ro.build.version.sdk')

SmallTempPath=$SHELL_PATH/SmallTemp
mkdir -p $SmallTempPath

doUnApk(){
	echo -en "\n>>>Unpack: ${1}"
	SYS_APK_FILE="$PROJECT${1}"
	APK_NAME="${1##*/}"
	APK_DO_PATH="$SmallTempPath/${APK_NAME%.*}"
	APK_OUT_FILE="${APK_DO_PATH}/${APK_NAME}"
	APK_OUT_SMAILL_PATH="${APK_DO_PATH}/apkSmali"
	
	rm -rf $APK_DO_PATH
	mkdir -p $APK_OUT_SMAILL_PATH

	$ApkTools -r -b -f d -c -api $AndroidApi  --use-aapt2 "$SYS_APK_FILE" -o "${APK_OUT_SMAILL_PATH}"
	for file in `find ${2}/*.sh -prune -type f` ;do
		doInsert "$file" "${APK_OUT_SMAILL_PATH}"
	done
	
	if [ -f "${2}/lib/do.sh" ] ; then 
		echo -en "\n>>>Processing: ${2}/lib/do.sh"
		bash "${2}/lib/do.sh" "${APK_OUT_SMAILL_PATH}" "${SYS_APK_FILE}"
	fi
	
	echo -en "\n>>>Repack: ${1}"
	$ApkTools -r -b -f b -c -api $AndroidApi  --use-aapt2 "${APK_OUT_SMAILL_PATH}" -o "${APK_OUT_FILE}"
	
	if [ -f "${2}/lib/end.sh" ] ; then 
		echo -en "\n>>>End process: ${2}/lib/end.sh"
		bash "${2}/lib/end.sh" "${SYS_APK_FILE}" "${APK_OUT_FILE}"
	fi
	
    $SHELL_PATH/SmallPatchLib/zipalign 4 "$APK_OUT_FILE" "${APK_OUT_FILE}.zipalign"
	
    mv "${APK_OUT_FILE}.zipalign" "$PROJECT${1}"
	rm -rf "$APK_DO_PATH"
}

doInsert(){
	echo -en ""
	echo -en "\n>>>>Start configuration: ${1##*/}"
	source $1
	echo -en "\n>>>>Find insert: $FIND_START"
	FINS_RES=$2/$SMALI_FILE

	if [ ! -n "$SMALI_FILE" ] ; then 
		FINS_RES=`find $2 -name *.smali | xargs grep -e "$FIND_START" | head -n 1`
		FINS_RES=${FINS_RES/:$FIND_START/""}
		echo "Tìm: $FINS_RES"
	fi
	
	if [ -n "$FINS_RES" ] ; then 
		oldStr=`sed -n "/$FIND_START/,/$FILE_END/p" $FINS_RES`
		if [ ! -n "$FIND_START" ];then oldStr=$DEFAULT_CODE ;fi
		if [ -n "$oldStr" ];then
			res=`python3 $SHELL_PATH/SmallPatchLib/repStr "$FINS_RES" "$oldStr" "$REPLACE_CODE"`
			echo -en  "\n>>>>Finish processing: Insertion is complete"
		else
			echo -en  "\n>>>>No insertion point: $FILE_END"
		fi
	else
		echo  "\n>>>>File not in: ${FINS_RES}"
	fi
	
	SMALI_FILE=""
	FIND_START=""
	DEFAULT_CODE=""
	REPLACE_CODE=""
	echo ""
}


rm -rf ${SmallTempPath}
mkdir -p ${SmallTempPath}



echo -en  "\n>>Start jailbreaking your device\n"
$ApkTools if $PROJECT/system/system/framework/framework-res.apk
$ApkTools if $PROJECT/system/system/framework/framework-ext-res/framework-ext-res.apk
$ApkTools if $PROJECT/system/system/app/miuisystem/miuisystem.apk
$ApkTools if $PROJECT/system/system/app/miui/miui.apk

for line in $(cat $SHELL_PATH/SmallPatchFile/FileConfig.ini) ; do
	line=$(echo $line| tr -d '\r')
	if [ -f "${PROJECT}${line}" ] ;then 
		doUnApk "${line}" "$SHELL_PATH/SmallPatchFile/${line##*/}"
	fi
done
rm -rf ${SmallTempPath}
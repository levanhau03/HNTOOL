#!/bin/bash

#
#    Copyright (C) 2021
#    2021-11-26 21:39:06
#


PROJECT=${1}					#Project catalog
SHELL=$(readlink -f "$0")			#Script file
SHELL_PATH=$(dirname $SHELL)		#Script path

ReplacePath="$SHELL_PATH/AddReplaceFile"
for file in `find ${ReplacePath}/* -type f` ;do
	sysFile=${file/$ReplacePath/""}
	localFile="${PROJECT}${sysFile}"
	mkdir -p ${localFile%/*}
	cp -r ${file} ${localFile}
done
#!/bin/bash

#
#    Copyright (C) 2021
#    2021-11-26 21:39:06
#


PROJECT=${1}					#Project catalog
SHELL=$(readlink -f "$0")			#Script file
SHELL_PATH=$(dirname $SHELL)		#Script path

echo "Project: $PROJECT"

for i in $(cat $SHELL_PATH/delete.txt); do
	if [ -f $PROJECT$i ]
	then
		if [ -f "$PROJECT$i" ] ; then
			echo "$PROJECT$i"
			rm -rf $PROJECT$i
		fi		
	else
		if [ -d "$PROJECT$i" ] ; then
			echo "$PROJECT$i"
			rm -rf $PROJECT$i
		fi
	fi
done

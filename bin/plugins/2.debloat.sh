#By Mr.Hau

pattern="HN_"
for _dir in ../../"${pattern}"*; do
    [ -d "${_dir}" ] && dir="${_dir}" && break
done

PROJECT=$dir

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

for i in $(cat delete.txt); do
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

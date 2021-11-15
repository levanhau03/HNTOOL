#By Mr.Hau

pattern="HN_"
for _dir in ../../"${pattern}"*; do
    [ -d "${_dir}" ] && dir="${_dir}" && break
done

PROJECT=$dir
SHELL=$(readlink -f "$0")
SHELL_PATH=$(dirname $SHELL)

ReplacePath="$SHELL_PATH/AddReplaceFile"
for file in `find ${ReplacePath}/* -type f` ;do
	sysFile=${file/$ReplacePath/""}
	localFile="${PROJECT}${sysFile}"
	mkdir -p ${localFile%/*}
	cp -r ${file} ${localFile}
done
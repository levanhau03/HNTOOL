pattern="HN_"
for _dir in ../../"${pattern}"*; do
    [ -d "${_dir}" ] && dir="${_dir}" && break
done

PROJECT=$dir
SYSTEM=system/system

rm -rf $PROJECT/$SYSTEM/framework/oat/arm64/services.art
rm -rf $PROJECT/$SYSTEM/framework/oat/arm64/services.odex
rm -rf $PROJECT/$SYSTEM/framework/oat/arm64/services.vdex

SMALI_FILE="/smali/com/android/server/SystemServerInjector.smali"
FIND_START='const-string v2, "cm8ucHJvZHVjdC5tb2RfZGV2aWNl"'
FILE_END='if-eqz v0, :cond_0'

REPLACE_CODE='
    if-eqz v0, :cond_0
'
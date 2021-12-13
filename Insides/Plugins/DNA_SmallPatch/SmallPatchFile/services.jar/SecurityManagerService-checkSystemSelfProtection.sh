SMALI_FILE="/smali_classes2/com/miui/server/SecurityManagerService.smali"
FIND_START='.method private checkSystemSelfProtection(Z)V'
FILE_END='.end method'

REPLACE_CODE='
.method private  checkSystemSelfProtection(Z)V
    .locals 1

    return-void
.end method
'
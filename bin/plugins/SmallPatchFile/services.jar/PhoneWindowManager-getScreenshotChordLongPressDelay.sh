SMALI_FILE="/smali_classes2/com/android/server/policy/PhoneWindowManager.smali"
FIND_START='.method private getScreenshotChordLongPressDelay()J'
FILE_END='.end method'

REPLACE_CODE='
.method private  getScreenshotChordLongPressDelay()J
    .locals 3

    const/high16 v1, 0x0

    float-to-long v0, v1

    return-wide v0
.end method
'
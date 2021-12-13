#!/bin/bash

#
#    Copyright (C) 2021
#    2021-11-26 21:39:06
#


PROJECT=${1}					#Project catalog
SHELL=$(readlink -f "$0")			#Script file
SHELL_PATH=$(dirname $SHELL)		#Script path



echo "Project: $PROJECT"

DELETE="
system/app/AiAsstVision
system/app/VoiceAssist
system/app/VoiceTrigger
system/app/AnalyticsCore
system/app/BasicDreams
system/app/BookmarkProvider
system/app/BTProductionLineTool
system/app/BuiltInPrintService
system/app/WallpaperBackup
system/app/BluetoothMidiService
system/app/GooglePrintRecommendationService
system/app/MiLinkService2
system/app/Joyose
system/app/CarrierDefaultApp
system/app/CatchLog
system/app/Cit
system/app/CtsShimPrebuilt
system/app/HTMLViewer
system/app/HybridAccessory
system/app/HybridPlatform
system/app/KSICibaEngine
system/app/mi_connect_service
system/app/Mipay
system/app/MiPlayClient
system/app/MiuiAudioMonitor
system/app/MiuiBugReport
system/app/MiuiDaemon
system/app/MSA
system/app/NextPay
system/app/PacProcessor
system/app/PaymentService
system/app/PrintSpooler
system/app/SimAppDialog
system/app/Stk
system/app/TouchAssistant
system/app/Traceur
system/app/TranslationService
system/app/WAPPushManager
system/app/WMService
system/app/XiaomiModemDebugService
system/app/YouDaoEngine
system/app/Zman
system/app/mab
system/app/CatcherPatch
system/data-app
system/media/wallpaper
system/app/MiuiAccessibility
system/app/systemAdSolution
system/app/MSA-CN-NO_INSTALL_PACKAGE
system/app/talkback
system/app/PhotoTable
system/app/mid_test
system/app/MiuiVpnSdkManager
system/app/AutoTest
system/app/AutoRegistration
system/app/PrintRecommendationService
system/app/SeempService
system/app/com.miui.qr
system/app/GPSLogSave
system/app/SystemHelper
system/app/SYSOPT
system/app/xdivert
system/app/MiuiDaemon
system/app/Qmmi
system/app/QdcmFF
system/app/Xman
system/app/Yman
system/app/seccamsample
system/app/greenguard
system/app/QColor
system/product/app/datastatusnotification
system/product/app/PhotoTable
system/product/app/QdcmFF
system/product/app/talkback
system/product/app/xdivert
system/product/priv-app/dpmserviceapp
system/product/priv-app/EmergencyInfo
system/product/priv-app/seccamservice
system/product/priv-app/ConfigUpdater
system/etc/auto-install.json
system/vendor/data-app
system/etc/fake_cdrom_install.iso
system/app/PowerChecker
system/app/goodix_sz
system/app/FidoCryptoService
system/app/FidoAuthen
system/app/FidoClient
verity_key
system/priv-app/Tag
system/priv-app/BackupRestoreConfirmation
system/priv-app/dpmserviceapp
system/priv-app/EmergencyInfo
system/priv-app/UserDictionaryProvider
system/priv-app/ONS
system/priv-app/ContentExtension
system/priv-app/NewHome
system/priv-app/PersonalAssistant
system/priv-app/Browser
system/priv-app/BlockedNumberProvider
system/priv-app/CallLogBackup
system/priv-app/DMRegService
system/priv-app/MiGameCenterSDKService
system/priv-app/MiRcs
system/priv-app/MiService
system/priv-app/MusicFX
"



for file in $DELETE ; do
	if [ -e $PROJECT/system/$file ]; then
		echo "rm -rf $file"
		rm -rf $PROJECT/system/$file
	fi
	if [ -e $PROJECT/$file ]; then
		echo "rm -rf $file"
		rm -rf $PROJECT/$file
	fi
done

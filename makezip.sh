#!/bin/sh

name=MIUICamera_v2_whyred
ver=$(sed -n -e 's/version=v// ' -e 's/ ([0-9-]*)// p' <module.prop )
lf=tmp/list_files
target='sysmiui/etc/device_features/whyred.xml'
temp='temp.xml'


echo 'TWRP BUILD'

echo 'prepare addon.d files'
find . -name '*.DS_Store' -type f -delete
echo 'system/addon.d/99-MIUICamV2.sh' > $lf
echo 'system/addon.d/audio_fix' >> $lf
echo 'system/addon.d/list_files' >> $lf
echo 'system/addon.d/vendor_build_prop_tweaks' >> $lf
echo 'system/addon.d/vendor_build_prop_tweaks.sh' >> $lf
find system/* -type f >> $lf

echo 'prepare META-INF'
cp make/twrp/updater-script META-INF/com/google/android/updater-script
cp make/twrp/update-binary META-INF/com/google/android/update-binary

echo make ZIP: AOSP-TWRP-$name-$ver\_$1.zip
zip -r -X -q AOSP-TWRP-$name-$ver\_$1.zip mount META-INF system tmp >/dev/null 2>&1

echo 'make MIUI whyred.xml'
#fix whyred.xml for miui
rm -f sysmiui/etc/device_features/whyred.xml
cp system/etc/device_features/whyred.xml sysmiui/etc/device_features/whyred.xml
sed '
s/off  in camera--/off in camera CHANGED--/
s/camera_quick_snap">false/camera_quick_snap">true/
s/finger print capture of Camera --/finger print capture of Camera CHANGED--/
s/front_fingerprint_sensor">true/front_fingerprint_sensor">false/' <$target >$temp
mv $temp $target

echo 'make MIUI system'
# change system with sysmiui 	
mv system systemp
mv sysmiui system

echo make ZIP: MIUI-TWRP-$name-$ver\_$1.zip
zip -r -X -q MIUI-TWRP-$name-$ver\_$1.zip mount META-INF system tmp
mv system sysmiui
mv systemp system
echo ' '
echo '+-+-+-+-+'
echo ' '
echo 'MAGISK BUILD'

echo 'prepare META-INF'
cp make/magisk/updater-script META-INF/com/google/android/updater-script
cp make/magisk/update-binary META-INF/com/google/android/update-binary

echo make ZIP: AOSP-MAGISK-$name-$ver\_$1.zip
zip -r -X -q AOSP-MAGISK-$name-$ver\_$1.zip common META-INF system config.sh module.prop README.md

echo 'make MIUI whyred.xml'
#fix whyred.xml for miui
rm -f sysmiui/etc/device_features/whyred.xml
cp system/etc/device_features/whyred.xml sysmiui/etc/device_features/whyred.xml
sed '
s/camera_quick_snap">false/camera_quick_snap">true/
s/front_fingerprint_sensor">true/front_fingerprint_sensor">false/' <$target >$temp
mv $temp $target
echo 'make MIUI system'
# change system with sysmiui 	
mv system systemp
mv sysmiui system

echo make ZIP: MIUI-MAGISK-$name-$ver\_$1.zip
zip -r -X -q MIUI-MAGISK-$name-$ver\_$1.zip common META-INF system config.sh module.prop README.md
mv system sysmiui
mv systemp system
echo '---------'
echo 'FINISHED!'
echo ' '
#!/bin/sh

name=MIUICamera_v2_whyred
ver=$(sed -n -e 's/version=v// ' -e 's/ ([0-9-]*)// p' <module.prop )
lf=tmp/list_files

echo ' '
echo make ZIP: TWRP-$name-$ver\_$1.zip
echo '---------'
find . -name '*.DS_Store' -type f -delete
echo 'system/addon.d/99-MIUICamV2.sh' > $lf
echo 'system/addon.d/audio_fix' >> $lf
echo 'system/addon.d/list_files' >> $lf
echo 'system/addon.d/vendor_build_prop_tweaks' >> $lf
echo 'system/addon.d/vendor_build_prop_tweaks.sh' >> $lf
find system/* -type f >> $lf
cp make/twrp/updater-script META-INF/com/google/android/updater-script
cp make/twrp/update-binary META-INF/com/google/android/update-binary
zip -r -X TWRP-$name-$ver\_$1.zip mount META-INF system tmp
echo make ZIP: MIUI-TWRP-$name-$ver\_$1.zip 
echo '---------'
mv system systemp
mv sysmiui system
zip -r -X MIUI-TWRP-$name-$ver\_$1.zip mount META-INF system tmp
mv system sysmiui
mv systemp system
echo '---------'
echo FINISHED!
echo ' '

echo ' '
echo make ZIP: MAGISK-$name-$ver\_$1.zip
echo '---------'
cp make/magisk/updater-script META-INF/com/google/android/updater-script
cp make/magisk/update-binary META-INF/com/google/android/update-binary
zip -r -X MAGISK-$name-$ver\_$1.zip common META-INF system config.sh module.prop README.md
echo make ZIP: MIUI-MAGISK-$name-$ver\_$1.zip 
echo '---------'
mv system systemp
mv sysmiui system
zip -r -X MIUI-MAGISK-$name-$ver\_$1.zip common META-INF system config.sh module.prop README.md
mv system sysmiui
mv systemp system
echo '---------'
echo FINISHED!
echo ' '
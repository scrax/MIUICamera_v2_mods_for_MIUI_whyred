#!/bin/sh

name=MIUICamera_v2_whyred
ver=$(cat module.prop | grep version= | cut -b 10-13)

echo ' '
echo make ZIP: TWRP-$name-$ver_$1.zip
echo '---------'
cp make/twrp META-INF/com/google/android/updater-script
zip -r -X TWRP-$name-$ver_$1.zip mount META-INF system tmp
echo '---------'
echo FINISHED!
echo ' '

echo ' '
echo make ZIP: MAGISK-$name-$ver_$1.zip
echo '---------'
cp make/magisk META-INF/com/google/android/updater-script
zip -r -X MAGISK-$name-$ver_$1.zip common META-INF system config.sh module.prop README.md
echo '---------'
echo FINISHED!
echo ' '
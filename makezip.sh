#!/sbin/sh

name=MIUICamera_v2_whyred
ver=$(cat module.prop | grep version= | cut -b 10-13)

echo ' '
echo make ZIP: $name-$ver.zip
echo '---------'
zip -r -X $name-$ver.zip common META-INF system config.sh module.prop README.md
echo '---------'
echo FINISHED!
echo ' '

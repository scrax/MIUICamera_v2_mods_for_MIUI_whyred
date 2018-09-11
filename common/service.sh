#!/system/bin/sh
MODDIR=${0%/*}

# Enable Camera2 API
busybox echo "# Enable Camera2 API" >> /system/build.prop;
prop=persist.camera.HAL3.enabled=1
busybox export newprop=$(echo ${prop} | cut -d '=' -f1)
busybox sed -i "/${newprop}/d" /system/build.prop
busybox echo $prop >> /system/build.prop

#camera sound fix
dir="/system/media/audio/ui/"

audio_fix() {
cat <<EOF
camera_click.ogg
camera_focus.ogg
VideoRecord.ogg
VideoStop.ogg
EOF
}

audio_fix | while read name ;
  do
    if [ -f $dir$name.bak ];
      then
        busybox echo Camera sound: "$name" already fixed
        #mv $dir$name.bak $dir$name
      else
        busybox echo Fixing camera sound: "$name"
        busybox mv $dir$name $dir$name.bak
    fi
done
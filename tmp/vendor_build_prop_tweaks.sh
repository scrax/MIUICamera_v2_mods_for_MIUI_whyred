#!/sbin/sh

bp="/vendor/build.prop"
dir="/system/media/audio/ui/"
prop=ro.vendor.audio.sdk.fluencetype=none

audio_fix() {
cat <<EOF
camera_click.ogg
camera_focus.ogg
VideoRecord.ogg
VideoStop.ogg
EOF
}

busybox mount /vendor
busybox mount /data

if [ -f /vendor/build.prop.bak ]; 
  then
    rm -rf $bp
    cp $bp.bak $bp
  else
    cp $bp $bp.bak
fi

echo " " >> $bp

#for mod in vendor_build_prop_tweaks;
#  do

#    for prop in `cat /tmp/$mod`;do
      export newprop=$(echo ${prop} | cut -d '=' -f1)
      sed -i "/${newprop}/d" /vendor/build.prop
      echo $prop >> /vendor/build.prop
#    done
#done

echo 'Starting camera sound fix'

audio_fix | while read name ;
  do
    if [ -f $dir$name.bak ];
      then
        echo Camera sound: "$name" already fixed
        #mv $dir$name.bak $dir$name
      else
        echo Fixing camera sound: "$name"
        mv $dir$name $dir$name.bak
    fi
done
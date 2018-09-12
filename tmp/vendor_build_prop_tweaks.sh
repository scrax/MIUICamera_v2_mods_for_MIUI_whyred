#!/sbin/sh

vbp="/vendor/build.prop"
sbp="/system/build.prop"
dir="/system/media/audio/ui/"
vprop=ro.vendor.audio.sdk.fluencetype=none

audio_fix() {
	cat <<EOF
camera_click.ogg
camera_focus.ogg
VideoRecord.ogg
VideoStop.ogg
EOF
}

bprop() {
	cat <<EOF
#Name
ro.product.model=Redmi Note 5
ro.product.brand=Xiaomi
ro.product.name=whyred
ro.product.device=whyred
ro.product.manufacturer=Xiaomi
ro.build.product=whyred

#whatsapp fix
camera.hal1.packagelist=com.whatsapp,com.android.camera

#Expose aux camera for below packages
camera.aux.packagelist=org.codeaurora.snapcam,com.android.camera,com.qualcomm.qti.qmmi,org.lineage.snap,com.google.android.GoogleCamera,com.google.android.GoogleCameraTele,com.google.android.GoogleCameraWide,com.google.android.GoogleCamerb
vendor.camera.aux.packagelist=org.codeaurora.snapcam,com.android.camera,com.qualcomm.qti.qmmi,org.lineage.snap,com.google.android.GoogleCamera,com.google.android.GoogleCameraTele,com.google.android.GoogleCameraWide,com.google.android.GoogleCamerb

#disable UBWC for camera
persist.camera.preview.ubwc=0
persist.camera.stats.test=0
persist.camera.depth.focus.cb=0
persist.camera.isp.clock.optmz=0
persist.camera.hist.high=20
persist.camera.hist.drc=1.2
persist.camera.linkpreview=0
persist.camera.isp.turbo=1

#EIS
persist.camera.eis.enable=1

#camera2 api
persist.camera.HAL3.enabled=1

#exif info for camera
persist.sys.exif.make=Xiaomi
persist.sys.exif.model=Redmi Note 5

#properties for camera front flash lux
persist.flash.low.lux=390
persist.flash.light.lux=340

persist.imx376_ofilm.low.lux=310
persist.imx376_ofilm.light.lux=280

persist.imx376_sunny.low.lux=310
persist.imx376_sunny.light.lux=280

persist.ov13855_sunny.low.lux=385
persist.ov13855_sunny.light.lux=370

persist.s5k3l8_ofilm.low.lux=379
persist.s5k3l8_ofilm.light.lux=367

#
dalvik.vm.isa.arm64.variant=cortex-a53
dalvik.vm.isa.arm.variant=cortex-a53
EOF
}

#Edit vendor/build.prop
vendor_prop_edit(){
if [ -f $vbp.bak ]; 
  then
    rm -rf $vbp
    cp $vbp.bak $vbp
  else
    cp $vbp $vbp.bak
fi

echo " " >> $vbp

#for mod in vendor_build_prop_tweaks;
#  do

#    for prop in `cat /tmp/$mod`;do
      export newvprop=$(echo ${vprop} | cut -d '=' -f1)
      sed -i "/${newvprop}/d" $vbp
      echo $vprop >> $vbp
#    done
#done
}

#Edit build.prop
build_prop_edit(){
if [ -f $sbp.bak ]; 
  then
    rm -rf $sbp
    cp $sbp.bak $sbp
  else
    cp $sbp $sbp.bak
fi

echo " " >> $sbp

bprop | while read sprop ;
  do
    export newsprop=$(echo ${sprop} | cut -d '=' -f1)
    sed -i "/${newsprop}/d" $sbp
    echo $sprop >> $sbp

done
}

busybox mount /vendor
busybox mount /data

vendor_prop_edit
build_prop_edit
camera_sound_fix
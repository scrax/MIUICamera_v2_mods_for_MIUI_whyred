#!/sbin/sh

vbp="/vendor/build.prop"
sbp="/system/build.prop"
dir="/system/media/audio/ui/"

init(){
	busybox umount /vendor
	busybox umount /system
	busybox mount /vendor
	busybox mount /system	
}

audio_fix(){
	cat <<EOF
camera_click.ogg
camera_focus.ogg
VideoRecord.ogg
VideoStop.ogg
EOF
}

shutter_files(){
	cat <<EOF
system/usr/keylayout/uinput-fpc.kl
system/usr/keylayout/uinput-goodix.kl
system/vendor/usr/keylayout/uinput-fpc.kl
system/vendor/usr/keylayout/uinput-goodix.kl
EOF
}

vprop(){
	cat <<EOF
ro.vendor.audio.sdk.fluencetype=none
EOF
}

sprop(){
	cat <<EOF
#### ADDED BY MIUI CAMERA V2 MOD ####
# Device Names
ro.product.model=Redmi Note 5
ro.product.brand=Xiaomi
ro.product.name=whyred
ro.product.device=whyred
ro.product.manufacturer=Xiaomi
ro.build.product=whyred
# Whatsapp fix
camera.hal1.packagelist=com.whatsapp,com.android.camera
# Expose aux camera for below packages
camera.aux.packagelist=org.codeaurora.snapcam,com.android.camera,com.qualcomm.qti.qmmi,org.lineage.snap,com.google.android.GoogleCamera,com.google.android.GoogleCameraTele,com.google.android.GoogleCameraWide,com.google.android.GoogleCamerb
vendor.camera.aux.packagelist=org.codeaurora.snapcam,com.android.camera,com.qualcomm.qti.qmmi,org.lineage.snap,com.google.android.GoogleCamera,com.google.android.GoogleCameraTele,com.google.android.GoogleCameraWide,com.google.android.GoogleCamerb
# Disable UBWC for camera
persist.camera.preview.ubwc=0
persist.camera.stats.test=0
persist.camera.depth.focus.cb=0
persist.camera.isp.clock.optmz=0
persist.camera.hist.high=20
persist.camera.hist.drc=1.2
persist.camera.linkpreview=0
persist.camera.isp.turbo=1
# EIS
persist.camera.eis.enable=1
# Enable Camera2 API
persist.camera.HAL3.enabled=1
# exif info for camera
persist.sys.exif.make=Xiaomi
persist.sys.exif.model=Redmi Note 5
# Properties for camera front flash lux
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
# Variant cortex a53
dalvik.vm.isa.arm64.variant=cortex-a53
dalvik.vm.isa.arm.variant=cortex-a53
# Disable Camera Sound
camera.shutter_sound.blacklist=com.android.camera
EOF
}

#Edit build.prop
prop_edit(){
	echo check backup "$bp"
	if [ -f $bp.bak ]; 
  		then
    		rm -rf $bp
    		cp $bp.bak $bp
  		else
    		cp $bp $bp.bak
	fi
	echo " " >> $bp
	list $1 | while read prop ;
 		do
    		export newprop=$(echo ${prop} | cut -d '=' -f1)
    		sed -i "/${newprop}/d" $bp
    		echo $prop >> $bp
		done
}

list(){
	[ $1 == vprop ] && vprop || sprop ;
}

#Edit vendor/build.prop
vendor_prop_edit(){
	bp=$vbp
	echo Edit "$vbp"
	prop_edit vprop
}

#Edit build.prop
system_prop_edit(){
	bp=$sbp
	echo Edit "$sbp"
	prop_edit sprop
}

camera_sound_fix(){
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
}

fp_shutter(){
	shutter_files | while read filename ;
	  do
	  	if [ -f $filename.bak ];
	  		then
	  			rm -rf $filename
	  			cp $filename.bak $filename
	  		else
	  			cp $filename $filename.bak
	  	fi
	  	echo 'key 96 DPAD_CENTER' > $filename
		#echo '\#key 102   HOME' >> $filename
		#echo '\#key 105   DPAD_LEFT' >> $filename
		#echo '\#key 106   DPAD_RIGHT' >> $filename
	    echo 'key 353 CAMERA' >> $filename
	  done
}



init
vendor_prop_edit
system_prop_edit
#camera_sound_fix
#fp_shutter
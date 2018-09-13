#!/bin/sh

init(){
	name=$(sed -n -e 's/id=// p' <module.prop )
	ver=$(sed -n -e 's/version=v// ' -e 's/ ([0-9-]*)// p' <module.prop )
	addond=tmp/98-MIUICamV2.sh
	target='sysmiui/etc/device_features/whyred.xml'
	temp='temp.xml'
	syst=''
	os='AOSP'

	echo 'START '$name'-'$1' build...'
	#echo '*                 Remove media                 *'
	[ -d system/media ] && rm -Rf system/media ;
	[ -d sysmiui ] && rm -Rf sysmiui ;
	[ -f $addond ] && rm -Rf $addond ;
}

set_miui() {
	if [ -d systemp ];
	  then
		os=AOSP
		echo '*----------------------------------------------*'
		echo '*          Prepare AOSP system                 *'
		echo '*   '$os'   Restore system                      *'
		#mv system sysmiui
		#rm -R sysmiui
		rm -Rf system
		mv systemp system 
	  else
		os=MIUI
		echo '*----------------------------------------------*'
		echo '*          Prepare MIUI system                 *'
		mkdir sysmiui
		mkdir sysmiui/etc
		mkdir sysmiui/etc/device_features
		mkdir sysmiui/lib64
		mkdir sysmiui/vendor
		mkdir sysmiui/vendor/etc
		mkdir sysmiui/vendor/etc/camera
		mkdir sysmiui/vendor/lib

		cp system/etc/media_profiles.xml sysmiui/etc/media_profiles.xml
		cp system/priv-app/MiuiCamera/lib/arm64/libmorpho_group_portrait.so sysmiui/lib64/libmorpho_group_portrait.so
		cp system/priv-app/MiuiCamera/lib/arm64/libmorpho_groupshot.so sysmiui/lib64/libmorpho_groupshot.so
		cp system/vendor/etc/audio_platform_info.xml sysmiui/vendor/etc/audio_platform_info.xml
		cp system/vendor/etc/camera/camera_config.xml sysmiui/vendor/etc/camera/camera_config.xml
		cp system/vendor/etc/camera/dualcamera.png sysmiui/vendor/etc/camera/dualcamera.png
		cp system/vendor/etc/camera/dualcamera.png.bak sysmiui/vendor/etc/camera/dualcamera.png.bak
		cp system/vendor/etc/camera/dualcamera_in.png sysmiui/vendor/etc/camera/dualcamera_in.png
		cp system/vendor/etc/camera/dualcamera_in.png.bak sysmiui/vendor/etc/camera/dualcamera_in.png.bak
		cp make/miui/morpho_lowlight4.0.xml sysmiui/vendor/etc/camera/morpho_lowlight4.0.xml
		cp make/miui/whyred_ov13855_sunny_cn_i_chromatix.xml sysmiui/vendor/etc/camera/whyred_ov13855_sunny_cn_i_chromatix.xml
		cp system/vendor/etc/media_profiles_V1_0.xml sysmiui/vendor/etc/media_profiles_V1_0.xml
		cp system/vendor/etc/media_profiles_vendor.xml sysmiui/vendor/etc/media_profiles_vendor.xml
		cp system/vendor/etc/mixer_paths.xml sysmiui/vendor/etc/mixer_paths.xml
		cp make/miui/lib/libchromatix_ov13855_cpp_ds_chromatix.so sysmiui/vendor/lib/libchromatix_ov13855_cpp_ds_chromatix.so
		cp make/miui/lib/libchromatix_ov13855_cpp_us_chromatix.so sysmiui/vendor/lib/libchromatix_ov13855_cpp_us_chromatix.so
		cp make/miui/lib/libchromatix_ov13855_zsl_preview_bu64297.so sysmiui/vendor/lib/libchromatix_ov13855_zsl_preview_bu64297.so

		echo '*   '$os'   Edit whyred.xml for MIUI            *'
		
		#fix whyred.xml for miui
		cp system/etc/device_features/whyred.xml $target
		sed '
		s/detection in camera CHANGED--/detection in camera--/
		s/camera_age_detection">false/camera_age_detection">true/
		s/object tracking in camera--/object tracking in camera CHANGED--/
		s/_object_track">false/_object_track">true/
		s/off  in camera--/off in camera CHANGED--/
		s/camera_quick_snap">false/camera_quick_snap">true/
		s/finger print capture of Camera --/finger print capture of Camera CHANGED--/
		s/front_fingerprint_sensor">true/front_fingerprint_sensor">false/
		s/camera_magic_mirror">false/camera_magic_mirror">true/
		s/android_one_device">true/android_one_device">false/' <$target >$temp
		mv $temp $target
		
		# change system with sysmiui 	
		mv system systemp
		mv sysmiui system
	fi
}


prep_twrp() {
	echo '************************************************'
	echo '*          TWRP                                *'
	echo '************************************************'
	syst=TWRP
	
	echo '*          Prepare addon.d files               *'
	cat make/twrp/restorstart > $addond
	find . -name '*.DS_Store' -type f -delete
	find system/* -type f >> $addond
	cat make/twrp/restorend >>$addond
	
	echo '*   '$os'   Set TWRP installer META-INF         *'
	cp make/twrp/updater-script META-INF/com/google/android/updater-script
	cp make/twrp/update-binary META-INF/com/google/android/update-binary
}

prep_magisk(){
	echo '*          MAGISK                              *'
	echo '************************************************'
	syst=MAGISK
	
	echo '*          Add media                           *'
	[ -d systemp ] && cp -R make/media systemp/media || cp -R make/media system/media ;
	
	echo '*   '$os'   Set Magisk module META-INF          *'
	cp make/magisk/updater-script META-INF/com/google/android/updater-script
	cp make/magisk/update-binary META-INF/com/google/android/update-binary
}

make_one(){
	[ -d systemp ] && os=MIUI || os=AOSP ;
	if [ $syst == MAGISK ];
	  then
		echo '*          Make zip: '"$os" "$syst" v"$ver"'         *'
	  	zip -r -X -q $os-$syst-$name-$ver\_$1.zip  system META-INF common README.md config.sh module.prop 
	  else
		echo '*          Make zip: '"$os" "$syst" v"$ver"'           *'
	    zip -r -X -q $os-$syst-$name-$ver\_$1.zip system mount META-INF tmp
	fi
}

make_two(){
	make_one $1
	set_miui
	make_one $1
	echo '************************************************'
	[ ! -d systemp ] && echo '                                    ...FINISHED!' ;
}

init
prep_twrp
make_two $1

prep_magisk
make_two $1


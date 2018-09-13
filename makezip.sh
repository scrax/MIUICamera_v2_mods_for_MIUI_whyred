#!/bin/sh

name=MIUICamera_v2_whyred
ver=$(sed -n -e 's/version=v// ' -e 's/ ([0-9-]*)// p' <module.prop )
lf=tmp/99-MIUICamV2.sh
target='sysmiui/etc/device_features/whyred.xml'
temp='temp.xml'
syst=''
os=''

prep_miui() {
	os=MIUI
	echo 'make MIUI whyred.xml'
	#fix whyred.xml for miui
	rm -f sysmiui/etc/device_features/whyred.xml
	cp system/etc/device_features/whyred.xml sysmiui/etc/device_features/whyred.xml
	sed '
	s/detection in camera CHANGED--/detection in camera--/
	s/camera_age_detection">false/camera_age_detection">true/
	s/object tracking in camera--/object tracking in camera CHANGED--/
	s/_object_track">false/_object_track">true/
	s/off  in camera--/off in camera CHANGED--/
	s/camera_quick_snap">false/camera_quick_snap">true/
	s/finger print capture of Camera --/finger print capture of Camera CHANGED--/
	s/front_fingerprint_sensor">true/front_fingerprint_sensor">false/
	s/camera_magic_mirror">false/camera_magic_mirror">true/' <$target >$temp
	mv $temp $target
	echo 'make MIUI system'
	# change system with sysmiui 	
	mv system systemp
	mv sysmiui system	
}

clean_miui() {
	os=AOSP
	mv system sysmiui
	mv systemp system
}

prep_twrp() {
	echo 'TWRP BUILD'
	os=AOSP
	syst=TWRP
	
	echo 'remove media'
	rm -rf system/media
	
	echo 'prepare addon.d files'
	cat make/twrp/restorstart > $lf
	find . -name '*.DS_Store' -type f -delete
	find system/* -type f >> $lf
	cat make/twrp/restorend >>$lf
	
	echo 'prepare META-INF'
	cp make/twrp/updater-script META-INF/com/google/android/updater-script
	cp make/twrp/update-binary META-INF/com/google/android/update-binary
}

prep_magisk(){
	echo ' '
	echo 'MAGISK BUILD'
	os=AOSP
	syst=MAGISK
	
	echo 'prepare media'
	cp -R make/media system/media
	
	echo 'prepare META-INF'
	cp make/magisk/updater-script META-INF/com/google/android/updater-script
	cp make/magisk/update-binary META-INF/com/google/android/update-binary
}

make_one(){
	if [ $syst == MAGISK ];
	  then
	  	echo make ZIP: $os-$syst-$name-$ver\_$1.zip
	  	zip -r -X -q $os-$syst-$name-$ver\_$1.zip common META-INF system config.sh module.prop README.md 
	  else
  		echo make ZIP: $os-$syst-$name-$ver\_$1.zip
	    zip -r -X -q $os-$syst-$name-$ver\_$1.zip mount META-INF system tmp
	fi
}

make_two(){
	make_one $1
	prep_miui
	make_one $1
	clean_miui
	echo ' '
}

prep_twrp
make_two $1
echo '+-+-+-+-+'
prep_magisk
make_two $1

echo 'FINISHED!'

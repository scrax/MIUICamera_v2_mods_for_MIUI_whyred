#!/system/bin/sh
busybox echo "# Enable Camera2 API" >> /system/build.prop;
busybox echo "persist.camera.HAL3.enabled=1" >> /system/build.prop;
exit 0;
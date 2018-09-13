# **MIUI Camera v2 port for whyred (Redmi note 5 / pro)**

## Description
This module brings MIUI Camera v2 (from Mi A2) to aosp and Los based ROM on whyred.

Tested on LineageOS 15.1 (microG version) android Oreo.
Confirmed working on other AOSP rom on Pie and MIUI.

No conflicts with gcam and camera2 API (enabled by the module).

## Functions
PHOTO

- Portrait mode
- Full manual mode (1/4s max shutter)
- Square mode
- Panorama (full quality)
- Peak focus (when manual focus)
- Grid toggle
- Object tracking shot
- Scene modes
- Tonal and color presets
- HHT
- Straighten
- Tilt-shift
- Group Selfie
- Beautify and Beautify pro (v2)
- Timer (3s and 5s)
- HDR (on, off, auto), HDR pro (default) and live HDR
- Torch mode (back and front)
- Age & gender and magic mirror modes (front camera)
- Increased burst shoot (100 pics)
- Fingerprint shutter enabled by default (system wide)

VIDEO

- 4K record (30fps)
- Video image stabilization (software)
- Slow motion
- Time lapse

AUDIO

- Audio recording fix (by @rocker00)
- AOSP camera sound toggle fix



## Changelog

v0.1      First test porting from Mi A2 camera with more functions.

v0.2      Disabled AI (gives no visible differences) and zoom options (sometimes use the worst camera).

v0.3      Enabled slow motion, image stabilization and FP shutter. Disabled portrait mode.

v0.4      Fixed system camera shutter sound, enabled magic mirror and age&gender, full size panorama and effects.

v0.5      Added initial support to Mi A1, Mi 6X, Mi A2/lite, Redmi Note 3, Redmi Note 4. 

v0.6      Enabled portrait mode (after LineageOS fixed the issues).

v0.7      Removed all devices but whyred, set default HDR pro (back) and auto (front).

v0.8      Added audio recording fix by @rocker00, restored group selfie (for test).

v0.9      Fixed video start and end record sounds.

v0.10     Granted needed permissions by default.

v0.11     Fixed FC on some ROM, Added super resolution, tele and night and parallel process options (to be tested). Temporary restored AI feature (just to test if works or not).

v0.12     Removed tick sound and other small fixes.

v0.13     Cleanup, new camera sound fix and first versions for Pie and MIUI.

v0.14     Better lowlight shot, magisk module updated.

v0.15     Revert camera sound toggle fix.

v0.16     Removed better lowlight shot causing system FC.

v0.17     Added more libs, HEVC codec, removed age&gender, obj. tracking and magic mirror from AOSP cause partially or not working; enabled asd night. Edited watermark.

v0.18     Revert to h264, mod watermark in all version, added build.prop edit (for pie support).

## Instructions

Install module in magisk or TWRP (on your choice) and reboot;
For TWRP installer make a backup of system and vendor in TWRP to unistall.

**camera2 API is not required, but will be enabled by the module**

## Links
[Module XDA Forum Thread](https://forum.xda-developers.com/redmi-note-5-pro/themes/magisk-miui-camera-v2-port-mods-t3830475 "Module official XDA thread")

[Audio recording fix XDA Thread](https://forum.xda-developers.com/redmi-note-5-pro/themes/magisk-fix-bad-camcorder-audio-quality-t3828711 "original audio record fix module thread")

[Latest stable Magisk](http://www.tiny.cc/latestmagisk)

## Contributions
slow-mo fix by @Dyneteve

sound fix by @lawong

audio recording improved by @rocker00

video recording improvements by @carlosggb and @ARNOB XENON

Pie fix by @jhenrique09

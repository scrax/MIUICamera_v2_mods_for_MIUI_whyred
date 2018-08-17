# **MIUI Camera v2 port for whyred (Redmi note 5 / pro)**

## Description
This module brings MIUI Camera v2 (from Mi A2) to aosp and Los based ROM on whyred.

Tested on LineageOS 15.1 (microG version) android Oreo.

No conflicts with gcam and camera2 API.

No editing of build.prop by the module (conflicts free)

Needs permissions enabled manually.

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
- Beautify and Beautify pro (v2)
- Timer (3s and 5s)
- HDR (on, off, auto), HDR pro (default) and live HDR
- Torch mode (back and front)
- Age & gender and magic mirror modes (front camera)
- Increased burst shoot (100 pics)
- Fingerprint shutter enabled by default (system wide)
- Camera sound toggle

VIDEO

- 4K record (30fps)
- Video image stabilization (software)
- Slow motion
- Time lapse

AUDIO

- Audio recording fix (by @rocker00)

## Changelog

v0.1      First test porting from Mi A2 camera with more functions

v0.2      Disabled AI (gives no visible differences) and zoom options (sometimes use the worst camera)

v0.3      Enabled slow motion, image stabilization and FP shutter. Disabled portrait mode

v0.4      Fixed system camera shutter sound, enabled magic mirror and age&gender, full size panorama and effects.

v0.5      Added initial support to Mi A1, Mi 6X, Mi A2/lite, Redmi Note 3, Redmi Note 4 

v0.6      Enabled portrait mode (after LineageOS fixed the issues).

v0.7      Removed all devices but whyred, set default HDR pro (back) and auto (front)

v0.8      Added audio recording fix by @rocker00, restored group selfie (for test)

## Instructions
Install module and reboot;

Before starting camera app manually enable permissions.

**camera2 API is not required**

## Links
[Module XDA Forum Thread](https://forum.xda-developers.com/redmi-note-5-pro/themes/magisk-miui-camera-v2-port-mods-t3830475 "Module official XDA thread")

[Audio recording fix XDA Thread](https://forum.xda-developers.com/redmi-note-5-pro/themes/magisk-fix-bad-camcorder-audio-quality-t3828711 "original audio record fix module thread")

[Latest stable Magisk](http://www.tiny.cc/latestmagisk)

## Contributions
slow-mo fix by @Dyneteve

sound fix by @lawong

audio recording fix by @rocker00

video recording improvements by @carlosggb and @ARNOB XENON

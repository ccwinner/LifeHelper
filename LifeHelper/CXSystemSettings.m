//
//  CXSystemSettings.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/1.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXSystemSettings.h"
#import <IOKit/IOKitServer.h>
#import <CoreAudio/CoreAudio.h>

const NSString *CX_EVENT_SYSTEMSETTINGS_BRIGHTNESS_UP = @"brightness_up";

static float _brightness = -1.;
static float _volumeLevel = -1;

@implementation CXSystemSettings

+ (void)setDisplayBrightness:(float)level {
    io_iterator_t iterator;
    kern_return_t result = IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching("IODisplayConnect"), &iterator);
    if (result == kIOReturnSuccess) {
        io_object_t service;
        while ((service = IOIteratorNext(iterator))) {
            IODisplaySetFloatParameter(service, kNilOptions, CFSTR(kIODisplayBrightnessKey), level);
            IOObjectRelease(service);
            _brightness = level;
            return;
        }
    }
}

+ (float)displayBrightness {
    if (_brightness != -1) {
        return _brightness;
    }
    io_iterator_t iterator;
    kern_return_t result = IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching("IODisplayConnect"), &iterator);
    if (result == kIOReturnSuccess) {
        io_object_t service;
        float level;
        while ((service = IOIteratorNext(iterator))) {
            IODisplayGetFloatParameter(service, kNilOptions, CFSTR(kIODisplayBrightnessKey), &level);
            IOObjectRelease(service);
            _brightness = level;
            return _brightness;
        }
    }
    return _brightness;
}

+ (void)setSystemVolume:(float)level {
    float actLevel = level * 100;
    NSString *scriptStr = [[NSString alloc] initWithFormat:@"set volume output volume %f",actLevel];
    NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:scriptStr];
    [appleScript executeAndReturnError:nil];
     _volumeLevel = actLevel;
    /* ------  使用CoreAudio太麻烦了 ----------*/
//    AudioObjectPropertyAddress defaultOutputDevicePropAddr = {
//        kAudioHardwarePropertyDefaultOutputDevice,
//        kAudioObjectPropertyScopeGlobal,
//        kAudioObjectPropertyElementMaster
//    };
//    AudioDeviceID defaultOutputDeviceID;
//    UInt32 volumedataSize = sizeof(defaultOutputDeviceID);
//    OSStatus result = AudioObjectGetPropertyData(kAudioObjectSystemObject,
//                                                 &defaultOutputDevicePropAddr,
//                                                 0, NULL,
//                                                 &volumedataSize, &defaultOutputDeviceID);
//    
//    if(kAudioHardwareNoError != result)
//        return;
//    
//    AudioObjectPropertyAddress volumePropertyAddress = {
//        kAudioDevicePropertyVolumeScalar,
//        kAudioDevicePropertyScopeOutput,
//        1 /*LEFT_CHANNEL*/
//    };
//    
//    Float32 volume;
//    volumedataSize = sizeof(volume);
//    
//    result = AudioObjectSetPropertyData(defaultOutputDeviceID,
//                                        &volumePropertyAddress,
//                                        0, NULL,
//                                        sizeof(volume), &volume);
//    if (result != kAudioHardwareNoError) {
//        // ... handle error ...
//    }
}

+ (int)systemVolume {
    if (_volumeLevel != -1) {
        return _volumeLevel;
    }
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:@"output volume of (get volume settings)"];
    _volumeLevel = [[script executeAndReturnError:nil] int32Value];
    return _volumeLevel;
}

@end

//
//  CXSystemSettings.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/1.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXSystemSettings.h"
#import <IOKit/IOKitServer.h>

const NSString *CX_EVENT_SYSTEMSETTINGS_BRIGHTNESS_UP = @"brightness_up";

static int _brightness = -1.;
static int _volumeLevel = -1;

@implementation CXSystemSettings

+ (void)setDisplayBrightness:(int)level {
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

+ (int)displayBrightness {
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

+ (void)setSystemVolume:(int)level {
    NSString *scriptStr = [[NSString alloc] initWithFormat:@"set volume output volume %d",level];
    NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:scriptStr];
    [appleScript executeAndReturnError:nil];
    _volumeLevel = level;
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

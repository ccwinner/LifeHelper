//
//  CXClientSettingsCacheModel.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/11.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXClientSettingsCacheModel.h"

NSString *kBrightnessCodingKey = @"com.tomcc.client.cache_brightnessKey";
NSString *kVolumnCodingKey = @"com.tomcc.client.cache_volumnKey";

@implementation CXClientSettingsCacheModel

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeFloat:_brightness forKey:kBrightnessCodingKey];
    [coder encodeFloat:_volume forKey:kVolumnCodingKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _brightness = [aDecoder decodeFloatForKey:kBrightnessCodingKey];
        _volume = [aDecoder decodeFloatForKey:kVolumnCodingKey];
    }
    return self;
}
@end

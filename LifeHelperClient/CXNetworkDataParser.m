//
//  CXNetworkDataParser.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/9.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXNetworkDataParser.h"
#import "CXNetworkEventModel.h"
#import "CXSystemSettings.h"
#import <YYModel.h>

@implementation CXNetworkDataParser

//先设置音量和亮度吧，后面再加入更复杂的需求, 同时需要将模型细分
+ (void)parseDataDict:(NSDictionary *)dataDict {
    if (!dataDict || ![dataDict isKindOfClass:[NSDictionary class]]) {
        return;
    }

    CXNetworkEventModel *dataModel = [CXNetworkEventModel yy_modelWithDictionary:dataDict];
    switch (dataModel.eventType) {
        case CXNetworkEventTypeSettingsBrightness:
            [self processSystemSettingsBrightnessData:dataModel];
            break;
        case CXNetworkEventTypeSettingsVolum:
            [self processSystemSettingsVolumnData:dataModel];
            break;
        default:
            break;
    }
}

+ (void)processSystemSettingsBrightnessData:(CXNetworkEventModel *)data {
    float newValue = -1.;
    newValue = [data.eventContent[kNetworkEventBrightnessKeyNew] floatValue];
    if (flessthan(newValue, 0.0) || flargerthan(newValue, 1.0)) {
        NSLog(@"设置的亮度不符合要求");
        return;
    }
    CXDispatchToMainThread(^{
        [CXSystemSettings setDisplayBrightness:newValue];
    });
}

+ (void)processSystemSettingsVolumnData:(CXNetworkEventModel *)data {
    int newValue = -1.;
    newValue = [data.eventContent[kNetworkEventVolumnKeyNew] intValue];
    if (newValue < 0 || newValue > 1) {
        NSLog(@"设置的音量不符合要求");
        return;
    }
    CXDispatchToMainThread(^{
        [CXSystemSettings setSystemVolume:newValue];
    });
}
@end

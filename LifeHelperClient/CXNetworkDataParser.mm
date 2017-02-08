//
//  CXNetworkDataParser.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/9.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXNetworkDataParser.h"
#import "CXNetworkEventModel.h"
#import <YYModel.h>
#include <unordered_map>

class CXNetworkDataParserTuple {
public:
    CXNetworkEventType type;
};

class CXNetworkDataParserDataTuple: public CXNetworkDataParserTuple {
public:
    float oldValue;
    float newValue;
};

class CXNetworkDataParserCommandTuple: public CXNetworkDataParserTuple {
public:
    std::unordered_map<const char *, const char *> command_map; //在这里 如果是打开App, 则是app的名字
};

@implementation CXNetworkDataParser

+ (instancetype)dataParser {
    return [CXNetworkDataParser new];
}

#pragma mark - come on, 胶水代码

#pragma mark - data parse seg
//先设置音量和亮度吧，后面再加入更复杂的需求, 同时需要将模型细分
- (void)parseDataDict:(NSDictionary *)dataDict completion:(completeCallback)completion {
    if (!dataDict || ![dataDict isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    CXNetworkEventModel *dataModel = [CXNetworkEventModel yy_modelWithDictionary:dataDict];
    CXNetworkDataParserTuple *tuple = NULL;
    switch (dataModel.eventType) {
        case CXNetworkEventTypeSettingsBrightness:
            tuple = [self processSystemSettingsBrightnessData:dataModel];
            break;
        case CXNetworkEventTypeSettingsVolum:
            tuple = [self processSystemSettingsVolumnData:dataModel];
            break;
        default:
            break;
    }
    
    if (!tuple) return;
    
    dispatch_async(_callbackQueue ? : dispatch_get_main_queue(), ^{
        if (completion) {
            switch (dataModel.eventType) {
                case CXNetworkEventTypeSettingsVolum:
                case CXNetworkEventTypeSettingsBrightness:
                    completion(dataModel.eventType, @(((CXNetworkDataParserDataTuple *)tuple)->oldValue), @(((CXNetworkDataParserDataTuple *)tuple)->newValue));
                    break;
                case CXNetworkEventTypeClickCommandOpenApp: {
                    const char *capp = ((CXNetworkDataParserCommandTuple *)tuple)->command_map["open_app"];
                    completion(dataModel.eventType, nil, [NSString stringWithUTF8String:capp]);
                    break;
                }
                default:
                    break;
            }
            
        }
        delete tuple;
    });
}

- (CXNetworkDataParserTuple *)processSystemSettingsBrightnessData:(CXNetworkEventModel *)data {
    float newValue = -1.;
    newValue = [data.eventContent[kNetworkEventBrightnessKeyNew] floatValue];
    if (flessthan(newValue, 0.0) || flargerthan(newValue, 1.0)) {
        NSLog(@"设置的亮度不符合要求");
        return NULL;
    }
    
    CXNetworkDataParserDataTuple *tuple = new CXNetworkDataParserDataTuple();
    tuple->newValue = newValue;
    return tuple;
}

- (CXNetworkDataParserTuple *)processSystemSettingsVolumnData:(CXNetworkEventModel *)data {
    float newValue = [data.eventContent[kNetworkEventVolumnKeyNew] floatValue];
    if (newValue < 0 || newValue > 1) {
        NSLog(@"设置的音量不符合要求");
        return NULL;
    }
    
    CXNetworkDataParserDataTuple *tuple = new CXNetworkDataParserDataTuple();
    tuple->newValue = newValue;
    return tuple;
}

- (CXNetworkDataParserTuple *)processCustomCommandOpenApp:(CXNetworkEventModel *)data {
    NSString *appName =data.eventContent[@"open_app"];
    if (!appName || appName.length == 0) {
        return NULL;
    }
    CXNetworkDataParserCommandTuple *tuple = new CXNetworkDataParserCommandTuple();
    tuple->command_map["open_app"] = [appName UTF8String];
    return tuple;
}
@end

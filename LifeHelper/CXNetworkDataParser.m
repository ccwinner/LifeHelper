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

typedef struct {
    int oldValue;
    int newValue;
} CXNetworkDataParserDataTuple;

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
    CXNetworkDataParserDataTuple *tuple = NULL;
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
            completion(dataModel.eventType, tuple->oldValue, tuple->newValue);
        }
        free(tuple);
    });
}

- (CXNetworkDataParserDataTuple *)processSystemSettingsBrightnessData:(CXNetworkEventModel *)data {
    float newValue = -1.;
    newValue = [data.eventContent[kNetworkEventBrightnessKeyNew] floatValue];
    if (flessthan(newValue, 0.0) || flargerthan(newValue, 1.0)) {
        NSLog(@"设置的亮度不符合要求");
        return NULL;
    }

    CXNetworkDataParserDataTuple *tuple = calloc(1, sizeof(CXNetworkDataParserDataTuple));
    tuple->newValue = newValue;
    return tuple;
}

- (CXNetworkDataParserDataTuple *)processSystemSettingsVolumnData:(CXNetworkEventModel *)data {
    int newValue = -1.;
    newValue = [data.eventContent[kNetworkEventVolumnKeyNew] intValue];
    if (newValue < 0 || newValue > 1) {
        NSLog(@"设置的音量不符合要求");
        return NULL;
    }

    CXNetworkDataParserDataTuple *tuple = calloc(1, sizeof(CXNetworkDataParserDataTuple));
    tuple->newValue = newValue;
    return tuple;
}
@end

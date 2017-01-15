//
//  CXNetworkEventModel.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/7.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXNetworkEventModel.h"

@implementation CXNetworkEventModel

- (instancetype)initWithEventType:(CXNetworkEventType)eventType
                        eventDesc:(NSString *)eventDesc
                     eventContent:(NSData *)eventContent{
    if (self = [super init]) {
        _eventType = eventType;
        _eventDesc = eventDesc;
        _eventContent = eventContent;
    }
    return self;
}

@end

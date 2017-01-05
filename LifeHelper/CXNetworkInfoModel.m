//
//  CXNetworkInfoModel.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/4.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXNetworkInfoModel.h"

@implementation CXNetworkInfoModel

- (instancetype)initWithIP:(NSString *)ipAddress
                   recPort:(int)recPort
                  sendPort:(int)sendPort{
    if (self = [super init]) {
        _ipAddress = ipAddress;
        _recPort = recPort;
        _sendPort = sendPort;
    }
    return self;
}

@end

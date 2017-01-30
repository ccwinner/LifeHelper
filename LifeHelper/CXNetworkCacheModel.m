//
//  CXNetworkCacheModel.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/4.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXNetworkCacheModel.h"

@implementation CXNetworkCacheModel

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

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    _ipAddress = [aDecoder decodeObjectForKey:@"ipAddress"];
    _recPort = (int)[aDecoder decodeIntegerForKey:@"recPort"];
    _sendPort = (int)[aDecoder decodeIntegerForKey:@"sendPort"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_ipAddress forKey:@"ipAddress"];
    [aCoder encodeInteger:_recPort forKey:@"recPort"];
    [aCoder encodeInteger:_sendPort forKey:@"sendPort"];
}
@end

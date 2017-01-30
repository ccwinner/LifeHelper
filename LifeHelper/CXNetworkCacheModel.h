//
//  CXNetworkCacheModel.h
//  LifeHelper
//
//  Created by chenxiao on 2017/1/4.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXNetworkCacheModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *ipAddress;
@property (nonatomic, assign) int recPort;
@property (nonatomic, assign) int sendPort;

- (instancetype)initWithIP:(NSString *)ipAddress
                   recPort:(int)recPort
                  sendPort:(int)sendPort;
@end

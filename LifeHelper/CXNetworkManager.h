//
//  CXNetworkManager.h
//  LifeHelper
//
//  Created by chenxiao on 2017/1/5.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CXNetworkManager;

FOUNDATION_EXPORT CXNetworkManager* CXNetworkManagerInstance();

@interface CXNetworkManager : NSObject

@property (nonatomic, assign) int recPort;
@property (nonatomic, assign) int sendPort;
@property (nonatomic, copy) void (^onReceivngDataCompletion)(CXNetworkEventType type, int oldValue, int newValue);

/**
 主动监听接收数据
 */
- (void)onReceivingData;

@end

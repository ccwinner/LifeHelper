//
//  CXNetworkManager.h
//  LifeHelper
//
//  Created by chenxiao on 2017/1/5.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CXNetworkManager, CXNetworkEventModel;

FOUNDATION_EXPORT CXNetworkManager* CXNetworkManagerInstance();

@interface CXNetworkManager : NSObject

@property (nonatomic, assign) int recPort;
@property (nonatomic, assign) int sendPort;
@property (nonatomic, copy) NSString *sendAddress;
@property (nonatomic, copy) void (^onReceivngDataCompletion)(CXNetworkEventType type, float oldValue, float newValue);

/**
 host端主动监听接收数据
 */
- (void)onReceivingData;

/**
 发送数据

 @param model shuju
 */
- (void)sendModel:(CXNetworkEventModel *)model;
@end

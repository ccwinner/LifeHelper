//
//  CXNetworkManagerServer.h
//  LifeHelper
//
//  Created by chenxiao on 2017/1/5.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CXNetworkManagerServer;

FOUNDATION_EXPORT CXNetworkManagerServer* CXNetworkManagerServerInstance();

@interface CXNetworkManagerServer : NSObject

@property (nonatomic, assign) int recPort;
@property (nonatomic, assign) int sendPort;

@end

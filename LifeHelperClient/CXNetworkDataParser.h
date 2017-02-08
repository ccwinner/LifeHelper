//
//  CXNetworkDataParser.h
//  LifeHelper
//
//  Created by chenxiao on 2017/1/9.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completeCallback)(CXNetworkEventType type, id value1, id value2);

@interface CXNetworkDataParser : NSObject

@property (nonatomic, strong) dispatch_queue_t callbackQueue;

+ (instancetype)dataParser;
- (void)parseDataDict:(NSDictionary *)dataDict completion:(completeCallback)completion;

@end

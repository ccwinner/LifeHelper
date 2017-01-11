//
//  CXQueue.h
//  LifeHelper
//
//  Created by chenxiao on 2017/1/7.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXQueue : NSObject

- (instancetype)initWithName:(const char *)name;

- (dispatch_queue_t)nativeQueue;
- (void)dispatchToQueue:(dispatch_block_t)block synchronous:(BOOL)isSync;
- (void)dispatchToQueue:(dispatch_block_t)block;

@end

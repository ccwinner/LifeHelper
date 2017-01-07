//
//  CXQueue.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/7.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXQueue.h"

@interface CXQueue ()
{
    dispatch_queue_t _queue;
    bool _isMainQueue;
    const char *_name;
}

@end

@implementation CXQueue

- (instancetype)initWithName:(const char *)name
{
    if (self = [super init]) {
        _name = name;
        _queue = dispatch_queue_create(_name, 0);
        dispatch_queue_set_specific(_queue, _name, (void *)_name, NULL);
        _isMainQueue = false;
    }
    return self;
}

- (void)dealloc
{
    _queue = nil;
}

- (void)dispatchToQueue:(dispatch_block_t)block synchronous:(BOOL)isSync
{
    if (!block) {
        return;
    }
    
    if (_queue) {
        if (_isMainQueue) {
            if ([NSThread isMainThread]) {
                block();
            }else if(isSync)
                dispatch_sync(_queue, block);
            else
                dispatch_async(_queue, block);
        }else {
            if (_name && dispatch_get_specific(_name) == _name) {
                block();
            }else if(isSync)
                dispatch_sync(_queue, block);
            else
                dispatch_async(_queue, block);
        }
    }
}

- (void)dispatchToQueue:(dispatch_block_t)block
{
    [self dispatchToQueue:block synchronous:false];
}

- (dispatch_queue_t)nativeQueue
{
    return _queue;
}

@end

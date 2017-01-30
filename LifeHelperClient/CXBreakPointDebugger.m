//
//  CXBreakPointDebugger.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/21.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXBreakPointDebugger.h"

@implementation CXBreakPointDebugger

+ (void)startContinuousDebuggerHelper {

#if DEBUG
    dispatch_queue_t queue = dispatch_get_main_queue();
    static dispatch_source_t source = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        source = dispatch_source_create(DISPATCH_SOURCE_TYPE_SIGNAL, SIGSTOP, 0, queue);
        if (source) {
            dispatch_source_set_event_handler(source, ^{
                NSLog(@"heheda self: %@", self);
            });
            dispatch_resume(source);
        }
    });
#endif
}

@end

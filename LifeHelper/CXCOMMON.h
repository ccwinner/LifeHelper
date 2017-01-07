//
//  CXCOMMON.h
//  LifeHelper
//
//  Created by chenxiao on 2017/1/7.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#ifndef CXCOMMON_h
#define CXCOMMON_h

#import <Foundation/Foundation.h>
NS_INLINE void CXDispatchToMainThread(dispatch_block_t block)
{
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

#endif /* CXCOMMON_h */

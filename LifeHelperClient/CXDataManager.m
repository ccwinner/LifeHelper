//
//  CXDataManager.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/11.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXDataManager.h"
#import <libkern/OSAtomic.h>
//model
#import "CXClientSettingsCacheModel.h"
#import <YYCache.h>

NSString *kClientSettingsCacheKey = @"com.tomcc.client.dataCacheKey";

@implementation CXDataManager
{
    YYCache *_cache;
}

+ (instancetype)sharedManager {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    //试试另一种单例方法
    static CXDataManager *_instance = nil;
    if (!_instance) {
        CXDataManager *tmp = [CXDataManager new];
        if (!OSAtomicCompareAndSwapPtrBarrier(NULL, (__bridge void *)tmp, (__bridge void *)_instance)) {
            tmp = nil;
        }
    }
    return _instance;
#pragma clang diagnostic pop
}

- (instancetype)init {
    if (self = [super init]) {
        _cache = [YYCache cacheWithName:kClientSettingsCacheKey];
    }
    return self;
}

- (CXClientSettingsCacheModel *)loadData {
    //可以把缓存在本地和提取本地数据写在DataMgr，或者写在其他地方；网络请求肯定得挪挪位置的
    CXClientSettingsCacheModel *model = [_cache objectForKey:kClientSettingsCacheKey];
    return nil;
}
@end

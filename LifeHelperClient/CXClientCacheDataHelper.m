//
//  CXClientCacheDataHelper.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/27.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXClientCacheDataHelper.h"
#import <YYCache.h>
#import "CXClientSettingsCacheModel.h"

NSString *kClientSettingsCacheName = @"com.tomcc.client.dataCacheName";
NSString *kClientSettingsCacheDataKey = @"com.tomcc.client.dataCacheKey";

@implementation CXClientCacheDataHelper
{
    //其实没有很强烈的缓存需求, 只是想熟悉熟悉第三方库
    YYCache *_cache;
}

- (instancetype)init {
    if (self = [super init]) {
        _cache = [YYCache cacheWithName:kClientSettingsCacheName];
    }
    return self;
}

#pragma mark - methods
- (CXClientSettingsCacheModel *)loadData {
    //可以把缓存在本地和提取本地数据写在DataMgr，或者写在其他地方；网络请求肯定得挪挪位置的
    CXClientSettingsCacheModel *model = (CXClientSettingsCacheModel *)[_cache objectForKey:kClientSettingsCacheDataKey];
    return model;
}

- (void)sychronize {
    CXClientSettingsCacheModel *model = [[CXClientSettingsCacheModel alloc] init];
    model.brightness = _brightness;
    model.volume = _volume;
    [_cache setObject:model forKey:kClientSettingsCacheDataKey];
}
@end

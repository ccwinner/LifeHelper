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
//#import "CXClientSettingsCacheModel.h"
#import "CXClientCacheDataHelper.h"
//network
#import "CXNetworkManager.h"

@implementation CXDataManager
{
    CXClientCacheDataHelper *_cacheHelper;
}

+ (instancetype)sharedManager {
    //试试另一种单例方法(在ARC下不可行。。。)
    static CXDataManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [CXDataManager new];
    });
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _cacheHelper = [CXClientCacheDataHelper new];
    }
    return self;
}

#pragma mark - network methods
- (void)prepareForNetworkConnection {
    CXNetworkManagerInstance().sendPort = CX_SERVER_REC_PORT;
    CXNetworkManagerInstance().recPort = CX_CLIENT_REC_PORT;
    [CXNetworkManagerInstance() setOnReceivngDataCompletion:^(CXNetworkEventType type, int oldValue, int newValue) {
        int params[] = {type, oldValue, newValue};
        [self processDataAndInformUI:params];
    }];
}

- (void)connectToHost {
    [CXNetworkManagerInstance() onReceivingData];
}

- (void)sendModel:(id)model {
    [CXNetworkManagerInstance() sendModel:model];
}

#pragma mark - cache methods
- (void)storeData {
    [_cacheHelper sychronize];
}

#pragma mark - process received data
- (void)processDataAndInformUI:(int *)params {
    switch (params[0]) {
        case CXNetworkEventTypeSettingsBrightness:
            //发通知还是？？？
            _cacheHelper.brightness = params[2];
            break;
        case CXNetworkEventTypeSettingsVolum:
            _cacheHelper.volume = params[2];
            break;
        default:
            break;
    }
}
@end

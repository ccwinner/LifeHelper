//
//  CXDataManager.h
//  LifeHelper
//
//  Created by chenxiao on 2017/1/11.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CXClientSettingsCacheModel;

#define CX_DataManager ([CXDataManager sharedManager])

@interface CXDataManager : NSObject

+ (instancetype)sharedManager;

//network
- (void)prepareForNetworkConnection;
- (void)connectToHost;
- (void)sendModel:(id)model;
- (NSString *)ipAddress;
//cache
- (void)storeData;
@end

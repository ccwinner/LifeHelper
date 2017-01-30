//
//  CXClientCacheDataHelper.h
//  LifeHelper
//
//  Created by chenxiao on 2017/1/27.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CXClientSettingsCacheModel;

@interface CXClientCacheDataHelper : NSObject

@property (nonatomic, assign) int brightness;
@property (nonatomic, assign) int volume;

/**
 加载设置数据，比如亮度，音量等设置
 
 @return 模型
 */
- (CXClientSettingsCacheModel *)loadData;

/**
 将缓存的数据存入本地
 */
- (void)sychronize;
@end

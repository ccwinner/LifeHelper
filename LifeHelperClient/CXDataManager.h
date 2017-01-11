//
//  CXDataManager.h
//  LifeHelper
//
//  Created by chenxiao on 2017/1/11.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CXClientSettingsCacheModel;

#define CX_DataManager [CXDataManager sharedManager]

@interface CXDataManager : NSObject

+ (instancetype)sharedManager;

/**
 加载设置数据，比如亮度，音量等设置

 @return 模型
 */
- (CXClientSettingsCacheModel *)loadData;
@end

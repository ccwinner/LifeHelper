//
//  CXSystemSettings.h
//  LifeHelper
//
//  Created by chenxiao on 2017/1/1.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSString *CX_EVENT_SYSTEMSETTINGS_BRIGHTNESS_UP;

@interface CXSystemSettings : NSObject

/**
 设置屏幕亮度

 @param level 1 最大
 */
+ (void)setDisplayBrightness:(int)level;

/**
 屏幕亮度

 @return 亮度
 */
+ (int)displayBrightness;

/**
 设置系统声音

 @param level 1 最响
 */
+ (void)setSystemVolume:(int)level;
/**
 获取系统声音级别
 
 @return 级别
 */
+ (int)systemVolume;
@end

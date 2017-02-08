//
//  CXCustomCommandWorker.h
//  LifeHelper
//
//  Created by chenxiao on 2017/2/6.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXCustomCommandWorker : NSObject

#pragma mark - launch commands
+ (void)launchXcode;
+ (void)launchChrome;
+ (void)launchDash;
+ (void)launchAppWithAppName:(NSString *)appName;

@end

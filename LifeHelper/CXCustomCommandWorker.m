//
//  CXCustomCommandWorker.m
//  LifeHelper
//
//  Created by chenxiao on 2017/2/6.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXCustomCommandWorker.h"

static inline void get_app_name(SEL origin_sel, char ** res_name) {
    const char *origin_name = sel_getName(origin_sel);
    unsigned long res_length = strlen(origin_name) - 6;
    *res_name = (char *)malloc(res_length + 1);
    memcpy(*res_name, origin_name + 6, res_length);
}

@implementation CXCustomCommandWorker

#pragma mark - launch commands
+ (void)launchXcode {
    char *res_name;
    get_app_name(_cmd, &res_name);
    [self launchAppWithAppName:[NSString stringWithUTF8String:res_name]];
    free(res_name);
}

+ (void)launchChrome {
    char *res_name;
    get_app_name(_cmd, &res_name);
    [self launchAppWithAppName:[NSString stringWithUTF8String:res_name]];
    free(res_name);
}

+ (void)launchDash {
    char *res_name;
    get_app_name(_cmd, &res_name);
    [self launchAppWithAppName:[NSString stringWithUTF8String:res_name]];
    free(res_name);
}

+ (void)launchAppWithAppName:(NSString *)appName {
    NSAssert(appName.length > 0, @"应用名称必须有!");
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/open";
    NSString *appArgu = [appName stringByAppendingString:@"://"];
    task.arguments = @[appArgu];
    [task launch];
}

@end

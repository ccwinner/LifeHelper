//
//  CXNetworkEventModel.h
//  LifeHelper
//
//  Created by chenxiao on 2017/1/7.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CXNetworkEventType) {
    CXNetworkEventTypeSystemSettings = 0, //CXNetworkEventTypeSettings, 比如音量, 亮度
    CXNetworkEventTypeClickCommand = 2 //比如打开app之类的指令命令
};

typedef NS_ENUM(NSInteger, CXNetworkEventTypeSettings) {
    CXNetworkEventTypeSettingsBrightness,
    CXNetworkEventTypeSettingsVolum
};

@interface CXNetworkEventModel : NSObject

@property (nonatomic, assign) CXNetworkEventType eventType;
@property (nonatomic, copy)   NSString *eventDesc;
@property (nonatomic, strong) NSData *eventContent;

- (instancetype)initWithEventType:(CXNetworkEventType)eventType
                        eventDesc:(NSString *)eventDesc
                     eventContent:(NSData *)eventContent;
@end

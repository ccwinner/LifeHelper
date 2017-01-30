//
//  CXNetworkEventModel.h
//  LifeHelper
//
//  Created by chenxiao on 2017/1/7.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNetworkEventBrightnessKeyOld (@"networkEvent.brightness.old")
#define kNetworkEventBrightnessKeyNew (@"networkEvent.brightness.new")
#define kNetworkEventVolumnKeyOld (@"networkEvent.volumn.old")
#define kNetworkEventVolumnKeyNew (@"networkEvent.volumn.new")

@interface CXNetworkEventModel : NSObject

@property (nonatomic, assign) CXNetworkEventType eventType;
@property (nonatomic, copy)   NSString *eventDesc;
@property (nonatomic, strong) NSDictionary *eventContent;

- (instancetype)initWithEventType:(CXNetworkEventType)eventType
                        eventDesc:(NSString *)eventDesc
                     eventContent:(NSDictionary *)eventContent;
@end

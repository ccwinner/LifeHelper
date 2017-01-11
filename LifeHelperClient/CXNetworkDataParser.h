//
//  CXNetworkDataParser.h
//  LifeHelper
//
//  Created by chenxiao on 2017/1/9.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CXNetworkEventModel;

@interface CXNetworkDataParser : NSObject

+ (void)parseDataDict:(NSDictionary *)dataDict;

@end

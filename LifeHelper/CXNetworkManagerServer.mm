//
//  CXNetworkManager.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/5.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXNetworkManagerServer.h"
#import "GCDAsyncUdpSocket.h"
#import "CXNetworkEventModel.h"
#import <YYModel.h>
#import "CXQueue.h"
//settings
#import "CXSystemSettings.h"

CXNetworkManagerServer * CXNetworkManagerServerInstance() {
    static CXNetworkManagerServer *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [CXNetworkManagerServer new];
    });
    return _instance;
}

@interface CXNetworkManagerServer ()<GCDAsyncUdpSocketDelegate>

@end

@implementation CXNetworkManagerServer
{
    GCDAsyncUdpSocket *_udpSocket;
    CXQueue            *_delegateQueue;
}

- (instancetype)init {
    if (self = [super init]) {
        _delegateQueue = [[CXQueue alloc] initWithName:"com.tomcc.server.delegateQueue"];
        _udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self
                                                   delegateQueue:_delegateQueue.nativeQueue];
        [self commonSetup];
    }
    return self;
}

- (void)commonSetup {

    //socket
    NSError *error = nil;
    _udpSocket.maxReceiveIPv4BufferSize = 65535; //来自头文件的说明,为了兼容, 取UINT16
    [_udpSocket bindToPort:_recPort error:&error];
    NSAssert(error == nil, @"服务端绑定端口居然他妈的失败了");
    error = nil;
    [_udpSocket beginReceiving:&error];
    NSAssert(error == nil, @"无法持续接收信息");
}

- (void)sendData {
    
}

#pragma mark - GCDAsyncUdpSocketDelegate

/**
 * Called when the socket has received the requested datagram.
 **/
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
withFilterContext:(nullable id)filterContext {
    NSError *error = nil;
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"Server receive data failed due to json serialization error");
        return;
    }
    CXNetworkEventModel *dataModel = [CXNetworkEventModel yy_modelWithDictionary:dataDict];
    switch (dataModel.eventType) {
        case CXNetworkEventTypeSystemSettings:
            [self processSystemSettings:dataModel];
            break;
        default:
            break;
    }
}

#pragma mark - private methods
- (void)processSystemSettings:(CXNetworkEventModel *)data {
    switch (data.eventType) {
        case CXNetworkEventTypeSettingsBrightness:
            if ([data.eventDesc isEqualToString:CX_EVENT_SYSTEMSETTINGS_BRIGHTNESS_UP]) {
                //TODO: 获取新数值 交个CXSystemSettings 去处理
            } else {
                
            }
            break;
            
        default:
            break;
    }
    CXDispatchToMainThread(^{
        //
    });
}

@end

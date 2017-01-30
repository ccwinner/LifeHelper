//
//  CXNetworkManager.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/5.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXNetworkManager.h"
#import "GCDAsyncUdpSocket.h"
#import "CXQueue.h"
//settings
#import "CXNetworkDataParser.h"
#import "CXNetworkEventModel.h"
#import <YYModel.h>

CXNetworkManager * CXNetworkManagerInstance() {
    static CXNetworkManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [CXNetworkManager new];
    });
    return _instance;
}

@interface CXNetworkManager ()<GCDAsyncUdpSocketDelegate>

@property (nonatomic, copy) void (^onReceivngDataCompletion)(CXNetworkEventType type, float oldValue, float newValue);

@end

@implementation CXNetworkManager
{
    GCDAsyncUdpSocket               *_udpSocket;
    CXQueue                         *_delegateQueue;
    CXNetworkDataParser             *_dataParser;
    dispatch_queue_t                _dataParsingQueue;
}

- (instancetype)init {
    if (self = [super init]) {
        _delegateQueue = [[CXQueue alloc] initWithName:"com.tomcc.server.delegateQueue"];
        _udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self
                                                   delegateQueue:_delegateQueue.nativeQueue];
        _dataParser = [CXNetworkDataParser dataParser];
        _dataParsingQueue = dispatch_queue_create("com.tomcc.serverNetwork.dataParser_Queue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)onReceivingData {
    //socket
    NSError *error = nil;
    _udpSocket.maxReceiveIPv4BufferSize = 65535; //来自头文件的说明,为了兼容, 取UINT16
    [_udpSocket bindToPort:_recPort error:&error];
    NSAssert(error == nil, @"服务端绑定端口居然他妈的失败了");
    error = nil;
    [_udpSocket beginReceiving:&error];
    NSAssert(error == nil, @"无法持续接收信息");
}

#pragma mark - send data
- (void)sendModel:(CXNetworkEventModel *)model {
    NSData *data = [model yy_modelToJSONData];
    [_udpSocket sendData:data toHost:_sendAddress port:_sendPort withTimeout:0 tag:0];
}

#pragma mark - setters
- (void)setOnReceivngDataCompletion:(void (^)(CXNetworkEventType, float, float))onReceivngDataCompletion {
    _onReceivngDataCompletion = [onReceivngDataCompletion copy];
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
    //TODO:如果能包装出一个带发送成功后的回调的方法就好
    dispatch_async(_dataParsingQueue, ^{
        [_dataParser parseDataDict:dataDict completion:self.onReceivngDataCompletion];
    });
}

#pragma mark - private methods

@end

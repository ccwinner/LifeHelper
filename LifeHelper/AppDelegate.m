//
//  AppDelegate.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/1.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "AppDelegate.h"
#import "CXNetworkTool.h"
#import "CXNetworkCacheModel.h"
#import "CXNetworkManagerServer.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *iPAddressLabel;
@property (weak) IBOutlet NSTextField *sendPortLabel;
@property (weak) IBOutlet NSTextField *receivePortLabel;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    //TODO: 获取并显示界面上的本机 ip_address, send_port, rec_port
    CXNetworkCacheModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:CX_ARCHIEVED_NETINFO_FILE];
    if (!model) {
        NSString *hostAddr = [CXNetworkTool hostIpAddress];
        model = [[CXNetworkCacheModel alloc] initWithIP:hostAddr
                                               recPort:CX_SERVER_REC_PORT
                                              sendPort:0];
        [NSKeyedArchiver archiveRootObject:model toFile:CX_ARCHIEVED_NETINFO_FILE];
    }
    [self loadViews:model];
    //TODO: 网络连接准备
    [self doPreNetworkAndStart:model];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - private methods
- (void)loadViews: (CXNetworkCacheModel *)data {
    //其实接收和发送端口都是自定义的 只要不在系统的预留范围内就行
    self.iPAddressLabel.stringValue = data.ipAddress;
    self.receivePortLabel.stringValue = [NSString stringWithFormat:@"receive port: %d", data.recPort];
    self.sendPortLabel.stringValue = [NSString stringWithFormat:@"send port: %d", data.sendPort];
}

- (void)doPreNetworkAndStart:(CXNetworkCacheModel *)data {
    CXNetworkManagerServerInstance().recPort = data.recPort;
    CXNetworkManagerServerInstance().sendPort = data.sendPort;
}

@end

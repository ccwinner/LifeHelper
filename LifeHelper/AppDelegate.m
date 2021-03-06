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
#import "CXNetworkManager.h"
#import "CXSystemSettings.h"
#import "CXCustomCommandWorker.h"
#import "CXCustomCommandWorker.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *iPAddressLabel;
@property (weak) IBOutlet NSTextField *sendPortLabel;
@property (weak) IBOutlet NSTextField *receivePortLabel;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    //TODO: 获取并显示界面上的本机 ip_address, send_port, rec_port
//    CXNetworkCacheModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:CX_ARCHIEVED_NETINFO_FILE];
//    if (!model) {
//    CXNetworkCacheModel *model = nil;
        NSString *hostAddr = [CXNetworkTool hostIpAddress];
        CXNetworkCacheModel *model = [[CXNetworkCacheModel alloc] initWithIP:hostAddr
                                               recPort:CX_SERVER_REC_PORT
                                              sendPort:CX_CLIENT_REC_PORT];
      //  [NSKeyedArchiver archiveRootObject:model toFile:CX_ARCHIEVED_NETINFO_FILE];
//    }
    [self loadViews:model];
    //TODO: 网络连接准备
    [self doPreNetworkAndStart:model];
//    [[NSWorkspace sharedWorkspace].notificationCenter addObserver:self
//                                                         selector:@selector(listNotifis:)
//                                                             name:nil
//                                                           object:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CXCustomCommandWorker launchDash];
    });
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

//- (void)listNotifis:(NSNotification *)notification {
//    NSLog(@"%@ : %@", notification.name, notification.object);
//}

#pragma mark - private methods
- (void)loadViews: (CXNetworkCacheModel *)data {
    //其实接收和发送端口都是自定义的 只要不在系统的预留范围内就行
    self.iPAddressLabel.stringValue = data.ipAddress;
    self.receivePortLabel.stringValue = [NSString stringWithFormat:@"receive port: %d", data.recPort];
    self.sendPortLabel.stringValue = [NSString stringWithFormat:@"send port: %d", data.sendPort];
}

- (void)doPreNetworkAndStart:(CXNetworkCacheModel *)data {
    CXNetworkManagerInstance().recPort = data.recPort;
    CXNetworkManagerInstance().sendPort = data.sendPort;
    CXNetworkManagerInstance().onReceivngDataCompletion = ^(NSInteger type, id value1, id value2) {
        if (CXNetworkEventTypeSettingsBrightness == type) {
            [CXSystemSettings setDisplayBrightness:[(NSNumber *)value2 floatValue]];
        } else if (CXNetworkEventTypeSettingsVolum == type) {
            [CXSystemSettings setSystemVolume:[(NSNumber *)value2 floatValue]];
        } else if (CXNetworkEventTypeClickCommandOpenApp == type) {
            [CXCustomCommandWorker launchAppWithAppName:value2];
        }
        self.iPAddressLabel.stringValue = @"收到了";
    };
    [CXNetworkManagerInstance() onReceivingData];
}

@end

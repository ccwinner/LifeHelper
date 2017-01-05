//
//  AppDelegate.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/1.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "AppDelegate.h"
#import "CXNetworkTool.h"
#import "CXNetworkInfoModel.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *iPAddressLabel;
@property (weak) IBOutlet NSTextField *sendPortLabel;
@property (weak) IBOutlet NSTextField *receivePortLabel;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    //TODO: 获取并显示界面上的本机 ip_address, send_port, rec_port
    CXNetworkInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:CX_ARCHIEVED_NETINFO_FILE];
    if (!model) {
        NSString *hostAddr = [CXNetworkTool hostIpAddress];
        model = [[CXNetworkInfoModel alloc] initWithIP:hostAddr
                                               recPort:CX_SERVER_REC_PORT
                                              sendPort:0];
        [NSKeyedArchiver archiveRootObject:model toFile:CX_ARCHIEVED_NETINFO_FILE];
    }
    [self loadViews:model];
    //TODO: 网络连接准备
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - private methods
- (void)loadViews: (CXNetworkInfoModel *)data {
    self.iPAddressLabel.stringValue = data.ipAddress;
    self.receivePortLabel.stringValue = [NSString stringWithFormat:@"receive port: %d", data.recPort];
    self.sendPortLabel.stringValue = [NSString stringWithFormat:@"send port: %d", data.sendPort];

}

@end

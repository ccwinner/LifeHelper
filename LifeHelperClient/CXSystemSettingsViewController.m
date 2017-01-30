//
//  CXSystemSettingsViewController.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/9.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXSystemSettingsViewController.h"
#import "CXDataManager.h"
#import "CXNetworkEventModel.h"
#import "CXNetworkManager.h"

@interface CXSystemSettingsViewController ()

@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;

@property (weak, nonatomic) IBOutlet UISlider *volumnSlider;
@property (weak, nonatomic) IBOutlet UIButton *testSendBrightness;

@end

@implementation CXSystemSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //TODO: 先检查本地有没有设置值，有就更新UI; 否则，接收来自mac的系统设置默认值，更新UI
    //TODO: 目前与mac端的通信需要手动开启
    //test
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
    CXNetworkManagerInstance().sendAddress = @"192.168.1.102";
    [CX_DataManager prepareForNetworkConnection];
    [CX_DataManager connectToHost];
}

-(void)viewWillDisappear:(BOOL)animated {
    if ([self isMovingFromParentViewController]) {
        [CX_DataManager storeData];
    }
}
#pragma mark - UI
- (IBAction)brightnessSliderDidSlide:(UISlider *)sender {
    float value = sender.value;
    if (flessthan(value, 0) || flargerthan(value, 1)) {
        return;
    }
    id model = [[CXNetworkEventModel alloc] initWithEventType:CXNetworkEventTypeSettingsBrightness eventDesc:@"brightness" eventContent:@{kNetworkEventBrightnessKeyNew: @(value), kNetworkEventBrightnessKeyOld : @(0)}];
    [CX_DataManager sendModel:model];

}
- (IBAction)volumnSliderDidSlide:(UISlider *)sender {
    
}
- (IBAction)doSentBrightnessTest:(UIButton *)sender {

}

#pragma mark - private methods
- (void)loadSettings {


}

@end

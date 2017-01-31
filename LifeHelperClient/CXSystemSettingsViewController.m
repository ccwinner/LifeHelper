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
@property (weak, nonatomic) IBOutlet UILabel *selfIPAddrView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selfIPAddrViewWidthCons;
@property (weak, nonatomic) IBOutlet UITextField *hostIPAddrInputView;

@end

@implementation CXSystemSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //TODO: 先检查本地有没有设置值，有就更新UI; 否则，接收来自mac的系统设置默认值，更新UI
    //TODO: 目前与mac端的通信需要手动开启
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupUI];
}

-(void)viewWillDisappear:(BOOL)animated {
//    if ([self isMovingFromParentViewController]) {
//        [CX_DataManager storeData];
//    }
}
#pragma mark - UI
- (IBAction)brightnessSliderDidSlide:(UISlider *)sender {
    float value = sender.value;
    if (flessthan(value, 0.) || flargerthan(value, 1.0)) {
        return;
    }
    id model = [[CXNetworkEventModel alloc] initWithEventType:CXNetworkEventTypeSettingsBrightness
                                                    eventDesc:@"brightness"
                                                 eventContent:@{
                                                                kNetworkEventBrightnessKeyNew: @(value),
                                                                kNetworkEventBrightnessKeyOld : @(0)}];
    [CX_DataManager sendModel:model];

}

- (IBAction)volumnSliderDidSlide:(UISlider *)sender {
    float value = sender.value;
    if (flessthan(value, 0.) || flargerthan(value, 1.0)) {
        return;
    }
    id model = [[CXNetworkEventModel alloc] initWithEventType:CXNetworkEventTypeSettingsVolum
                                                    eventDesc:@"volumn"
                                                 eventContent:@{
                                                                kNetworkEventVolumnKeyNew: @(value),
                                                                kNetworkEventVolumnKeyOld : @(0)}];
    [CX_DataManager sendModel:model];
}

- (IBAction)confirmBtnDidClicked:(UIButton *)sender {
    NSString *hostIPAddr = self.hostIPAddrInputView.text;
    if (hostIPAddr.length > 0) {
        CXNetworkManagerInstance().sendAddress = hostIPAddr;
        [CX_DataManager prepareForNetworkConnection];
        [CX_DataManager connectToHost];
        sender.enabled = NO;
    }
}

#pragma mark - private methods
- (void)setupUI {
    NSString *oiginText = self.selfIPAddrView.text;
    NSString *resText = [oiginText stringByAppendingString:[CX_DataManager ipAddress]];
    self.selfIPAddrView.text = resText;
    self.selfIPAddrViewWidthCons.constant = [resText boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size.width;
    [self.selfIPAddrView updateConstraintsIfNeeded];
}

@end

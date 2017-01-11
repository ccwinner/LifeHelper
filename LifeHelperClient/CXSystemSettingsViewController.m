//
//  CXSystemSettingsViewController.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/9.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXSystemSettingsViewController.h"

@interface CXSystemSettingsViewController ()

@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;

@property (weak, nonatomic) IBOutlet UISlider *volumnSlider;

@end

@implementation CXSystemSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //TODO: 先检查本地有没有设置值，有就更新UI; 否则，接收来自mac的系统设置默认值，更新UI
}

#pragma mark - UI
- (IBAction)brightnessSliderDidSlide:(UISlider *)sender {

}
- (IBAction)volumnSliderDidSlide:(UISlider *)sender {
    
}

#pragma mark - private methods
- (void)loadSettings {
    
}

@end

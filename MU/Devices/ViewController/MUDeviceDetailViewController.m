//
//  MUDeviceDetailViewController.m
//  MU
//
//  Created by liang jiajian on 2018/3/27.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUDeviceDetailViewController.h"

@interface MUDeviceDetailViewController ()
@property (strong, nonatomic) MUDeviceItem *deviceItem;
@property (strong, nonatomic) UIButton *switchButton;

@end

@implementation MUDeviceDetailViewController

- (instancetype)initWithDeviceItem:(MUDeviceItem *)deviceItem {
    self = [super init];
    if(self){
        self.deviceItem = deviceItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.deviceItem.name;
    UIButton *rightButton = [[UIButton alloc] init];
    [rightButton setImage:[UIImage imageNamed:@"icon_more_option"] forState:UIControlStateNormal];
    [self setNaviBarRightBtn:rightButton];
    self.view.backgroundColor = [UIColor colorWithRGB:0x455769];
    [self setupViews];
}

- (void)setupViews {
    self.switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if(self.deviceItem.status == MUDeviceItemStatus_On){
        [self.switchButton setImage:[UIImage imageNamed:@"icon_switch_on"] forState:UIControlStateNormal];
    }else{
        [self.switchButton setImage:[UIImage imageNamed:@"icon_switch_off"] forState:UIControlStateNormal];
    }
    [self.switchButton addTarget:self action:@selector(handleSwitchClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.switchButton];
    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)handleSwitchClicked:(UIButton *)button {
    if(self.deviceItem.status == MUDeviceItemStatus_On){
        self.deviceItem.status = MUDeviceItemStatus_Off;
        [self.switchButton setImage:[UIImage imageNamed:@"icon_switch_off"] forState:UIControlStateNormal];
    }else{
        self.deviceItem.status = MUDeviceItemStatus_On;
        [self.switchButton setImage:[UIImage imageNamed:@"icon_switch_on"] forState:UIControlStateNormal];
    }
}

- (void)handleNavigationRightClicked:(UIButton *)sender {

}

@end

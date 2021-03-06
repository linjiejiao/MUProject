//
//  MUDeviceDetailViewController.m
//  MU
//
//  Created by liang jiajian on 2018/3/27.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUDeviceDetailViewController.h"
#import "MUOperationLogViewController.h"
#import "MUDeviceOperationManager.h"
#import "MUTimerViewController.h"
#import "MUAddLoopOperationViewController.h"
#import "MUConfigDeviceViewController.h"

@interface MUDeviceDetailViewController ()
@property (strong, nonatomic) MUDeviceItem *deviceItem;
@property (strong, nonatomic) UIButton *switchButton;
@property (strong, nonatomic) UIButton *operationLogButton;
@property (strong, nonatomic) UIButton *timerButton;
@property (strong, nonatomic) UIButton *loopButton;

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

    self.operationLogButton = [self createBotttomButtonWithTitle:NSLocalizedStringWithKey(@"device_detail_operation_log") imageName:@"btn_record"];
    [self.operationLogButton addTarget:self action:@selector(handleOperationLogClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.operationLogButton];
    [self.operationLogButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.size.mas_equalTo(self.operationLogButton.frame.size);
    }];

    self.timerButton = [self createBotttomButtonWithTitle:NSLocalizedStringWithKey(@"device_detail_timer") imageName:@"btn_clock"];
    [self.timerButton addTarget:self action:@selector(handleTimerClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timerButton];
    [self.timerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.size.mas_equalTo(self.timerButton.frame.size);
    }];

    self.loopButton = [self createBotttomButtonWithTitle:NSLocalizedStringWithKey(@"device_detail_loop") imageName:@"btn_repeat"];
    [self.loopButton addTarget:self action:@selector(handleLoopClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loopButton];
    [self.loopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.size.mas_equalTo(self.loopButton.frame.size);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.title = self.deviceItem.name;
}

- (UIButton *)createBotttomButtonWithTitle:(NSString *)title imageName:(NSString *)imageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button sizeToFit];
    CGFloat imageW = button.imageView.frame.size.width;
    CGFloat imageH = button.imageView.frame.size.height;
    CGFloat titleW = button.titleLabel.frame.size.width;
    CGFloat titleH = button.titleLabel.frame.size.height;
    //图片上文字下
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageW, -imageH - 10, 0.f)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(-titleH, 0.f, 0.f, -titleW)];
    button.frame = CGRectMake(0, 0, MAX(titleW, imageW) + 10, imageH + titleH + 10);
    return button;
}

- (void)handleSwitchClicked:(UIButton *)button {
    MUDeviceAction action = MUDeviceAction_On;
    if(self.deviceItem.status == MUDeviceItemStatus_On){
        action = MUDeviceAction_Off;
        self.deviceItem.status = MUDeviceItemStatus_Off;
        [self.switchButton setImage:[UIImage imageNamed:@"icon_switch_off"] forState:UIControlStateNormal];
    }else{
        action = MUDeviceAction_On;
        self.deviceItem.status = MUDeviceItemStatus_On;
        [self.switchButton setImage:[UIImage imageNamed:@"icon_switch_on"] forState:UIControlStateNormal];
    }
    [[MUDeviceOperationManager sharedInstance] doOperateDevice:self.deviceItem actionType:action time:[[NSDate date] timeIntervalSince1970] trigger:MUDeviceOperationLogTrigger_App];
}

- (void)handleNavigationRightClicked:(UIButton *)sender {
    MUConfigDeviceViewController *vc = [[MUConfigDeviceViewController alloc] initWithDeviceItem:self.deviceItem];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleOperationLogClicked:(UIButton *)button {
    MUOperationLogViewController *vc = [[MUOperationLogViewController alloc] initWithDeviceItem:self.deviceItem];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleTimerClicked:(UIButton *)button {
    MUTimerViewController *vc = [[MUTimerViewController alloc] initWithDeviceItem:self.deviceItem];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleLoopClicked:(UIButton *)button {
    MUAddLoopOperationViewController *vc = [[MUAddLoopOperationViewController alloc] initWithDeviceItem:self.deviceItem];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

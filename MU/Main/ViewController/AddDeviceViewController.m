//
//  AddDeviceViewController.m
//  MU
//
//  Created by liang jiajian on 2018/2/26.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "AddDeviceViewController.h"
#import "MUStepIndecatorView.h"
#import "MUAddDeviceStep1View.h"
#import "MUAddDeviceStep2View.h"

@interface AddDeviceViewController ()
@property (strong, nonatomic) MUStepIndecatorView *stepIndecatorView;
@property (strong, nonatomic) MUAddDeviceStep1View *step1View;
@property (strong, nonatomic) MUAddDeviceStep2View *step2View;
@property (strong, nonatomic) UIButton *bottomButton;

@end

@implementation AddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"add_device_title", nil);
    [self setupViews];
}

- (void)setupViews {
    self.stepIndecatorView = [[MUStepIndecatorView alloc] initWithStepCount:4];
    [self.view addSubview:self.stepIndecatorView];
    [self.stepIndecatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(25);
        make.size.mas_equalTo(self.stepIndecatorView.bounds.size);
    }];
    [self.stepIndecatorView heightlightStepIndecatorAtIndex:0];

    self.bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomButton.layer.masksToBounds = YES;
    self.bottomButton.layer.cornerRadius = 22;
    self.bottomButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.bottomButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:0x1b9dfc]] forState:UIControlStateNormal];
    [self.bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bottomButton setTitle:NSLocalizedString(@"button_next_step", nil) forState:UIControlStateNormal];
    [self.bottomButton addTarget:self action:@selector(handleBottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomButton];
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-70);
        make.leading.equalTo(self.view.mas_leading).offset(20);
        make.trailing.equalTo(self.view.mas_trailing).offset(-20);
        make.height.mas_equalTo(44);
    }];

    self.step1View = [[MUAddDeviceStep1View alloc] init];
    [self.view addSubview:self.step1View];
    [self.step1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.stepIndecatorView.mas_bottom);
        make.bottom.equalTo(self.bottomButton.mas_top).offset(-5);
    }];

    self.step2View = [[MUAddDeviceStep2View alloc] init];
    [self.view addSubview:self.step2View];
    [self.step2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.stepIndecatorView.mas_bottom);
        make.bottom.equalTo(self.bottomButton.mas_top).offset(-5);
    }];
    self.step2View.hidden = YES;
}

- (void)handleBottomButtonClicked:(UIButton *)button {
    [self.stepIndecatorView heightlightStepIndecatorAtIndex:1];
    self.step2View.hidden = NO;
    self.step1View.hidden = YES;
}

@end

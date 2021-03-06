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
#import "MUAddDeviceStep3View.h"
#import "MUAddDeviceStep4View.h"

#import "MUDeviceManager.h"

@interface AddDeviceViewController ()
@property (strong, nonatomic) MUStepIndecatorView *stepIndecatorView;
@property (strong, nonatomic) MUAddDeviceStep1View *step1View;
@property (strong, nonatomic) MUAddDeviceStep2View *step2View;
@property (strong, nonatomic) MUAddDeviceStep3View *step3View;
@property (strong, nonatomic) MUAddDeviceStep4View *step4View;
@property (strong, nonatomic) UIButton *bottomButton;
@property (assign, nonatomic) NSUInteger stepIndex;
@property (strong, nonatomic) UITapGestureRecognizer *backgroundTapGestureRecognizer;

@end

@implementation AddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedStringWithKey(@"add_device_title");
    self.stepIndex = 0;
    [self setupViews];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBackground:)];
    [self.view addGestureRecognizer:tap];
    self.backgroundTapGestureRecognizer = tap;
    [self enterStep:self.stepIndex];
}

- (void)setupViews {
    self.stepIndecatorView = [[MUStepIndecatorView alloc] initWithStepCount:4];
    [self.view addSubview:self.stepIndecatorView];
    [self.stepIndecatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(25);
        make.size.mas_equalTo(self.stepIndecatorView.bounds.size);
    }];

    self.bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomButton.layer.masksToBounds = YES;
    self.bottomButton.layer.cornerRadius = 22;
    self.bottomButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.bottomButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:0x1b9dfc]] forState:UIControlStateNormal];
    [self.bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bottomButton setTitle:NSLocalizedStringWithKey(@"button_next_step") forState:UIControlStateNormal];
    [self.bottomButton addTarget:self action:@selector(handleBottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomButton];
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-PortraitSafeBottomInset - 30);
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

    self.step3View = [[MUAddDeviceStep3View alloc] init];
    [self.view addSubview:self.step3View];
    [self.step3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.stepIndecatorView.mas_bottom);
        make.bottom.equalTo(self.bottomButton.mas_top).offset(-5);
    }];

    self.step4View = [[MUAddDeviceStep4View alloc] init];
    [self.view addSubview:self.step4View];
    [self.step4View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.stepIndecatorView.mas_bottom);
        make.bottom.equalTo(self.bottomButton.mas_top).offset(-5);
    }];
}

- (void)handleBottomButtonClicked:(UIButton *)button {
    self.stepIndex++;
    if(self.stepIndex > 3){
        MUDeviceItem *newDevice = [[MUDeviceItem alloc] init];
        newDevice.name = [self.step4View getDeviceName];
        if(newDevice.name.length <= 0){
            self.stepIndex --;
            [self showToast:NSLocalizedStringWithKey(@"add_device_name_empty")];
            return;
        }
        newDevice.type = self.step1View.selectedDeviceType;
        [[MUDeviceManager sharedInstance] addDevice:newDevice];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if(self.stepIndex == 2){
        if([self.step2View wifiSSID].length <= 0){
            self.stepIndex --;
            [self showToast:NSLocalizedStringWithKey(@"add_device_wifi_ssid_empty")];
            return;
        }
        if([self.step2View wifiPassword].length <= 0){
            self.stepIndex --;
            [self showToast:NSLocalizedStringWithKey(@"add_device_wifi_password_empty")];
            return;
        }
    }
    if(self.stepIndex == 3) {
        self.stepIndex = 1;
        [self enterStep:self.stepIndex];
        return;
    }
    [self enterStep:self.stepIndex];
}

- (void)handleTapBackground:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

- (void)enterStep:(NSUInteger)stepIndex {
    [self.stepIndecatorView heightlightStepIndecatorAtIndex:stepIndex];
    if(stepIndex == 0){
        self.backgroundTapGestureRecognizer.enabled = NO;
        self.step1View.hidden = NO;
        self.step2View.hidden = YES;
        self.step3View.hidden = YES;
        self.step4View.hidden = YES;
        [self.bottomButton setTitle:NSLocalizedStringWithKey(@"button_next_step") forState:UIControlStateNormal];
    }else if(stepIndex == 1){
        self.backgroundTapGestureRecognizer.enabled = YES;
        self.step1View.hidden = YES;
        self.step2View.hidden = NO;
        self.step3View.hidden = YES;
        self.step4View.hidden = YES;
        [self.bottomButton setTitle:NSLocalizedStringWithKey(@"button_next_step") forState:UIControlStateNormal];
    }else if(stepIndex == 2){
        self.backgroundTapGestureRecognizer.enabled = NO;
        self.step1View.hidden = YES;
        self.step2View.hidden = YES;
        self.step3View.hidden = NO;
        self.step4View.hidden = YES;
        [self.bottomButton setTitle:NSLocalizedStringWithKey(@"button_cancel") forState:UIControlStateNormal];
        // fake code
        [self.step3View setConnectingProgress:0.2];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(self.stepIndex != 2){
                return;
            }
            [self.step3View setConnectingProgress:0.4];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if(self.stepIndex != 2){
                    return;
                }
                [self.step3View setConnectingProgress:0.6];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if(self.stepIndex != 2){
                        return;
                    }
                    [self.step3View setConnectingProgress:0.8];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if(self.stepIndex != 2){
                            return;
                        }
                        [self.step3View setConnectingProgress:1.0];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self enterStep:++self.stepIndex];
                        });
                    });
                });
            });
        });
    }else if(stepIndex == 3){
        self.backgroundTapGestureRecognizer.enabled = YES;
        self.step1View.hidden = YES;
        self.step2View.hidden = YES;
        self.step3View.hidden = YES;
        self.step4View.hidden = NO;
        [self.bottomButton setTitle:NSLocalizedStringWithKey(@"button_finish") forState:UIControlStateNormal];
    }
}

@end

//
//  MURegisterViewController.m
//  MU
//
//  Created by liang jiajian on 2018/3/16.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MURegisterViewController.h"

#import "AppDelegate.h"
#import "MULoginModel.h"

#import "BottomLineTextField.h"
#import "MUCompanyLogoView.h"

@interface MURegisterViewController ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;
@property (assign, nonatomic) BOOL isKeybordShown;
@property (strong, nonatomic) BottomLineTextField *phoneNumber;
@property (strong, nonatomic) BottomLineTextField *pinCode;
@property (strong, nonatomic) BottomLineTextField *password;
@property (strong, nonatomic) BottomLineTextField *confirmPassword;

@end

@implementation MURegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.frame = [UIScreen mainScreen].bounds;
    gradientLayer.locations = @[@0, @1.f];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRGB:0x008afd].CGColor,
                             (__bridge id)[UIColor colorWithRGB:0x00bffe].CGColor];
    [self.view.layer addSublayer:gradientLayer];

    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.showsVerticalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.scrollView];
    self.contentView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.scrollView addSubview:self.contentView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapView:)];
    [self.contentView addGestureRecognizer:tap];

    MUCompanyLogoView *logoView = [[MUCompanyLogoView alloc] init];
    [self.contentView addSubview:logoView];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(95);
        make.size.mas_equalTo(logoView.size);
    }];

    UIButton *sendPinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendPinButton.titleLabel.font = [UIFont systemFontOfSize:12];
    sendPinButton.layer.cornerRadius = 2;
    sendPinButton.layer.borderColor = UIColor.whiteColor.CGColor;
    sendPinButton.layer.borderWidth = 1;
    [sendPinButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [sendPinButton setTitle:NSLocalizedStringWithKey(@"login_send_pin_code") forState:UIControlStateNormal];
    [sendPinButton addTarget:self action:@selector(sendPinCodeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [sendPinButton sizeToFit];
    [self.contentView addSubview:sendPinButton];
    [sendPinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoView.mas_bottom).offset(58);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(sendPinButton.frame) + 10, 21));
    }];

    BottomLineTextField *phoneNumber = [[BottomLineTextField alloc] init];
    phoneNumber.bottomLine.backgroundColor = [UIColor colorWithRGBA:0xffffff9f];
    phoneNumber.keyboardType = UIKeyboardTypePhonePad;
    phoneNumber.placeholder = NSLocalizedStringWithKey(@"login_phone_number_placeholder");
    [self.contentView addSubview:phoneNumber];
    [phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.right.equalTo(sendPinButton.mas_left).offset(-10);
        make.centerY.equalTo(sendPinButton.mas_centerY);
    }];
    self.phoneNumber = phoneNumber;

    BottomLineTextField *pinCode = [[BottomLineTextField alloc] init];
    pinCode.bottomLine.backgroundColor = [UIColor colorWithRGBA:0xffffff9f];
    pinCode.placeholder = NSLocalizedStringWithKey(@"login_pin_code_placeholder");
    [self.contentView addSubview:pinCode];
    [pinCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneNumber.mas_bottom).offset(30);
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
    }];
    self.pinCode = pinCode;

    BottomLineTextField *password = [[BottomLineTextField alloc] init];
    password.bottomLine.backgroundColor = [UIColor colorWithRGBA:0xffffff9f];
    password.secureTextEntry = YES;
    password.placeholder = NSLocalizedStringWithKey(@"login_password_placeholder");
    [self.contentView addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pinCode.mas_bottom).offset(30);
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
    }];
    self.password = password;

    BottomLineTextField *confirmPassword = [[BottomLineTextField alloc] init];
    confirmPassword.bottomLine.backgroundColor = [UIColor colorWithRGBA:0xffffff9f];
    confirmPassword.secureTextEntry = YES;
    confirmPassword.placeholder = NSLocalizedStringWithKey(@"login_password_confirm_placeholder");
    [self.contentView addSubview:confirmPassword];
    [confirmPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password.mas_bottom).offset(30);
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
    }];
    self.confirmPassword = confirmPassword;

    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.layer.masksToBounds = YES;
    registerButton.layer.cornerRadius = 22.5;
    registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [registerButton setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor colorWithRGB:0x008afd] forState:UIControlStateNormal];
    [registerButton setTitle:NSLocalizedStringWithKey(@"register_corfirm") forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmPassword.mas_bottom).offset(30);
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.height.mas_equalTo(45);
    }];

    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [loginButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [loginButton setTitle:NSLocalizedStringWithKey(@"register_goto_login") forState:UIControlStateNormal];
    [loginButton sizeToFit];
    CGFloat buttonWidth = loginButton.frame.size.width;
    [loginButton addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(registerButton.mas_bottom).offset(30);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(buttonWidth, 35));
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(loginButton.mas_bottom).offset(30);
        make.top.leading.equalTo(self.scrollView);
        make.width.mas_equalTo(ScreenWidth);
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.contentSize = self.contentView.size;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordAppear:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordDisappear:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - user actions
- (void)handleTapView:(UITapGestureRecognizer *)tap {
    if(self.isKeybordShown){
        [self.view endEditing:YES];
    }
}

- (void)loginClicked:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendPinCodeClicked:(UIButton *)button {
    if(self.phoneNumber.text.length != 11){
        [self showToast:NSLocalizedStringWithKey(@"login_phone_number_error")];
        return;
    }
    [self showToast:NSLocalizedStringWithKey(@"login_pin_code_sent")];
}

- (void)registerClicked:(UIButton *)button {
    NSString *number = self.phoneNumber.text;
    NSString *pinCode = self.pinCode.text;
    NSString *password = self.password.text;
    NSString *confirmPassword = self.confirmPassword.text;
    if(number.length != 11){
        [self showToast:NSLocalizedStringWithKey(@"login_phone_number_error")];
        return;
    }else if(![@"1234" isEqualToString:pinCode]){
        [self showToast:NSLocalizedStringWithKey(@"login_pin_code_error")];
        return;
    }else if(password.length < 8){
        [self showToast:NSLocalizedStringWithKey(@"login_password_too_short")];
        return;
    }else if(![password isEqualToString:confirmPassword]){
        [self showToast:NSLocalizedStringWithKey(@"login_password_different")];
        return;
    }
    [GlobalConfigModel setStringConfig:password forKey:kGlobalConfigModel_Password];

    [self showLoadingViewWithText:NSLocalizedStringWithKey(@"registering_tips")];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideLoadingView];
        [[AppDelegate instance] showMainViewController];
        [[MULoginModel sharedInstance] setIsEverLogin:YES];
    });
}

#pragma mark - Notifications
- (void)keybordAppear:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = CGRectGetHeight(keyboardRect);
    if(self.isKeybordShown){
        if(height > 0){
            CGRect frame = self.view.bounds;
            frame.size.height -= height;
            self.scrollView.frame = frame;
        }
        return;
    }
    self.isKeybordShown = YES;
    if(height > 0){
        // 动画
        CGRect frame = self.view.bounds;
        frame.size.height -= height;
        self.scrollView.frame = frame;
    }
}

- (void)keybordDisappear:(NSNotification *)notification {
    if(!self.isKeybordShown){
        self.scrollView.height = self.view.height;
        return;
    }
    [self.scrollView.layer removeAllAnimations];
    self.isKeybordShown = NO;
    self.scrollView.frame = self.view.bounds;
}

@end

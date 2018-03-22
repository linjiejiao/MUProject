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

@interface MURegisterViewController ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) BOOL isKeybordShown;

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
    self.scrollView.contentSize = [UIScreen mainScreen].bounds.size;
    if(IOS11_OR_LATER){
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapView:)];
    [self.scrollView addGestureRecognizer:tap];
    [self.view addSubview:self.scrollView];

    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 100)/2, 95, 100, 100)];
    logoImageView.layer.masksToBounds = YES;
    logoImageView.layer.cornerRadius = 20;
    logoImageView.image = [UIImage imageNamed:@"app_logo_large"];
    [self.scrollView addSubview:logoImageView];

    UILabel *companyName = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImageView.frame) + 20, ScreenWidth, 25)];
    companyName.textColor = UIColor.whiteColor;
    companyName.text = NSLocalizedString(@"company_name", nil);
    companyName.font = [UIFont systemFontOfSize:20];
    companyName.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:companyName];

    UILabel *companyNameEn = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(companyName.frame) + 10, ScreenWidth, 16)];
    companyNameEn.textColor = UIColor.whiteColor;
    companyNameEn.text = NSLocalizedString(@"company_name_en", nil);
    companyNameEn.font = [UIFont systemFontOfSize:12];
    companyNameEn.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:companyNameEn];

    UIButton *sendPinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendPinButton.titleLabel.font = [UIFont systemFontOfSize:12];
    sendPinButton.layer.cornerRadius = 2;
    sendPinButton.layer.borderColor = UIColor.whiteColor.CGColor;
    sendPinButton.layer.borderWidth = 1;
    [sendPinButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [sendPinButton setTitle:NSLocalizedString(@"login_send_pin_code", nil) forState:UIControlStateNormal];
    [sendPinButton addTarget:self action:@selector(sendPinCodeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [sendPinButton sizeToFit];
    CGFloat sendPinButtonWidth = CGRectGetWidth(sendPinButton.frame) + 10;
    sendPinButton.frame = CGRectMake(ScreenWidth - (sendPinButtonWidth + 30), CGRectGetMaxY(companyNameEn.frame) + 58, sendPinButtonWidth, 21);
    [self.scrollView addSubview:sendPinButton];

    UITextField *phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(companyNameEn.frame) + 60, ScreenWidth - 70 - sendPinButtonWidth, 21)];
    phoneNumber.placeholder = NSLocalizedString(@"login_phone_number_placeholder", nil);
    [self.scrollView addSubview:phoneNumber];

    UIView *inputBottomLine = [[UIView alloc] init];
    inputBottomLine.backgroundColor = [UIColor colorWithRGBA:0xffffff9f];
    [self.scrollView addSubview:inputBottomLine];
    [inputBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(phoneNumber.mas_leading);
        make.trailing.equalTo(sendPinButton.mas_trailing);
        make.top.equalTo(phoneNumber.mas_bottom);
        make.height.mas_equalTo(1);
    }];

    UITextField *pinCode = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(phoneNumber.frame) + 30, ScreenWidth - 60, 21)];
    pinCode.placeholder = NSLocalizedString(@"login_pin_code_placeholder", nil);
    [self.scrollView addSubview:pinCode];

    inputBottomLine = [[UIView alloc] init];
    inputBottomLine.backgroundColor = [UIColor colorWithRGBA:0xffffff9f];
    [self.scrollView addSubview:inputBottomLine];
    [inputBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(pinCode);
        make.top.equalTo(pinCode.mas_bottom);
        make.height.mas_equalTo(1);
    }];

    UITextField *password = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(pinCode.frame) + 30, ScreenWidth - 60, 21)];
    password.placeholder = NSLocalizedString(@"login_password_placeholder", nil);
    [self.scrollView addSubview:password];
    inputBottomLine = [[UIView alloc] init];
    inputBottomLine.backgroundColor = [UIColor colorWithRGBA:0xffffff9f];
    [self.scrollView addSubview:inputBottomLine];
    [inputBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(password);
        make.top.equalTo(password.mas_bottom);
        make.height.mas_equalTo(1);
    }];

    UITextField *confirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(password.frame) + 30, ScreenWidth - 60, 21)];
    confirmPassword.placeholder = NSLocalizedString(@"login_password_confirm_placeholder", nil);
    [self.scrollView addSubview:confirmPassword];
    inputBottomLine = [[UIView alloc] init];
    inputBottomLine.backgroundColor = [UIColor colorWithRGBA:0xffffff9f];
    [self.scrollView addSubview:inputBottomLine];
    [inputBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(confirmPassword);
        make.top.equalTo(confirmPassword.mas_bottom);
        make.height.mas_equalTo(1);
    }];

    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(30, CGRectGetMaxY(confirmPassword.frame) + 30, ScreenWidth - 60, 45);
    registerButton.layer.masksToBounds = YES;
    registerButton.layer.cornerRadius = 22.5;
    registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [registerButton setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor colorWithRGB:0x008afd] forState:UIControlStateNormal];
    [registerButton setTitle:NSLocalizedString(@"register_corfirm", nil) forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:registerButton];

    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [loginButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [loginButton setTitle:NSLocalizedString(@"register_goto_login", nil) forState:UIControlStateNormal];
    [loginButton sizeToFit];
    CGFloat buttonWidth = loginButton.frame.size.width;
    loginButton.frame = CGRectMake((ScreenWidth - buttonWidth)/2, CGRectGetMaxY(registerButton.frame) + 30, buttonWidth, 35);
    [loginButton addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:loginButton];
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

- (void)forgetPasswordClicked:(UIButton *)button {

}

- (void)sendPinCodeClicked:(UIButton *)button {

}

- (void)registerClicked:(UIButton *)button {
    [[AppDelegate instance] showMainViewController];
    [[MULoginModel sharedInstance] setIsEverLogin:YES];
}

#pragma mark - Notifications
- (void)keybordAppear:(NSNotification *)notification {
    if(self.isKeybordShown){
        return;
    }
    self.isKeybordShown = YES;
    NSDictionary* info = [notification userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = CGRectGetHeight(keyboardRect);
    NSTimeInterval animationDuration = [info[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve animationCurve = [info[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    if(height > 0){
        // 动画
        [self.scrollView.layer removeAllAnimations];
        [UIView beginAnimations:@"keyboard_show" context:nil];
        [UIView setAnimationCurve:animationCurve];
        [UIView setAnimationDuration:animationDuration];
        CGRect frame = self.view.bounds;
        frame.size.height -= height;
        self.scrollView.frame = frame;
        self.scrollView.contentOffset = CGPointMake(0, height);
        [UIView commitAnimations];
    }
}

- (void)keybordDisappear:(NSNotification *)notification {
    if(!self.isKeybordShown){
        self.scrollView.contentOffset = CGPointZero;
        self.scrollView.frame = self.view.bounds;
        return;
    }
    [self.scrollView.layer removeAllAnimations];
    self.isKeybordShown = NO;
    NSDictionary* info = [notification userInfo];
    NSTimeInterval animationDuration = [info[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve animationCurve = [info[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView beginAnimations:@"keyboard_hide" context:nil];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationDuration:animationDuration];
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentOffset = CGPointZero;
    [UIView commitAnimations];
}

@end

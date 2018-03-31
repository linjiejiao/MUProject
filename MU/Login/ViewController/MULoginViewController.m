//
//  MULoginViewController.m
//  MU
//
//  Created by liang jiajian on 2018/2/27.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MULoginViewController.h"
#import "MURegisterViewController.h"

#import "AppDelegate.h"
#import "MULoginModel.h"

#import "BottomLineTextField.h"
#import "MUCompanyLogoView.h"

@interface MULoginViewController ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;
@property (assign, nonatomic) BOOL isKeybordShown;

@end

@implementation MULoginViewController

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

    UIImageView *phoneIcon = [[UIImageView alloc] init];
    phoneIcon.image = [UIImage imageNamed:@"login_icon_name"];
    [self.contentView addSubview:phoneIcon];
    [phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.top.equalTo(logoView.mas_bottom).offset(60);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];

    BottomLineTextField *phoneNumber = [[BottomLineTextField alloc] init];
    phoneNumber.bottomLine.backgroundColor = [UIColor colorWithRGBA:0xffffff9f];
    phoneNumber.placeholder = NSLocalizedStringWithKey(@"login_phone_number_placeholder");
    [self.contentView addSubview:phoneNumber];
    [phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneIcon.mas_right).offset(5);
        make.centerY.equalTo(phoneIcon.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
    }];

    UIImageView *passwordIcon = [[UIImageView alloc] init];
    passwordIcon.image = [UIImage imageNamed:@"login_icon_key"];
    [self.contentView addSubview:passwordIcon];
    [passwordIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.top.equalTo(phoneNumber.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];

    BottomLineTextField *password = [[BottomLineTextField alloc] init];
    password.bottomLine.backgroundColor = [UIColor colorWithRGBA:0xffffff9f];
    password.placeholder = NSLocalizedStringWithKey(@"login_password_placeholder");
    [self.contentView addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordIcon.mas_right).offset(5);
        make.centerY.equalTo(passwordIcon.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
    }];

    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.cornerRadius = 22.5;
    loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [loginButton setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor colorWithRGB:0x008afd] forState:UIControlStateNormal];
    [loginButton setTitle:NSLocalizedStringWithKey(@"login_corfirm") forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.top.equalTo(password.mas_bottom).offset(30);
        make.height.mas_equalTo(45);
    }];

    UIButton *forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetPasswordButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [forgetPasswordButton setTitle:NSLocalizedStringWithKey(@"login_forget_password") forState:UIControlStateNormal];
    [forgetPasswordButton addTarget:self action:@selector(forgetPasswordClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:forgetPasswordButton];
    [forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom).offset(20);
        make.leading.equalTo(loginButton.mas_leading);
    }];

    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:12];
    registerButton.layer.cornerRadius = 2;
    registerButton.layer.borderColor = UIColor.whiteColor.CGColor;
    registerButton.layer.borderWidth = 1;
    [registerButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [registerButton setTitle:NSLocalizedStringWithKey(@"login_register_button") forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerClicked:) forControlEvents:UIControlEventTouchUpInside];
    [registerButton sizeToFit];
    [self.contentView addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom).offset(20);
        make.trailing.equalTo(loginButton.mas_trailing);
        make.width.mas_equalTo(registerButton.frame.size.width + 10);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(registerButton.mas_bottom).offset(30);
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

- (void)dealloc {

}

#pragma mark - user actions
- (void)handleTapView:(UITapGestureRecognizer *)tap {
    if(self.isKeybordShown){
        [self.view endEditing:YES];
    }
}

- (void)loginClicked:(UIButton *)button {
    [[AppDelegate instance] showMainViewController];
    [[MULoginModel sharedInstance] setIsEverLogin:YES];
}

- (void)forgetPasswordClicked:(UIButton *)button {
}

- (void)registerClicked:(UIButton *)button {
    MURegisterViewController *registerVC = [[MURegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
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

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

@interface MULoginViewController ()
@property (strong, nonatomic) UIScrollView *scrollView;
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

    UITextField *phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(companyNameEn.frame) + 60, ScreenWidth - 60, 21)];
    phoneNumber.placeholder = NSLocalizedString(@"login_phone_number_placeholder", nil);
    [self.scrollView addSubview:phoneNumber];

    UIView *inputBottomLine = [[UIView alloc] init];
    inputBottomLine.backgroundColor = [UIColor colorWithRGBA:0xffffff9f];
    [self.scrollView addSubview:inputBottomLine];
    [inputBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(phoneNumber);
        make.top.equalTo(phoneNumber.mas_bottom);
        make.height.mas_equalTo(1);
    }];

    UITextField *password = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(phoneNumber.frame) + 30, ScreenWidth - 60, 21)];
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

    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(30, CGRectGetMaxY(password.frame) + 30, ScreenWidth - 60, 45);
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.cornerRadius = 22.5;
    loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [loginButton setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor colorWithRGB:0x008afd] forState:UIControlStateNormal];
    [loginButton setTitle:NSLocalizedString(@"login_corfirm", nil) forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:loginButton];

    UIButton *forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetPasswordButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [forgetPasswordButton setTitle:NSLocalizedString(@"login_forget_password", nil) forState:UIControlStateNormal];
    [forgetPasswordButton addTarget:self action:@selector(forgetPasswordClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:forgetPasswordButton];
    [forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom).offset(20);
        make.leading.equalTo(loginButton.mas_leading);
    }];

    UIButton *gegisterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    gegisterButton.titleLabel.font = [UIFont systemFontOfSize:12];
    gegisterButton.layer.cornerRadius = 2;
    gegisterButton.layer.borderColor = UIColor.whiteColor.CGColor;
    gegisterButton.layer.borderWidth = 1;
    [gegisterButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [gegisterButton setTitle:NSLocalizedString(@"login_register_button", nil) forState:UIControlStateNormal];
    [gegisterButton addTarget:self action:@selector(registerClicked:) forControlEvents:UIControlEventTouchUpInside];
    [gegisterButton sizeToFit];
    [self.scrollView addSubview:gegisterButton];
    [gegisterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom).offset(20);
        make.trailing.equalTo(loginButton.mas_trailing);
        make.width.mas_equalTo(gegisterButton.frame.size.width + 10);
    }];
    [self.scrollView layoutSubviews];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(gegisterButton.frame) + 10);
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

//
//  SettingsViewController.m
//  MU
//
//  Created by liang jiajian on 2018/2/26.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "MULoginModel.h"
#import "BaseWebViewController.h"
#import "MUFeedbackViewController.h"

typedef NS_ENUM(NSUInteger, SettingItemIndex) {
    SettingItemIndex_Feedback = 0,
    SettingItemIndex_ChangeNickName,
    SettingItemIndex_ChangePassword,
    SettingItemIndex_AboutUs
};

@interface SettingsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *topView = [[UIView alloc] init];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(160);
    }];
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.frame = CGRectMake(0, 0, ScreenWidth, 160);
    gradientLayer.locations = @[@0, @1.f];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRGB:0x00bcfb].CGColor,
                             (__bridge id)[UIColor colorWithRGB:0x008dfa].CGColor];
    [topView.layer addSublayer:gradientLayer];

    UIImageView *headerIcon = [[UIImageView alloc] init];
    headerIcon.image = [UIImage imageNamed:@"app_logo_small"];
    headerIcon.layer.masksToBounds = YES;
    headerIcon.layer.cornerRadius = 15;
    [topView addSubview:headerIcon];
    [headerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topView.mas_bottom).offset(-25);
        make.leading.equalTo(topView.mas_leading).offset(25);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];

    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = UIColor.whiteColor;
    nameLabel.text = NSLocalizedString(@"MU", nil);
    nameLabel.font = [UIFont systemFontOfSize:15];
    [topView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(headerIcon.mas_trailing).offset(20);
        make.bottom.equalTo(headerIcon.mas_centerY).offset(-7);
        make.trailing.equalTo(topView.mas_trailing).offset(-25);
    }];

    UILabel *phoneNumberLabel = [[UILabel alloc] init];
    phoneNumberLabel.textColor = UIColor.whiteColor;
    phoneNumberLabel.text = NSLocalizedString(@"13800000000", nil);
    phoneNumberLabel.font = [UIFont systemFontOfSize:15];
    [topView addSubview:phoneNumberLabel];
    [phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(headerIcon.mas_trailing).offset(20);
        make.top.equalTo(headerIcon.mas_centerY).offset(7);
        make.trailing.equalTo(topView.mas_trailing).offset(-25);
    }];

    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.layer.masksToBounds = YES;
    logoutButton.layer.cornerRadius = 22;
    logoutButton.layer.borderColor = [UIColor colorWithRGB:0xd6d6d6].CGColor;
    logoutButton.layer.borderWidth = 1;
    logoutButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [logoutButton setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor colorWithRGB:0x989898] forState:UIControlStateNormal];
    [logoutButton setTitle:NSLocalizedString(@"button_logout", nil) forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(handleLogoutClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).offset(20);
        make.trailing.equalTo(self.view.mas_trailing).offset(-20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.height.mas_equalTo(44);
    }];

    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(topView.mas_bottom);
        make.bottom.equalTo(logoutButton.mas_top).offset(-5);
    }];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.tabBarController.tabBar.size.height);
    self.tabBarController.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.navigationController.navigationBarHidden = NO;
}

// 用tabBarController的navigationController push新界面，否则底部tabBar会一直显示
- (UINavigationController *)navigationController {
    return self.tabBarController.navigationController;
}

- (void)handleLogoutClicked:(UIButton *)button {
    [[MULoginModel sharedInstance] setIsEverLogin:NO];
    [[AppDelegate instance] showLoginViewController];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    switch (indexPath.row){
        case SettingItemIndex_Feedback:
            cell.textLabel.text = NSLocalizedString(@"settings_feedback", nil);
            break;
        case SettingItemIndex_ChangeNickName:
            cell.textLabel.text = NSLocalizedString(@"settings_change_nickneme", nil);
            break;
        case SettingItemIndex_ChangePassword:
            cell.textLabel.text = NSLocalizedString(@"settings_change_password", nil);
            break;
        case SettingItemIndex_AboutUs:
            cell.textLabel.text = NSLocalizedString(@"settings_about_us", nil);
            break;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row){
        case SettingItemIndex_Feedback:{
            MUFeedbackViewController *feedbackViewController = [[MUFeedbackViewController alloc] init];
            [self.navigationController pushViewController:feedbackViewController animated:YES];
        }break;
        case SettingItemIndex_ChangeNickName:{
        }break;
        case SettingItemIndex_ChangePassword:{
        }break;
        case SettingItemIndex_AboutUs:{
            [BaseWebViewController showWithUrl:@"http://www.baidu.com" from:self];
        }break;
    }
}

@end

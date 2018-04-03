//
//  MUAboutUsViewController.m
//  MU
//
//  Created by liang jiajian on 2018/4/3.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUAboutUsViewController.h"
#import "MUCompanyLogoView.h"
#import "BaseWebViewController.h"

@interface MUAboutUsViewController ()

@end

@implementation MUAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedStringWithKey(@"settings_about_us");
    MUCompanyLogoView *logoView = [[MUCompanyLogoView alloc] init];
    logoView.companyName.textColor = [UIColor colorWithRGB:0xacacac];
    logoView.companyNameEn.textColor = [UIColor colorWithRGB:0xacacac];
    [self.view addSubview:logoView];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(40);
        make.size.mas_equalTo(logoView.size);
    }];
    UILabel *descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.text = NSLocalizedStringWithKey(@"settings_about_company");
    descriptionLabel.numberOfLines = 0;
    [self.view addSubview:descriptionLabel];
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).offset(30);
        make.trailing.equalTo(self.view.mas_trailing).offset(-30);
        make.top.equalTo(logoView.mas_bottom).offset(30);
    }];

    UIImageView *qrcodeView = [[UIImageView alloc] init];
    qrcodeView.image = [UIImage imageNamed:@"img_qrcode"];
    [self.view addSubview:qrcodeView];
    [qrcodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(descriptionLabel.mas_bottom).offset(10);
    }];

    UILabel *qrcodeLabel = [[UILabel alloc] init];
    qrcodeLabel.text = NSLocalizedStringWithKey(@"settings_about_us_qrcode");
    qrcodeLabel.numberOfLines = 0;
    [self.view addSubview:qrcodeLabel];
    [qrcodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(qrcodeView.mas_bottom).offset(5);
    }];

    UIButton *moreInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreInfoButton.layer.masksToBounds = YES;
    moreInfoButton.layer.cornerRadius = 22;
    moreInfoButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [moreInfoButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:0x1b9dfc]] forState:UIControlStateNormal];
    [moreInfoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [moreInfoButton setTitle:NSLocalizedStringWithKey(@"settings_about_us_know_more") forState:UIControlStateNormal];
    [moreInfoButton addTarget:self action:@selector(handleMoreInfoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moreInfoButton];
    [moreInfoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-PortraitSafeBottomInset - 30);
        make.leading.equalTo(self.view.mas_leading).offset(20);
        make.trailing.equalTo(self.view.mas_trailing).offset(-20);
        make.height.mas_equalTo(44);
    }];
}

- (void)handleMoreInfoButtonClicked:(UIButton *)senser {
    [BaseWebViewController showWithUrl:@"https://mp.weixin.qq.com/s/AnZldB9Zu2K4yuhQORmTng" from:self];
}

@end

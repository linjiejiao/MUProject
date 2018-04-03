//
//  MUCompanyLogoView.m
//  MU
//
//  Created by liang jiajian on 2018/3/28.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUCompanyLogoView.h"

@implementation MUCompanyLogoView

- (instancetype)init {
    self = [super init];
    if(self){
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.frame = CGRectMake(0, 0, 160, 160);
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.layer.masksToBounds = YES;
    logoImageView.layer.cornerRadius = 20;
    logoImageView.image = [UIImage imageNamed:@"app_logo_large"];
    [self addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];

    UILabel *companyName = [[UILabel alloc] init];
    companyName.textColor = UIColor.whiteColor;
    companyName.text = NSLocalizedStringWithKey(@"company_name");
    companyName.font = [UIFont systemFontOfSize:20];
    companyName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:companyName];
    [companyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.mas_bottom).offset(15);
        make.leading.trailing.equalTo(self);
    }];
    self.companyName = companyName;

    UILabel *companyNameEn = [[UILabel alloc] init];
    companyNameEn.textColor = UIColor.whiteColor;
    companyNameEn.text = NSLocalizedStringWithKey(@"company_name_en");
    companyNameEn.font = [UIFont systemFontOfSize:12];
    companyNameEn.textAlignment = NSTextAlignmentCenter;
    [self addSubview:companyNameEn];
    [companyNameEn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(companyName.mas_bottom).offset(5);
        make.leading.trailing.equalTo(self);
    }];
    self.companyNameEn = companyNameEn;
}

@end

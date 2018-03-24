//
//  MUAddDeviceStep2View.m
//  MU
//
//  Created by liangjiajian_mac on 2018/3/23.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUAddDeviceStep2View.h"

@interface MUAddDeviceStep2View ()
@property (strong, nonatomic) UITextField *ssidTextField;
@property (strong, nonatomic) UITextField *passwordTextField;

@end

@implementation MUAddDeviceStep2View

- (instancetype)init {
    self = [super init];
    if(self){
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor colorWithRGB:0x656565];
    titleLabel.text = NSLocalizedString(@"add_device_step2_title", nil);
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.centerX.equalTo(self.mas_centerX);
    }];
    UILabel *descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.font = [UIFont systemFontOfSize:12];
    descriptionLabel.textColor = [UIColor colorWithRGB:0x656565];
    descriptionLabel.numberOfLines = 2;
    descriptionLabel.text = NSLocalizedString(@"add_device_step2_description", nil);
    [self addSubview:descriptionLabel];
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self.mas_centerX);
    }];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"img_add_device_config_wifi"];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descriptionLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self.mas_centerX);
    }];
    UITextField *wifiSSID = [[UITextField alloc] init];
    wifiSSID.placeholder = NSLocalizedString(@"config_wifi_ssid_placeholder", nil);
    [self addSubview:wifiSSID];
    [wifiSSID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).offset(20);
        make.trailing.equalTo(self.mas_trailing).offset(-20);
        make.top.equalTo(imageView.mas_bottom).offset(15);
        make.height.mas_equalTo(21);
    }];
    self.ssidTextField = wifiSSID;

    UIView *inputBottomLine = [[UIView alloc] init];
    inputBottomLine.backgroundColor = [UIColor colorWithRGB:0x656565];
    [self addSubview:inputBottomLine];
    [inputBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(wifiSSID);
        make.top.equalTo(wifiSSID.mas_bottom);
        make.height.mas_equalTo(1);
    }];

    UITextField *wifiPassword = [[UITextField alloc] init];
    wifiPassword.placeholder = NSLocalizedString(@"config_wifi_password_placeholder", nil);
    [self addSubview:wifiPassword];
    [wifiPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).offset(20);
        make.trailing.equalTo(self.mas_trailing).offset(-20);
        make.top.equalTo(wifiSSID.mas_bottom).offset(30);
        make.height.mas_equalTo(21);
    }];
    self.passwordTextField = wifiPassword;

    inputBottomLine = [[UIView alloc] init];
    inputBottomLine.backgroundColor = [UIColor colorWithRGB:0x656565];
    [self addSubview:inputBottomLine];
    [inputBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(wifiPassword);
        make.top.equalTo(wifiPassword.mas_bottom);
        make.height.mas_equalTo(1);
    }];
}

- (NSString *)wifiSSID {
    return self.ssidTextField.text;
}

- (NSString *)wifiPassword {
    return self.passwordTextField.text;
}

@end

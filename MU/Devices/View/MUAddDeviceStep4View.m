//
//  MUAddDeviceStep4View.m
//  MU
//
//  Created by liangjiajian_mac on 2018/3/24.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUAddDeviceStep4View.h"

@interface MUAddDeviceStep4View ()
@property (strong, nonatomic) UITextField *deviceNameTextField;

@end

@implementation MUAddDeviceStep4View

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
    titleLabel.text = NSLocalizedString(@"add_device_step4_title", nil);
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"img_add_device_rename"];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(95);
        make.centerX.equalTo(self.mas_centerX);
    }];

    UITextField *deviceNameTextField = [[UITextField alloc] init];
    deviceNameTextField.textAlignment = NSTextAlignmentCenter;
    deviceNameTextField.placeholder = NSLocalizedString(@"rename_device_placeholder", nil);
    [self addSubview:deviceNameTextField];
    [deviceNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).offset(100);
        make.trailing.equalTo(self.mas_trailing).offset(-100);
        make.top.equalTo(imageView.mas_bottom).offset(20);
        make.height.mas_equalTo(21);
    }];
    self.deviceNameTextField = deviceNameTextField;

    UIView *inputBottomLine = [[UIView alloc] init];
    inputBottomLine.backgroundColor = [UIColor colorWithRGB:0x656565];
    [self addSubview:inputBottomLine];
    [inputBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(deviceNameTextField);
        make.top.equalTo(deviceNameTextField.mas_bottom);
        make.height.mas_equalTo(1);
    }];

}

- (NSString *)getDeviceName {
    return self.deviceNameTextField.text;
}

@end

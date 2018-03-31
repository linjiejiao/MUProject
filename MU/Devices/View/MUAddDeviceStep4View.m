//
//  MUAddDeviceStep4View.m
//  MU
//
//  Created by liangjiajian_mac on 2018/3/24.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUAddDeviceStep4View.h"
#import "BottomLineTextField.h"

@interface MUAddDeviceStep4View ()
@property (strong, nonatomic) BottomLineTextField *deviceNameTextField;

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
    titleLabel.text = NSLocalizedStringWithKey(@"add_device_step4_title");
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

    BottomLineTextField *deviceNameTextField = [[BottomLineTextField alloc] init];
    deviceNameTextField.textAlignment = NSTextAlignmentCenter;
    deviceNameTextField.placeholder = NSLocalizedStringWithKey(@"rename_device_placeholder");
    [self addSubview:deviceNameTextField];
    [deviceNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).offset(100);
        make.trailing.equalTo(self.mas_trailing).offset(-100);
        make.top.equalTo(imageView.mas_bottom).offset(20);
        make.height.mas_equalTo(21);
    }];
    self.deviceNameTextField = deviceNameTextField;
}

- (NSString *)getDeviceName {
    return self.deviceNameTextField.text;
}

@end

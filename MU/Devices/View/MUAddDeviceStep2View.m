//
//  MUAddDeviceStep2View.m
//  MU
//
//  Created by liangjiajian_mac on 2018/3/23.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUAddDeviceStep2View.h"

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
}

- (NSString *)wifiSSID {
    return nil;
}

- (NSString *)wifiPassword {
    return nil;
}

@end

//
//  MUAddDeviceStep3View.m
//  MU
//
//  Created by liangjiajian_mac on 2018/3/24.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUAddDeviceStep3View.h"

@interface MUAddDeviceStep3View ()
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) UILabel *progressTimeLabel;

@end

@implementation MUAddDeviceStep3View

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
    titleLabel.text = NSLocalizedStringWithKey(@"add_device_step3_title");
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"img_add_device_connecting"];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(30);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    UILabel *descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.font = [UIFont systemFontOfSize:16];
    descriptionLabel.textColor = [UIColor colorWithRGB:0x656565];
    descriptionLabel.numberOfLines = 2;
    descriptionLabel.text = NSLocalizedStringWithKey(@"add_device_step3_description");
    [self addSubview:descriptionLabel];
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(20);
        make.centerX.equalTo(self.mas_centerX);
    }];

    UILabel *progressTimeLabel = [[UILabel alloc] init];
    progressTimeLabel.font = [UIFont systemFontOfSize:16];
    progressTimeLabel.textColor = [UIColor colorWithRGB:0x656565];
    progressTimeLabel.numberOfLines = 2;
    progressTimeLabel.text = NSLocalizedStringWithKey(@"3min");
    [self addSubview:progressTimeLabel];
    [progressTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descriptionLabel.mas_bottom).offset(10);
        make.trailing.equalTo(self.mas_trailing).offset(-20);
    }];
    self.progressTimeLabel = progressTimeLabel;

    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.layer.masksToBounds = YES;
    progressView.layer.cornerRadius = 7.5;
    [self addSubview:progressView];
    progressView.progress = 0.5;
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(progressTimeLabel.mas_centerY);
        make.leading.equalTo(self.mas_leading).offset(35);
        make.trailing.equalTo(progressTimeLabel.mas_leading).offset(-10);
        make.height.mas_equalTo(15);
    }];
    self.progressView = progressView;

    UILabel *connectingLabel = [[UILabel alloc] init];
    connectingLabel.font = [UIFont systemFontOfSize:16];
    connectingLabel.textColor = [UIColor colorWithRGB:0x656565];
    connectingLabel.numberOfLines = 2;
    connectingLabel.text = NSLocalizedStringWithKey(@"add_device_step3_connecting");
    [self addSubview:connectingLabel];
    [connectingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(progressView.mas_bottom).offset(10);
        make.centerX.equalTo(self.mas_centerX);
    }];

}

- (void)setConnectingProgress:(CGFloat)progress {
    self.progressView.progress = progress;
}

- (void)setConnectingTime:(NSString *)time {
    self.progressTimeLabel.text = time;
}

@end

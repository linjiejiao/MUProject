//
//  MUDeviceCollectionViewCell.m
//  MU
//
//  Created by liang jiajian on 2018/3/21.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUDeviceCollectionViewCell.h"
#import "MUDeviceItem.h"

@interface MUDeviceCollectionViewCell ()
@property (strong, nonatomic) UIView *backgroundContaincer;
@property (strong, nonatomic) UIButton *switchButton;
@property (strong, nonatomic) UILabel *deviceNameLabel;
@property (strong, nonatomic) UIImageView *deviceTimerIcon;
@property (strong, nonatomic) UIImageView *deviceSignalIcon;
@property (strong, nonatomic) UIButton *deleteButton;

@end

@implementation MUDeviceCollectionViewCell

+ (CGSize)cellSize {
    return CGSizeMake(ScreenWidth, 125);
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (CGFloat)cellIntervalHorizontal {
    return 0;
}

+ (CGFloat)cellIntervalVertical {
    return 0;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundContaincer = [[UIView alloc] init];
    self.backgroundContaincer.backgroundColor = [UIColor colorWithRGB:0x455769];
    [self.contentView addSubview:self.backgroundContaincer];
    [self.backgroundContaincer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self.contentView).offset(10);
        make.trailing.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];

    self.switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.switchButton setImage:[UIImage imageNamed:@"icon_switch_off"] forState:UIControlStateNormal];
    [self.backgroundContaincer addSubview:self.switchButton];
    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundContaincer.mas_leading).offset(15);
        make.centerY.equalTo(self.backgroundContaincer.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(67, 67));
    }];
    [self.switchButton addTarget:self action:@selector(handleSwitchClicked:) forControlEvents:UIControlEventTouchUpInside];

    self.deviceNameLabel = [[UILabel alloc] init];
    [self.backgroundContaincer addSubview:self.deviceNameLabel];
    self.deviceNameLabel.font = [UIFont systemFontOfSize:18];
    self.deviceNameLabel.textColor = UIColor.whiteColor;
    [self.deviceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.switchButton.mas_trailing).offset(10);
        make.centerY.equalTo(self.backgroundContaincer.mas_centerY);
        make.trailing.lessThanOrEqualTo(self.backgroundContaincer.mas_trailing).offset(-40);
    }];

    self.deviceTimerIcon = [[UIImageView alloc] init];
    self.deviceTimerIcon.image = [UIImage imageNamed:@"icon_timer"];
    [self.backgroundContaincer addSubview:self.deviceTimerIcon];
    [self.deviceTimerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.deviceNameLabel.mas_trailing).offset(5);
        make.centerY.equalTo(self.backgroundContaincer.mas_centerY);
    }];

    self.deviceSignalIcon = [[UIImageView alloc] init];
    self.deviceSignalIcon.image = [UIImage imageNamed:@"icon_signal"];
    [self.backgroundContaincer addSubview:self.deviceSignalIcon];
    [self.deviceSignalIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundContaincer.mas_top).offset(10);
        make.trailing.equalTo(self.backgroundContaincer.mas_trailing).offset(-10);
    }];

    self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteButton setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
    [self.backgroundContaincer addSubview:self.deleteButton];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backgroundContaincer.mas_bottom).offset(-10);
        make.trailing.equalTo(self.backgroundContaincer.mas_trailing).offset(-10);
    }];
    [self.deleteButton addTarget:self action:@selector(handleDeleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setDeviceItem:(MUDeviceItem *)deviceItem {
    _deviceItem = deviceItem;
    self.deviceTimerIcon.hidden = !deviceItem.hasTimer;
    self.deviceNameLabel.text = deviceItem.name;
    if(deviceItem.status == MUDeviceItemStatus_On){
        [self.switchButton setImage:[UIImage imageNamed:@"icon_switch_on"] forState:UIControlStateNormal];
    }else{
        [self.switchButton setImage:[UIImage imageNamed:@"icon_switch_off"] forState:UIControlStateNormal];
    }
}

- (void)handleDeleteButtonClicked:(UIButton *)button {
    if(self.delegate && [self.delegate respondsToSelector:@selector(deviceCell:didClickDeleteButtonWithDeviceItem:)]){
        [self.delegate deviceCell:self didClickDeleteButtonWithDeviceItem:self.deviceItem];
    }
}

- (void)handleSwitchClicked:(UIButton *)button {
    if(self.delegate && [self.delegate respondsToSelector:@selector(deviceCell:didClickSwitchButtonWithDeviceItem:)]){
        [self.delegate deviceCell:self didClickSwitchButtonWithDeviceItem:self.deviceItem];
    }
}

@end

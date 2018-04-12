//
//  MUTimerTableViewCell.m
//  MU
//
//  Created by liangjiajian_mac on 2018/3/31.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUTimerTableViewCell.h"
#import "MUDeviceItem.h"

@interface MUTimerTableViewCell ()
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *repeatDays;
@property (strong, nonatomic) UIButton *statusButton;

@end

@implementation MUTimerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = UIColor.clearColor;
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor colorWithRGB:0xacacac];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.leading.equalTo(self.contentView.mas_leading).offset(20);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-20);
        make.height.mas_equalTo(1);
    }];

    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor colorWithRGB:0xacacac];
    timeLabel.font = [UIFont systemFontOfSize:23];
    timeLabel.text = @"12:34";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self.contentView).offset(15);
    }];
    self.timeLabel = timeLabel;

    UILabel *repeatDays = [[UILabel alloc] init];
    repeatDays.textColor = [UIColor colorWithRGB:0xacacac];
    repeatDays.font = [UIFont systemFontOfSize:14];
    repeatDays.text = @"每天";
    repeatDays.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:repeatDays];
    [repeatDays mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-13);
    }];
    self.repeatDays = repeatDays;
    UIButton *statusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [statusButton setImage:[UIImage imageNamed:@"icon_check_button_selected"] forState:UIControlStateNormal];
    [self.contentView addSubview:statusButton];
    [statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(59, 40));
    }];
    [statusButton addTarget:self action:@selector(handleStatusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.statusButton = statusButton;
}

- (void)setTimerItem:(MUDeviceTimerItem *)timerItem {
    _timerItem = timerItem;
    if(timerItem.repeatType == MUDeviceTimerItemRepeatType_OnlyOnce){
        self.repeatDays.text = NSLocalizedStringWithKey(@"device_timer_only_once");
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timerItem.onceDate];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
        self.timeLabel.text = [formater stringFromDate:date];
    }else{
        self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d", timerItem.minutesOfDay / 60, timerItem.minutesOfDay % 60];
        if(timerItem.weeklyDays.count >= 7){
            self.repeatDays.text = NSLocalizedStringWithKey(@"device_timer_everyday");
        }else{
            NSString *dayeString = @"";
            for(NSNumber *day in timerItem.weeklyDays){
                int dayInt = [day intValue];
                if(dayInt > 0 && dayInt < 8){
                    NSString *key = [NSString stringWithFormat:@"device_timer_day%d", dayInt];
                    NSString *string = NSLocalizedStringWithKey(key);
                    dayeString = [dayeString stringByAppendingFormat:@"%@ ", string];
                }
            }
            self.repeatDays.text = dayeString;
        }
    }
    if(timerItem.status == MUDeviceTimerItemStrtus_Enable){
        [self.statusButton setImage:[UIImage imageNamed:@"icon_check_button_selected"] forState:UIControlStateNormal];
    }else{
        [self.statusButton setImage:[UIImage imageNamed:@"icon_check_button_unselected"] forState:UIControlStateNormal];
    }
}

- (void)handleStatusButtonClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(timerCell:didClickedStatusButtonWithItem:)]) {
        [self.delegate timerCell:self didClickedStatusButtonWithItem:self.timerItem];
    }
}

@end

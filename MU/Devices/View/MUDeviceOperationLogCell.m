//
//  MUDeviceOperationLogCell.m
//  MU
//
//  Created by liangjiajian_mac on 2018/3/31.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUDeviceOperationLogCell.h"
#import "MUDeviceItem.h"

@interface MUDeviceOperationLogCell ()
@property (strong, nonatomic) UILabel *actionLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *triggerLabel;

@end

@implementation MUDeviceOperationLogCell

+ (CGSize)cellSize {
    return CGSizeMake(ScreenWidth, 45);
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
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor colorWithRGB:0xacacac];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    UILabel *actionLabel = [[UILabel alloc] init];
    actionLabel.textColor = [UIColor colorWithRGB:0xacacac];
    actionLabel.font = [UIFont systemFontOfSize:14];
    actionLabel.text = NSLocalizedStringWithKey(@"operation_log_action");
    actionLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:actionLabel];
    [actionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.top.equalTo(self.contentView);
        make.width.mas_equalTo(100);
    }];
    self.actionLabel = actionLabel;
    UIView *divider1 = [[UIView alloc] init];
    divider1.backgroundColor = [UIColor colorWithRGB:0xacacac];
    [self.contentView addSubview:divider1];
    [divider1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(1);
        make.leading.equalTo(actionLabel.mas_trailing);
    }];

    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor colorWithRGB:0xacacac];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.text = NSLocalizedStringWithKey(@"operation_log_time");
    timeLabel.numberOfLines = 2;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(actionLabel.mas_trailing);
        make.bottom.top.equalTo(self.contentView);
        make.width.mas_equalTo(100);
    }];
    self.timeLabel = timeLabel;
    UIView *divider2 = [[UIView alloc] init];
    divider2.backgroundColor = [UIColor colorWithRGB:0xacacac];
    [self.contentView addSubview:divider2];
    [divider2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(1);
        make.leading.equalTo(timeLabel.mas_trailing);
    }];

    UILabel *triggerLabel = [[UILabel alloc] init];
    triggerLabel.textColor = [UIColor colorWithRGB:0xacacac];
    triggerLabel.font = [UIFont systemFontOfSize:14];
    triggerLabel.text = NSLocalizedStringWithKey(@"operation_log_trigger");
    triggerLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:triggerLabel];
    [triggerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(timeLabel.mas_trailing);
        make.bottom.top.trailing.equalTo(self.contentView);
    }];
    self.triggerLabel = triggerLabel;
}

- (void)setOperationLog:(MUDeviceOperationLog *)operationLog {
    if (!operationLog) {
        return;
    }
    _operationLog = operationLog;
    NSString *actionText = nil;
    if(operationLog.logActionType == MUDeviceOperationLogAction_On){
        actionText = NSLocalizedStringWithKey(@"operation_log_action_on");
    }else{
        actionText = NSLocalizedStringWithKey(@"operation_log_action_off");
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:operationLog.logTime];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.timeLabel.text = [formater stringFromDate:date];
    self.actionLabel.text = actionText;
    NSString *triggerText = nil;
    if(operationLog.triggerType == MUDeviceOperationLogTrigger_App){
        triggerText = NSLocalizedStringWithKey(@"operation_log_trigger_app");
    }else{
        triggerText = NSLocalizedStringWithKey(@"operation_log_trigger_device");
    }
    self.triggerLabel.text = triggerText;
}

@end

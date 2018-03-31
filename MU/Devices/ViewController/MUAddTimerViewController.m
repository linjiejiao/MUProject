//
//  MUAddTimerViewController.m
//  MU
//
//  Created by liangjiajian_mac on 2018/3/31.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUAddTimerViewController.h"

#define HeightlightBackgroundColor  [UIColor colorWithRGB:0x1990fb]
#define HeightlightTextColor        [UIColor whiteColor]
#define NormalBackgroundColor       [UIColor colorWithRGB:0xd8d8d8]
#define NormalTextColor             [UIColor whiteColor]

@interface MUAddTimerViewController ()
@property (strong, nonatomic) MUDeviceItem *deviceItem;
@property (strong, nonatomic) UIButton *radioButtonExecuteOnce;
@property (strong, nonatomic) UIButton *radioButtonExecuteWeekly;
@property (strong, nonatomic) UIView *weekdaysSelectorView;
@property (strong, nonatomic) NSArray<UILabel *> *weekdaysView;
@property (strong, nonatomic) UIDatePicker *timePickerView;
@property (strong, nonatomic) UIButton *radioButtonTurnOn;
@property (strong, nonatomic) UIButton *radioButtonTurnOff;

@end

@implementation MUAddTimerViewController

- (instancetype)initWithDeviceItem:(MUDeviceItem *)deviceItem {
    self = [super init];
    if(self){
        self.deviceItem = deviceItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedStringWithKey(@"device_detail_timer");
    [self setupViews];
}

- (void)setupViews {
    self.radioButtonExecuteOnce = [self createRadioButtonWithTitile:NSLocalizedStringWithKey(@"device_timer_execute_once")];
    [self.view addSubview:self.radioButtonExecuteOnce];
    [self.radioButtonExecuteOnce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).offset(60);
        make.top.equalTo(self.view.mas_top).offset(45);
        make.size.mas_equalTo(self.radioButtonExecuteOnce.frame.size);
    }];
    [self.radioButtonExecuteOnce addTarget:self action:@selector(handlExecuteOnceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.radioButtonExecuteOnce.selected = YES;

    self.radioButtonExecuteWeekly = [self createRadioButtonWithTitile:NSLocalizedStringWithKey(@"device_timer_execute_weekly")];
    [self.view addSubview:self.radioButtonExecuteWeekly];
    [self.radioButtonExecuteWeekly mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view.mas_trailing).offset(-60);
        make.centerY.equalTo(self.radioButtonExecuteOnce.mas_centerY);
        make.size.mas_equalTo(self.radioButtonExecuteWeekly.frame.size);
    }];
    [self.radioButtonExecuteWeekly addTarget:self action:@selector(handlExecuteWeeklyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.radioButtonExecuteWeekly.selected = NO;

    self.weekdaysSelectorView = [self setupWeekdaysSelector];
    self.weekdaysSelectorView.hidden = YES;

    // 选择时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = NSLocalizedStringWithKey(@"device_timer_select_time");
    timeLabel.textColor = [UIColor colorWithRGB:0x666666];
    timeLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weekdaysSelectorView.mas_bottom).offset(35);
        make.centerX.equalTo(self.view.mas_centerX);
    }];

    UIDatePicker *timePickerView = [[UIDatePicker alloc] init];
    timePickerView.datePickerMode = UIDatePickerModeDateAndTime;
    [timePickerView setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans"]];
    timePickerView.backgroundColor = [UIColor colorWithRGB:0xe5f5fe];
    timePickerView.minimumDate = [NSDate date];
    [self.view addSubview:timePickerView];
    [timePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeLabel.mas_bottom).offset(15);
        make.leading.equalTo(self.view.mas_leading).offset(40);
        make.trailing.equalTo(self.view.mas_trailing).offset(-40);
        make.height.mas_equalTo(150);
    }];
    self.timePickerView = timePickerView;

    // 执行的动作
    UIView *actionContainer = [[UIView alloc] init];
    [self.view addSubview:actionContainer];
    UILabel *actionLabel = [[UILabel alloc] init];
    actionLabel.text = NSLocalizedStringWithKey(@"device_timer_execute");
    actionLabel.textColor = [UIColor colorWithRGB:0x666666];
    actionLabel.font = [UIFont systemFontOfSize:16];
    [actionContainer addSubview:actionLabel];
    [actionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(actionContainer.mas_leading);
        make.centerY.equalTo(actionContainer.mas_centerY);
    }];
    // 打开
    self.radioButtonTurnOn = [self createRadioButtonWithTitile:NSLocalizedStringWithKey(@"device_timer_execute_on")];
    [actionContainer addSubview:self.radioButtonTurnOn];
    [self.radioButtonTurnOn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(actionLabel.mas_trailing).offset(15);
        make.centerY.equalTo(actionContainer.mas_centerY);
        make.size.mas_equalTo(self.radioButtonTurnOn.frame.size);
    }];
    [self.radioButtonTurnOn addTarget:self action:@selector(handlExecuteTurnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.radioButtonTurnOn.selected = YES;
    // 关闭
    self.radioButtonTurnOff = [self createRadioButtonWithTitile:NSLocalizedStringWithKey(@"device_timer_execute_on")];
    [actionContainer addSubview:self.radioButtonTurnOff];
    [self.radioButtonTurnOff mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.radioButtonTurnOn.mas_trailing).offset(30);
        make.centerY.equalTo(actionContainer.mas_centerY);
        make.size.mas_equalTo(self.radioButtonTurnOff.frame.size);
    }];
    [self.radioButtonTurnOff addTarget:self action:@selector(handlExecuteTurnOffButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.radioButtonTurnOff.selected = NO;

    [actionContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timePickerView.mas_bottom).offset(80);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(44);
        make.trailing.equalTo(self.radioButtonTurnOff.mas_trailing);
    }];

    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomButton.layer.masksToBounds = YES;
    bottomButton.layer.cornerRadius = 22;
    bottomButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [bottomButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:0x1b9dfc]] forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomButton setTitle:NSLocalizedStringWithKey(@"button_finish") forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(handleFinishButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-PortraitSafeBottomInset - 30);
        make.leading.equalTo(self.view.mas_leading).offset(20);
        make.trailing.equalTo(self.view.mas_trailing).offset(-20);
        make.height.mas_equalTo(44);
    }];
}

- (UIButton *)createRadioButtonWithTitile:(NSString *)title {
    UIButton *radioButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [radioButton setTitle:title forState:UIControlStateNormal];
    [radioButton setTitleColor:[UIColor colorWithRGB:0x666666] forState:UIControlStateNormal];
    [radioButton setImage:[UIImage imageNamed:@"icon_radio_normal"] forState:UIControlStateNormal];
    [radioButton setImage:[UIImage imageNamed:@"icon_radio_selected"] forState:UIControlStateSelected];
    radioButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    [radioButton sizeToFit];
    CGRect frame = radioButton.frame;
    frame.size.width += 15;
    radioButton.frame = frame;
    return radioButton;
}

- (UIView *)setupWeekdaysSelector {
    UIView *weekdaysSelectorView = [[UIView alloc] init];
    [self.view addSubview:weekdaysSelectorView];
    UILabel *weekDays = [[UILabel alloc] init];
    weekDays.text = NSLocalizedStringWithKey(@"device_timer_select_week");
    weekDays.textColor = [UIColor colorWithRGB:0x666666];
    [weekdaysSelectorView addSubview:weekDays];
    [weekDays mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weekdaysSelectorView.mas_leading);
        make.centerY.equalTo(weekdaysSelectorView.mas_centerY);
    }];
    NSArray<NSString *> *weekNumber = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
    NSMutableArray<UILabel *> *array = [[NSMutableArray alloc] initWithCapacity:7];
    UIView *previousView = weekDays;
    for(int i=0; i<7; i++){
        UILabel *view = [[UILabel alloc] init];
        view.text = weekNumber[i];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 12;
        view.textAlignment = NSTextAlignmentCenter;
        view.font = [UIFont systemFontOfSize:12];
        view.backgroundColor = NormalBackgroundColor;
        view.textColor = NormalTextColor;
        [weekdaysSelectorView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weekdaysSelectorView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(24, 24));
            make.leading.equalTo(previousView.mas_trailing).offset(9);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleWeekSelectorClicked:)];
        [view addGestureRecognizer:tap];
        view.userInteractionEnabled = YES;
        view.tag = 0;
        previousView = view;
        [array addObject:view];
    }
    self.weekdaysView = array;
    [weekdaysSelectorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.radioButtonExecuteOnce.mas_bottom).offset(30);
        make.height.mas_equalTo(24);
        make.trailing.equalTo(previousView.mas_trailing);
    }];
    return weekdaysSelectorView;
}

- (void)handleWeekSelectorClicked:(UITapGestureRecognizer *)tap {
    UILabel *view = (UILabel *)tap.view;
    if(view.tag == 0){
        view.tag = 1;
        view.backgroundColor = HeightlightBackgroundColor;
        view.textColor = HeightlightTextColor;
    }else{
        view.tag = 0;
        view.backgroundColor = NormalBackgroundColor;
        view.textColor = NormalTextColor;
    }
}

#pragma mark - user interaction
// 循环模式单选框
- (void)handlExecuteOnceButtonClicked:(UIButton *)button {
    self.radioButtonExecuteOnce.selected = YES;
    self.radioButtonExecuteWeekly.selected = NO;
    self.timePickerView.datePickerMode = UIDatePickerModeDateAndTime;
    self.weekdaysSelectorView.hidden = YES;
}

- (void)handlExecuteWeeklyButtonClicked:(UIButton *)button {
    self.radioButtonExecuteOnce.selected = NO;
    self.radioButtonExecuteWeekly.selected = YES;
    self.timePickerView.datePickerMode = UIDatePickerModeTime;
    self.weekdaysSelectorView.hidden = NO;
}

// 执行单选框
- (void)handlExecuteTurnOnClicked:(UIButton *)button {
    self.radioButtonTurnOn.selected = YES;
    self.radioButtonTurnOff.selected = NO;
}

- (void)handlExecuteTurnOffButtonClicked:(UIButton *)button {
    self.radioButtonTurnOn.selected = NO;
    self.radioButtonTurnOff.selected = YES;
}

- (void)handleFinishButtonClicked:(UIButton *)sender {
    MUDeviceTimerItem *timer = [[MUDeviceTimerItem alloc] init];
    timer.status = MUDeviceTimerItemStatus_On;
    timer.action = self.radioButtonTurnOn.selected ? MUDeviceTimerItemStatus_On:MUDeviceTimerItemStatus_Off;
    NSDate *selectedDate = self.timePickerView.date;
    if(self.radioButtonExecuteOnce.selected){
        timer.repeatType = MUDeviceTimerItemRepeatType_OnlyOnce;
        if(selectedDate != [selectedDate laterDate:[NSDate date]]){
            [self showToast:NSLocalizedStringWithKey(@"device_timer_date_passed_tips")];
            return;
        }
        timer.onceDate = [selectedDate timeIntervalSince1970];
    }else{
        timer.repeatType = MUDeviceTimerItemRepeatType_Weekly;
        NSMutableArray<NSNumber *> *weekdays = [[NSMutableArray alloc] init];
        for(int i=0; i<7; i++){
            UILabel *view = self.weekdaysView[i];
            if(view.tag == 1){
                [weekdays addObject:@(i + 1)];
            }
        }
        if(weekdays.count <= 0){
            [self showToast:NSLocalizedStringWithKey(@"device_timer_weekly_none_tips")];
            return;
        }
        timer.weeklyDays = weekdays;
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd"];
        NSString *string = [formater stringFromDate:selectedDate];
        NSDate *zeroDate = [formater dateFromString:string]; //当天凌晨0点
        timer.minutesOfDay = [selectedDate timeIntervalSinceDate:zeroDate]/60;
    }
    NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:self.deviceItem.timerItems.count + 1];
    [temp addObjectsFromArray:self.deviceItem.timerItems];
    [temp addObject:timer];
    self.deviceItem.timerItems = temp;
    [self.navigationController popViewControllerAnimated:YES];
}

@end

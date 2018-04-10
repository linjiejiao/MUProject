//
//  MUAddLoopOperationViewController.m
//  MU
//
//  Created by liangjiajian_mac on 2018/3/31.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUAddLoopOperationViewController.h"
#import "MULoopDurationPickerView.h"

@interface MUAddLoopOperationViewController ()
@property (strong, nonatomic) MUDeviceItem *deviceItem;
@property (strong, nonatomic) MULoopDurationPickerView *loopIntervalPickerView;
@property (strong, nonatomic) MULoopDurationPickerView *loopLastForPickerView;
@property (strong, nonatomic) UIDatePicker *timePickerView;

@end

@implementation MUAddLoopOperationViewController

- (instancetype)initWithDeviceItem:(MUDeviceItem *)deviceItem {
    self = [super init];
    if(self){
        self.deviceItem = deviceItem;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedStringWithKey(@"device_detail_loop_title");
    self.loopIntervalPickerView = [[MULoopDurationPickerView alloc] init];
    [self.loopLastForPickerView setMode:MULoopDurationPickerViewMode_Loop];
    [self.view addSubview:self.loopIntervalPickerView];
    [self.loopIntervalPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(15);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(125);
    }];
    self.loopLastForPickerView = [[MULoopDurationPickerView alloc] init];
    [self.loopLastForPickerView setMode:MULoopDurationPickerViewMode_Keep];
    [self.view addSubview:self.loopLastForPickerView];
    [self.loopLastForPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loopIntervalPickerView.mas_bottom);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(125);
    }];
    UILabel *startTimeText = [[UILabel alloc] init];
    startTimeText.text = NSLocalizedStringWithKey(@"loop_timer_text_start_time");
    startTimeText.textColor = UIColor.blackColor;
    startTimeText.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:startTimeText];
    [startTimeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.loopLastForPickerView.mas_bottom).offset(15);
    }];

    UIDatePicker *timePickerView = [[UIDatePicker alloc] init];
    timePickerView.datePickerMode = UIDatePickerModeDateAndTime;
    [timePickerView setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans"]];
    timePickerView.backgroundColor = [UIColor colorWithRGB:0xe5f5fe];
    timePickerView.minimumDate = [NSDate date];
    [self.view addSubview:timePickerView];
    [timePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startTimeText.mas_bottom).offset(15);
        make.leading.equalTo(self.view.mas_leading).offset(40);
        make.trailing.equalTo(self.view.mas_trailing).offset(-40);
        make.height.mas_equalTo(150);
    }];
    self.timePickerView = timePickerView;
    
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

- (void)handleFinishButtonClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

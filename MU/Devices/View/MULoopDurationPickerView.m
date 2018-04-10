//
//  MULoopDurationPickerView.m
//  MU
//
//  Created by liangjiajian_mac on 2018/4/10.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MULoopDurationPickerView.h"

@interface MULoopDurationPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) UIPickerView *hourPickerView;
@property (strong, nonatomic) UIPickerView *minutePickerView;
@property (strong, nonatomic) UILabel *leftLabel;
@property (strong, nonatomic) UILabel *centerLabel;
@property (strong, nonatomic) UILabel *rightLabel;
@property (strong, nonatomic) UIButton *radioButtonTurnOn;
@property (strong, nonatomic) UIButton *radioButtonTurnOff;

@end

@implementation MULoopDurationPickerView

- (instancetype)init {
    self = [super init];
    if(self){
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.centerLabel = [[UILabel alloc] init];
    [self addSubview:self.centerLabel];
    self.centerLabel.font = [UIFont systemFontOfSize:15];
    self.centerLabel.text = NSLocalizedStringWithKey(@"loop_timer_text_hour");
    self.centerLabel.textColor = [UIColor colorWithRGB:0x656565];
    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(35);
    }];
    self.hourPickerView = [[UIPickerView alloc] init];
    self.hourPickerView.backgroundColor = [UIColor colorWithRGB:0xe5f3fe];
    self.hourPickerView.dataSource = self;
    self.hourPickerView.delegate = self;
    [self addSubview:self.hourPickerView];
    [self.hourPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerLabel.mas_centerY);
        make.trailing.equalTo(self.centerLabel.mas_leading).offset(-5);
        make.size.mas_equalTo(CGSizeMake(35, 80));
    }];
    self.leftLabel = [[UILabel alloc] init];
    [self addSubview:self.leftLabel];
    self.leftLabel.font = [UIFont systemFontOfSize:15];
    self.leftLabel.text = NSLocalizedStringWithKey(@"loop_timer_text_every");
    self.leftLabel.textColor = [UIColor colorWithRGB:0x656565];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerLabel.mas_centerY);
        make.trailing.equalTo(self.hourPickerView.mas_leading).offset(-10);
    }];
    self.minutePickerView = [[UIPickerView alloc] init];
    self.minutePickerView.backgroundColor = [UIColor colorWithRGB:0xe5f3fe];
    self.minutePickerView.dataSource = self;
    self.minutePickerView.delegate = self;
    [self addSubview:self.minutePickerView];
    [self.minutePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerLabel.mas_centerY);
        make.leading.equalTo(self.centerLabel.mas_trailing).offset(5);
        make.size.mas_equalTo(CGSizeMake(35, 80));
    }];
    self.rightLabel = [[UILabel alloc] init];
    [self addSubview:self.rightLabel];
    self.rightLabel.font = [UIFont systemFontOfSize:15];
    self.rightLabel.text = NSLocalizedStringWithKey(@"loop_timer_text_minute_execute");
    self.rightLabel.textColor = [UIColor colorWithRGB:0x656565];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerLabel.mas_centerY);
        make.leading.equalTo(self.minutePickerView.mas_trailing).offset(10);
    }];

    // 打开
    self.radioButtonTurnOn = [self createRadioButtonWithTitile:NSLocalizedStringWithKey(@"device_timer_execute_on")];
    [self addSubview:self.radioButtonTurnOn];
    [self.radioButtonTurnOn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.centerLabel.mas_centerX).offset(-10);
        make.top.equalTo(self.hourPickerView.mas_bottom).offset(10);
        make.size.mas_equalTo(self.radioButtonTurnOn.frame.size);
    }];
    [self.radioButtonTurnOn addTarget:self action:@selector(handlExecuteTurnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.radioButtonTurnOn.selected = YES;
    // 关闭
    self.radioButtonTurnOff = [self createRadioButtonWithTitile:NSLocalizedStringWithKey(@"device_timer_execute_off")];
    [self addSubview:self.radioButtonTurnOff];
    [self.radioButtonTurnOff mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.centerLabel.mas_centerX).offset(10);
        make.centerY.equalTo(self.radioButtonTurnOn.mas_centerY);
        make.size.mas_equalTo(self.radioButtonTurnOff.frame.size);
    }];
    [self.radioButtonTurnOff addTarget:self action:@selector(handlExecuteTurnOffButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.radioButtonTurnOff.selected = NO;
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

// 执行单选框
- (void)handlExecuteTurnOnClicked:(UIButton *)button {
    self.radioButtonTurnOn.selected = YES;
    self.radioButtonTurnOff.selected = NO;
}

- (void)handlExecuteTurnOffButtonClicked:(UIButton *)button {
    self.radioButtonTurnOn.selected = NO;
    self.radioButtonTurnOff.selected = YES;
}

- (void)setMode:(MULoopDurationPickerViewMode)mode {
    if(mode == MULoopDurationPickerViewMode_Loop){
        self.leftLabel.text = NSLocalizedStringWithKey(@"loop_timer_text_every");
        self.rightLabel.text = NSLocalizedStringWithKey(@"loop_timer_text_minute_execute");
    } else {
        self.leftLabel.text = NSLocalizedStringWithKey(@"loop_timer_text_last_for");
        self.rightLabel.text = NSLocalizedStringWithKey(@"loop_timer_text_after_minute_execute");
    }
}

- (NSTimeInterval)getSelectedDuration {
    return [self.hourPickerView selectedRowInComponent:0] * 3600 + [self.minutePickerView selectedRowInComponent:0] * 60;
}

- (MULoopDurationPickerViewOperation)getSelectedOperation {
    if(self.radioButtonTurnOn.selected){
        return MULoopDurationPickerViewOperation_On;
    }else{
        return MULoopDurationPickerViewOperation_Off;
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView == self.hourPickerView){
        return 24;
    }else if(pickerView == self.minutePickerView){
        return 60;
    }
    return 0;
}

#pragma mark - UIPickerViewDelegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%ld", row];;
    return label;
}

@end

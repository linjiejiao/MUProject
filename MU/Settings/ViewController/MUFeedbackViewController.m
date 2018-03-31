//
//  MUFeedbackViewController.m
//  MU
//
//  Created by liangjiajian_mac on 2018/3/25.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUFeedbackViewController.h"

@interface MUFeedbackViewController ()
@property (strong, nonatomic) UITextView *contactTextView;
@property (strong, nonatomic) UITextView *feedbackTextView;

@end

@implementation MUFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRGB:0xff1f0f5];
    self.title = NSLocalizedStringWithKey(@"settings_feedback");
    UILabel *descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.font = [UIFont systemFontOfSize:16];
    descriptionLabel.textColor = [UIColor colorWithRGB:0x656565];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.text = NSLocalizedStringWithKey(@"feedback_description");
    [self.view addSubview:descriptionLabel];
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.leading.equalTo(self.view.mas_leading).offset(30);
        make.trailing.equalTo(self.view.mas_trailing).offset(-30);
    }];

    UITextView *contactTextView = [[UITextView alloc] init];
    contactTextView.backgroundColor = UIColor.whiteColor;
    contactTextView.layer.masksToBounds = YES;
    contactTextView.layer.cornerRadius = 5;
    contactTextView.font = [UIFont systemFontOfSize:15];
    contactTextView.text = NSLocalizedStringWithKey(@"feedback_contact_placeholder");
    [self.view addSubview:contactTextView];
    [contactTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descriptionLabel.mas_bottom).offset(15);
        make.leading.equalTo(self.view.mas_leading).offset(30);
        make.trailing.equalTo(self.view.mas_trailing).offset(-30);
        make.height.mas_equalTo(50);
    }];
    self.contactTextView = contactTextView;

    UITextView *feedbackTextView = [[UITextView alloc] init];
    feedbackTextView.backgroundColor = UIColor.whiteColor;
    feedbackTextView.layer.masksToBounds = YES;
    feedbackTextView.layer.cornerRadius = 5;
    feedbackTextView.font = [UIFont systemFontOfSize:15];
    feedbackTextView.text = NSLocalizedStringWithKey(@"feedback_content_placeholder");
    [self.view addSubview:feedbackTextView];
    [feedbackTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contactTextView.mas_bottom).offset(15);
        make.leading.equalTo(self.view.mas_leading).offset(30);
        make.trailing.equalTo(self.view.mas_trailing).offset(-30);
        make.height.mas_equalTo(150);
    }];
    self.feedbackTextView = feedbackTextView;

    UIButton *summitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    summitButton.layer.masksToBounds = YES;
    summitButton.layer.cornerRadius = 22;
    summitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [summitButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:0x1b9dfc]] forState:UIControlStateNormal];
    [summitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [summitButton setTitle:NSLocalizedStringWithKey(@"button_summit") forState:UIControlStateNormal];
    [summitButton addTarget:self action:@selector(handleSummitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:summitButton];
    [summitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-PortraitSafeBottomInset - 30);
        make.leading.equalTo(self.view.mas_leading).offset(20);
        make.trailing.equalTo(self.view.mas_trailing).offset(-20);
        make.height.mas_equalTo(44);
    }];
}

- (void)handleSummitButtonClicked:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

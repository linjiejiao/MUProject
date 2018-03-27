//
//  MUChangeNickNameViewController.m
//  MU
//
//  Created by liang jiajian on 2018/3/27.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUChangeNickNameViewController.h"
#import "BottomLineTextField.h"

@interface MUChangeNickNameViewController ()
@property (strong, nonatomic) BottomLineTextField *nickNameTextField;

@end

@implementation MUChangeNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"settings_change_nickneme", nil);
    UILabel *descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.font = [UIFont systemFontOfSize:16];
    descriptionLabel.textColor = [UIColor colorWithRGB:0xaaaaaa];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.text = NSLocalizedString(@"new_nick_name", nil);
    [self.view addSubview:descriptionLabel];
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.leading.equalTo(self.view.mas_leading).offset(20);
        make.trailing.equalTo(self.view.mas_trailing).offset(-20);
    }];

    BottomLineTextField *nickNameTextField = [[BottomLineTextField alloc] init];
    nickNameTextField.textAlignment = NSTextAlignmentCenter;
    nickNameTextField.text = [GlobalConfigModel getStringConfigWithKey:kGlobalConfigModel_NickName];
    nickNameTextField.textColor = [UIColor colorWithRGB:0xaaaaaa];
    [self.view addSubview:nickNameTextField];
    [nickNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).offset(20);
        make.trailing.equalTo(self.view.mas_trailing).offset(-45);
        make.top.equalTo(descriptionLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(21);
    }];
    self.nickNameTextField = nickNameTextField;

    UIImageView *editIcon = [[UIImageView alloc] init];
    editIcon.image = [UIImage imageNamed:@"icon_edit"];
    [self.view addSubview:editIcon];
    [editIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nickNameTextField.mas_centerY);
        make.leading.equalTo(nickNameTextField.mas_trailing).offset(5);
    }];

    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.layer.masksToBounds = YES;
    confirmButton.layer.cornerRadius = 22;
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [confirmButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:0x1b9dfc]] forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setTitle:NSLocalizedString(@"button_confirm", nil) forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(handleConfirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.leading.equalTo(self.view.mas_leading).offset(20);
        make.trailing.equalTo(self.view.mas_trailing).offset(-20);
        make.height.mas_equalTo(44);
    }];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBackground:)];
    [self.view addGestureRecognizer:tap];
}

- (void)handleConfirmButtonClicked:(UIButton *)button {
    if(self.nickNameTextField.text.length <= 0){
        [self showToast:NSLocalizedString(@"empty_nick_name_tips", nil)];
        return;
    }
    [GlobalConfigModel setStringConfig:self.nickNameTextField.text forKey:kGlobalConfigModel_NickName];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleTapBackground:(UITapGestureRecognizer *)tap {
    [self.nickNameTextField endEditing:YES];
}

@end

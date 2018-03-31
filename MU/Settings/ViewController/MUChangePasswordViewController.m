//
//  MUChangePasswordViewController.m
//  MU
//
//  Created by liang jiajian on 2018/3/27.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUChangePasswordViewController.h"
#import "BottomLineTextField.h"

@interface MUChangePasswordViewController ()
@property (strong, nonatomic) BottomLineTextField *oldPasswordTextField;
@property (strong, nonatomic) BottomLineTextField *changedPasswordTextField;

@end

@implementation MUChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedStringWithKey(@"settings_change_password");
    // test code
    NSString *storedPassword = [GlobalConfigModel getStringConfigWithKey:kGlobalConfigModel_Password];
    if(storedPassword.length <= 0){
        [GlobalConfigModel setStringConfig:@"12345678" forKey:kGlobalConfigModel_Password];
    }

    BottomLineTextField *oldPasswordTextField = [[BottomLineTextField alloc] init];
    oldPasswordTextField.placeholder = NSLocalizedStringWithKey(@"old_password_placeholder");
    oldPasswordTextField.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:oldPasswordTextField];
    [oldPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).offset(25);
        make.trailing.equalTo(self.view.mas_trailing).offset(-25);
        make.top.equalTo(self.view.mas_top).offset(30);
        make.height.mas_equalTo(30);
    }];
    self.oldPasswordTextField = oldPasswordTextField;

    BottomLineTextField *changedPasswordTextField = [[BottomLineTextField alloc] init];
    changedPasswordTextField.placeholder = NSLocalizedStringWithKey(@"new_password_placeholder");
    changedPasswordTextField.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:changedPasswordTextField];
    [changedPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).offset(25);
        make.trailing.equalTo(self.view.mas_trailing).offset(-25);
        make.top.equalTo(oldPasswordTextField.mas_bottom).offset(30);
        make.height.mas_equalTo(30);
    }];
    self.changedPasswordTextField = changedPasswordTextField;

    UILabel *descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.font = [UIFont systemFontOfSize:16];
    descriptionLabel.textColor = [UIColor colorWithRGB:0x656565];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.text = NSLocalizedStringWithKey(@"change_password_tips");
    [self.view addSubview:descriptionLabel];
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(changedPasswordTextField.mas_bottom).offset(5);
        make.leading.equalTo(self.view.mas_leading).offset(25);
        make.trailing.equalTo(self.view.mas_trailing).offset(-25);
    }];

    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.layer.masksToBounds = YES;
    confirmButton.layer.cornerRadius = 22;
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [confirmButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:0x1b9dfc]] forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setTitle:NSLocalizedStringWithKey(@"button_confirm") forState:UIControlStateNormal];
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
    NSString *storedPassword = [GlobalConfigModel getStringConfigWithKey:kGlobalConfigModel_Password];
    if(![storedPassword isEqualToString:self.oldPasswordTextField.text]){
        [self showToast:NSLocalizedStringWithKey(@"old_password_not_match_tips")];
        return;
    }
    if(self.changedPasswordTextField.text.length < 8){
        [self showToast:NSLocalizedStringWithKey(@"new_password_too_short_tips")];
        return;
    }
    [GlobalConfigModel setStringConfig:self.changedPasswordTextField.text forKey:kGlobalConfigModel_Password];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleTapBackground:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

@end

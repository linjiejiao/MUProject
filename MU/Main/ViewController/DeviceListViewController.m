//
//  DeviceListViewController.m
//  MU
//
//  Created by liang jiajian on 2018/2/26.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "DeviceListViewController.h"

@interface DeviceListViewController ()

@end

@implementation DeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = [UIColor colorWithRGB:0x0076cf];
    [self.view addSubview:topBar];
    [topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

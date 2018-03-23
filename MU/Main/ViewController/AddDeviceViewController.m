//
//  AddDeviceViewController.m
//  MU
//
//  Created by liang jiajian on 2018/2/26.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "AddDeviceViewController.h"
#import "MUStepIndecatorView.h"

@interface AddDeviceViewController ()
@property (strong, nonatomic) MUStepIndecatorView *stepIndecatorView;

@end

@implementation AddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"add_device_title", nil);
    [self setupStepIndecator];
    [self.stepIndecatorView heightlightStepIndecatorAtIndex:0];
}

- (void)setupStepIndecator {
    self.stepIndecatorView = [[MUStepIndecatorView alloc] initWithStepCount:4];
    [self.view addSubview:self.stepIndecatorView];
    [self.stepIndecatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(25);
        make.size.mas_equalTo(self.stepIndecatorView.bounds.size);
    }];
}

@end

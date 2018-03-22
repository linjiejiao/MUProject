//
//  AddDeviceViewController.m
//  MU
//
//  Created by liang jiajian on 2018/2/26.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "AddDeviceViewController.h"

@interface AddDeviceViewController ()
@property (strong, nonatomic) UILabel *stepIndecator1;
@property (strong, nonatomic) UILabel *stepIndecator2;
@property (strong, nonatomic) UILabel *stepIndecator3;
@property (strong, nonatomic) UILabel *stepIndecator4;

@end

@implementation AddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"add_device_title", nil);
}

@end

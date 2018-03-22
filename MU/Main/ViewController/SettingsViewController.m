//
//  SettingsViewController.m
//  MU
//
//  Created by liang jiajian on 2018/2/26.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBarLeftBtn:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 185.0f, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.text = NSLocalizedString(@"Settings", nil);
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel sizeToFit];
    self.tabBarController.navigationItem.titleView = titleLabel;
    self.tabBarController.navigationItem.rightBarButtonItems = nil;
}

// 用tabBarController的navigationController push新界面，否则底部tabBar会一直显示
- (UINavigationController *)navigationController {
    return self.tabBarController.navigationController;
}

@end

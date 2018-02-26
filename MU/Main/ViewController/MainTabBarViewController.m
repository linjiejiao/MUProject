//
//  MainTabBarViewController.m
//  MU
//
//  Created by liang jiajian on 2018/2/26.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "DeviceListViewController.h"
#import "AddDeviceViewController.h"
#import "SettingsViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DeviceListViewController *deviceListViewVC = [[DeviceListViewController alloc] init];
    deviceListViewVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                         image:[[UIImage imageNamed:@"device_list_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                 selectedImage:[[UIImage imageNamed:@"device_list_blue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    deviceListViewVC.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -12, 0);
    AddDeviceViewController *addDeviceViewVC = [[AddDeviceViewController alloc] init];
    addDeviceViewVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                        image:[[UIImage imageNamed:@"add_device_blue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                selectedImage:[[UIImage imageNamed:@"add_device_blue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    addDeviceViewVC.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -12, 0);
    SettingsViewController *settingsViewVC = [[SettingsViewController alloc] init];
    settingsViewVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                        image:[[UIImage imageNamed:@"user_center_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                selectedImage:[[UIImage imageNamed:@"user_center_blue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    settingsViewVC.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -12, 0);

    UINavigationController *deviceListNV = [[UINavigationController alloc] initWithRootViewController:deviceListViewVC];
    UINavigationController *addDeviceNV = [[UINavigationController alloc] initWithRootViewController:addDeviceViewVC];
    UINavigationController *settingsNV = [[UINavigationController alloc] initWithRootViewController:settingsViewVC];

    self.viewControllers = @[deviceListNV, addDeviceNV, settingsNV];
}


@end

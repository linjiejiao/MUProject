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

@interface MainTabBarViewController () <UITabBarControllerDelegate>
@property (weak, nonatomic) UIViewController *fakeAddDeviceViewVC;

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DeviceListViewController *deviceListViewVC = [[DeviceListViewController alloc] init];
    deviceListViewVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                         image:[[UIImage imageNamed:@"device_list_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                 selectedImage:[[UIImage imageNamed:@"device_list_blue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    deviceListViewVC.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -12, 0);
    UIViewController *fakeAddDeviceViewVC = [[UIViewController alloc] init]; // 占位ViewController，没什么实质用途，也不会显示
    fakeAddDeviceViewVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                        image:[[UIImage imageNamed:@"add_device_blue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                selectedImage:[[UIImage imageNamed:@"add_device_blue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    fakeAddDeviceViewVC.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -12, 0);
    self.fakeAddDeviceViewVC = fakeAddDeviceViewVC;
    SettingsViewController *settingsViewVC = [[SettingsViewController alloc] init];
    settingsViewVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                        image:[[UIImage imageNamed:@"user_center_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                selectedImage:[[UIImage imageNamed:@"user_center_blue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    settingsViewVC.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -12, 0);

    self.viewControllers = @[deviceListViewVC, fakeAddDeviceViewVC, settingsViewVC];
    self.delegate = self;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if(self.fakeAddDeviceViewVC == viewController){
        AddDeviceViewController *addDeviceViewVC = [[AddDeviceViewController alloc] init];
        [self.navigationController pushViewController:addDeviceViewVC animated:YES];
        return NO;
    }
    return YES;
}

@end

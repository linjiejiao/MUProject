//
//  AppDelegate.m
//  MU
//
//  Created by liang jiajian on 2018/2/26.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "MULoginViewController.h"
#import "MULoginModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    if([[MULoginModel sharedInstance] isEverLogin]){
        [self showMainViewController];
    }else{
        [self showLoginViewController];
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - public
+ (AppDelegate *)instance {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)showMainViewController {
    MainTabBarViewController *vc = [[MainTabBarViewController alloc] init];
    UINavigationController *rootNavigation = [[UINavigationController alloc] initWithRootViewController:vc];
    rootNavigation.navigationBar.tintColor = UIColor.whiteColor;
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.frame = rootNavigation.navigationBar.bounds;
    gradientLayer.locations = @[@0, @1.f];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRGB:0x00bcfb].CGColor,
                             (__bridge id)[UIColor colorWithRGB:0x008dfa].CGColor];
    UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, YES, 0);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [rootNavigation.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.window.rootViewController = rootNavigation;
}

- (void)showLoginViewController {
    MULoginViewController *vc = [[MULoginViewController alloc] init];
    UINavigationController *rootNavigation = [[UINavigationController alloc] initWithRootViewController:vc];
    rootNavigation.navigationBarHidden = YES;
    self.window.rootViewController = rootNavigation;
}

@end

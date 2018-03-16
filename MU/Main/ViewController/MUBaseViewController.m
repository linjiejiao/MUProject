//
//  MUBaseViewController.m
//  MU
//
//  Created by liang jiajian on 2018/3/16.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUBaseViewController.h"

@interface MUBaseViewController () <MUNavigationViewDelegate>

@end

@implementation MUBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView = [[MUNavigationView alloc] init];
    self.navigationView.delegate = self;
    [self.view addSubview:self.navigationView];
    [self.navigationView setupLeftButtonWithNormalImage:[UIImage imageNamed:@"navigation_back"] selectedImage:nil];
}


- (void)setTitle:(NSString *)title {
    if([self.navigationView isKindOfClass:[UILabel class]]){
        ((UILabel *)self.navigationView.titleView).text = title;
    }else{
        [self.navigationView setupTitleViewWithTitle:title];
    }
}

- (void)setNaviBarLeftBtn:(UIButton*)btn {
    self.navigationView.leftButton = btn;
}

- (void)setNaviBarRightBtn:(UIButton*)btn {
    self.navigationView.rightButton = btn;
}

- (void)handleTitleClicked {
    // to override
}

- (void)handleNavigationLeftClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MUNavigationViewDelegate
- (void)navigationViewDidClickLeftButton:(MUNavigationView *)navigationView {
    [self handleNavigationLeftClicked:navigationView.leftButton];
}

- (void)navigationViewDidClickRightButton:(MUNavigationView *)navigationView {
    [self handleNavigationRightClicked:navigationView.rightButton];
}

- (void)navigationViewDidClickTitleView:(MUNavigationView *)navigationView {
    [self handleTitleClicked];
}

@end

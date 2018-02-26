//
//  BaseViewController.m
//
//  Created by liang jiajian on 2018/2/26.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "BaseViewController.h"
#import "ToastAlertView.h"

#define MAX_TITLE_WIDTH     185.0f

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.autoresizesSubviews = YES;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

//标题
- (void)setTitle:(NSString *)title {
    if (title) {
        UIFont *font = [UIFont boldSystemFontOfSize:15];
        if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.2 )) {
            font = [UIFont systemFontOfSize:15];
        }
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAX_TITLE_WIDTH, 44)];
        titleLabel.font = font;
        titleLabel.text = title;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [titleLabel sizeToFit];
        self.navigationItem.titleView = titleLabel;
    } else {
        self.navigationItem.titleView = nil;
    }
}

// 左按钮
- (void)setNaviBarLeftBtn:(UIButton*)btn {
    self .navigationItem.leftBarButtonItems = nil;
    if (btn) {
        [btn addTarget:self action:@selector(handleNavigationLeftClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        int margin = -6;
        negativeSpacer.width = margin;
        [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, leftBtnItem, nil]];
    };
}

// 右按钮
- (void)setNaviBarRightBtn:(UIButton*)btn {
    self.navigationItem.rightBarButtonItems = nil;
    if (btn) {
        [btn addTarget:self action:@selector(handleNavigationRightClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        int margin = -6;
        negativeSpacer.width = margin;
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, rightBtnItem, nil]];
    };
}

-(void)showToast:(NSString *)msg {
    [ToastAlertView showToast:msg inView:self.view];
}

- (void)shwoAlertWithTitle:(NSString *)title message:(NSString *)message btn1Title:(NSString *)btn1Title btn1Handler:(void (^)(UIAlertAction *action))btn1Handler btn2Title:(NSString *)btn2Title btn2Handler:(void (^)(UIAlertAction *action))btn2Handler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:btn1Title style:UIAlertActionStyleDefault handler:btn1Handler]];
    [alert addAction:[UIAlertAction actionWithTitle:btn2Title style:UIAlertActionStyleCancel handler:btn2Handler]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - User Interactions
- (void)handleNavigationLeftClicked:(UIButton *)sender {
    
}

- (void)handleNavigationRightClicked:(UIButton *)sender {
    
}
@end

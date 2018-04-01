//
//  BaseViewController.h
//
//  Created by liang jiajian on 2018/2/26.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
- (void)setTitle:(NSString *)title;
- (void)setNaviBarLeftBtn:(UIButton*)btn;
- (void)setNaviBarRightBtn:(UIButton*)btn;

- (void)handleNavigationLeftClicked:(UIButton *)sender;
- (void)handleNavigationRightClicked:(UIButton *)sender;

- (void)showToast:(NSString *)msg;

- (void)showLoadingViewWithText:(NSString *)text;
- (void)hideLoadingView;

@end

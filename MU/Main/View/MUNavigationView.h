//
//  MUNavigationView.h
//  MU
//
//  Created by liang jiajian on 2018/3/16.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MUNavigationView;

@protocol MUNavigationViewDelegate <NSObject>
@optional
- (void)navigationViewDidClickLeftButton:(MUNavigationView *)navigationView;

- (void)navigationViewDidClickRightButton:(MUNavigationView *)navigationView;

- (void)navigationViewDidClickTitleView:(MUNavigationView *)navigationView;

@end

@interface MUNavigationView : UIView
@property (weak, nonatomic) id<MUNavigationViewDelegate> delegate;

@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;
@property (strong, nonatomic) UIView *titleView;

- (UIButton *)setupLeftButtonWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;

- (UIButton *)setupRightButtonWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;

- (UIView *)setupTitleViewWithTitle:(NSString *)title;

@end

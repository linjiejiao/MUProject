//
//  MUNavigationView.m
//  MU
//
//  Created by liang jiajian on 2018/3/16.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUNavigationView.h"

@interface MUNavigationView ()

@end

@implementation MUNavigationView

- (instancetype)init {
    self = [super init];
    if(self){
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor colorWithRGB:0x0076cf];
    self.frame = CGRectMake(0, 0, ScreenWidth, 44 + StatusBarHeight);
}

- (UIButton *)setupLeftButtonWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.imageView.contentMode = UIViewContentModeCenter;
    [leftButton setImage:normalImage forState:UIControlStateNormal];
    [leftButton setImage:selectedImage forState:UIControlStateSelected];
    self.leftButton = leftButton;
    return leftButton;
}

- (UIButton *)setupRightButtonWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:normalImage forState:UIControlStateNormal];
    [rightButton setImage:selectedImage forState:UIControlStateSelected];
    self.rightButton = rightButton;
    return rightButton;
}

- (UIView *)setupTitleViewWithTitle:(NSString *)title {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = UIColor.whiteColor;
    titleLabel.text = title;
    self.titleView = titleLabel;
    return titleLabel;
}

#pragma mark - setters
- (void)setLeftButton:(UIButton *)leftButton {
    [leftButton addTarget:self action:@selector(handleLeftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(44);
        make.width.mas_greaterThanOrEqualTo(44);
    }];
    if(_leftButton){
        [_leftButton removeFromSuperview];
    }
    _leftButton = leftButton;
}

- (void)setRightButton:(UIButton *)rightButton {
    [rightButton addTarget:self action:@selector(handleRightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(44);
        make.width.mas_greaterThanOrEqualTo(44);
    }];
    if(_rightButton){
        [_rightButton removeFromSuperview];
    }
    _rightButton = rightButton;
}

- (void)setTitleView:(UIView *)titleView {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTitleViewClicked:)];
    [titleView addGestureRecognizer:tap];
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    if(_titleView){
        [_titleView removeFromSuperview];
    }
    _titleView = titleView;
}

#pragma mark - Actions
- (void)handleLeftButtonClicked:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(navigationViewDidClickLeftButton:)]){
        [self.delegate navigationViewDidClickLeftButton:self];
    }
}

- (void)handleRightButtonClicked:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(navigationViewDidClickRightButton:)]){
        [self.delegate navigationViewDidClickRightButton:self];
    }
}

- (void)handleTitleViewClicked:(UITapGestureRecognizer *)tapGestureRecognizer {
    if(self.delegate && [self.delegate respondsToSelector:@selector(navigationViewDidClickTitleView:)]){
        [self.delegate navigationViewDidClickTitleView:self];
    }
}

@end

//
//  LoadingTipsView.m
//  MU
//
//  Created by liangjiajian_mac on 2018/4/1.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "LoadingTipsView.h"

@interface LoadingTipsView ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UILabel *activityLabel;

@end

@implementation LoadingTipsView

+ (LoadingTipsView *)showInView:(UIView *)parentView withText:(NSString *)text {
    LoadingTipsView *view = [[LoadingTipsView alloc] init];
    view.containerView = [[UIView alloc] init];
    view.containerView.backgroundColor = [UIColor colorWithRGBA:0x0000007f];
    view.containerView.layer.masksToBounds = YES;
    view.containerView.layer.cornerRadius = 5;
    [view addSubview:view.containerView];
    view.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [view.containerView addSubview:view.activityIndicator];
    [view.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.containerView.mas_centerX);
        make.top.equalTo(view.containerView.mas_top).offset(10);
    }];
    view.activityLabel = [[UILabel alloc] init];
    view.activityLabel.text = text;
    view.activityLabel.textColor = UIColor.whiteColor;
    view.activityLabel.textAlignment = NSTextAlignmentCenter;
    [view.containerView addSubview:view.activityLabel];
    CGSize textSize = [view.activityLabel sizeThatFits:parentView.size];
    [view.activityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.activityIndicator.mas_bottom).offset(10);
        make.leading.equalTo(view.containerView.mas_leading).offset(10);
        make.trailing.equalTo(view.containerView.mas_trailing).offset(-10);
    }];
    CGFloat width = MAX(textSize.width + 20, 100);
    [view.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(width, 90));
    }];
    [parentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(parentView);
    }];
    [view.activityIndicator startAnimating];
    return view;
}

- (void)dismiss {
    [self removeFromSuperview];
}

@end

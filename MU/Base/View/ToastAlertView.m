//
//  ToastAlertView.m
//
//  Created by liang jiajian on 2018/2/26.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "ToastAlertView.h"
#import <QuartzCore/QuartzCore.h>

@interface ToastAlertView()
@property (strong, nonatomic) UILabel *textLabel;

@end

@implementation ToastAlertView

+ (void)showToast:(NSString*)msg {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self showToast:msg inView:keyWindow];
}

+ (void)showToast:(NSString*)msg inView:(UIView *)view {
    if ([msg length] <= 0) {
        return;
    }
    ToastAlertView *toastView = [[ToastAlertView alloc] init];
    toastView.textLabel.text = msg;
    [toastView.textLabel sizeToFit];
    CGRect frame = toastView.textLabel.frame;
    frame.origin = CGPointMake(10, 10);
    toastView.textLabel.frame = frame;
    frame.size.width += 20;
    frame.size.height += 20;
    frame.origin.x = (view.frame.size.width - frame.size.width) / 2;
    frame.origin.y = (view.frame.size.height - frame.size.height) / 2;
    toastView.frame = frame;
    [view addSubview:toastView];
    [view bringSubviewToFront:toastView];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
    [toastView performSelector:@selector(dismiss) withObject:nil afterDelay:1.5];
}

- (id)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        self.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8].CGColor;
        self.layer.shadowOpacity = 0.8;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowRadius = 3;
        self.layer.cornerRadius = 6;
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 260)];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.numberOfLines = 0;
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.textLabel];
    }
    return self;
}

- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
}

- (void)dismiss {
    [self removeFromSuperview];
}

@end

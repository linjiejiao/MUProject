//
//  ToastAlertView.h
//
//  Created by liang jiajian on 2018/2/26.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToastAlertView : UIView

+ (void)showToast:(NSString*)msg;
+ (void)showToast:(NSString*)msg inView:(UIView *)view;

@end

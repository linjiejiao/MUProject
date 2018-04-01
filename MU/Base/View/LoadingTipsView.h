//
//  LoadingTipsView.h
//  MU
//
//  Created by liangjiajian_mac on 2018/4/1.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingTipsView : UIView

+ (LoadingTipsView *)showInView:(UIView *)parentView withText:(NSString *)text;

- (void)dismiss;

@end

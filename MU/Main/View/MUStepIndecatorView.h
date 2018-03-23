//
//  MUStepIndecatorView.h
//  MU
//
//  Created by liang jiajian on 2018/3/23.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MUStepIndecatorView : UIView

- (instancetype)initWithStepCount:(NSUInteger)stepCount;

- (void)heightlightStepIndecatorAtIndex:(NSUInteger)index;

@end

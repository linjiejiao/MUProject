//
//  MULoopDurationPickerView.h
//  MU
//
//  Created by liangjiajian_mac on 2018/4/10.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MULoopDurationPickerViewOperation) {
    MULoopDurationPickerViewOperation_On,
    MULoopDurationPickerViewOperation_Off,
};

typedef NS_ENUM(NSUInteger, MULoopDurationPickerViewMode) {
    MULoopDurationPickerViewMode_Loop,
    MULoopDurationPickerViewMode_Keep,
};

@interface MULoopDurationPickerView : UIView

- (void)setMode:(MULoopDurationPickerViewMode)mode;

- (NSTimeInterval)getSelectedDuration;

- (MULoopDurationPickerViewOperation)getSelectedOperation;

@end

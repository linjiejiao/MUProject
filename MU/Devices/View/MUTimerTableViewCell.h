//
//  MUTimerTableViewCell.h
//  MU
//
//  Created by liangjiajian_mac on 2018/3/31.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MUDeviceTimerItem;
@class MUTimerTableViewCell;

@protocol MUTimerTableViewCellDelegate <NSObject>
@optional
- (void)timerCell:(MUTimerTableViewCell *)cell didClickedStatusButtonWithItem:(MUDeviceTimerItem *)item;

@end

@interface MUTimerTableViewCell : UITableViewCell
@property (weak, nonatomic) id<MUTimerTableViewCellDelegate> delegate;
@property (strong, nonatomic) MUDeviceTimerItem *timerItem;

@end

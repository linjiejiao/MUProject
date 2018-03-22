//
//  MUDeviceCollectionViewCell.h
//  MU
//
//  Created by liang jiajian on 2018/3/21.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@class MUDeviceItem;
@class MUDeviceCollectionViewCell;

@protocol MUDeviceCollectionViewCellDelegate <NSObject>
@optional
- (void)deviceCell:(MUDeviceCollectionViewCell *)cell didClickDeleteButtonWithDeviceItem:(MUDeviceItem *)deviceItem;

@end

@interface MUDeviceCollectionViewCell : BaseCollectionViewCell
@property (weak, nonatomic) id<MUDeviceCollectionViewCellDelegate> delegate;
@property (strong, nonatomic) MUDeviceItem *deviceItem;

@end

//
//  MUDevicesDataSource.h
//  MU
//
//  Created by liang jiajian on 2018/3/22.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MUDeviceCollectionViewCell.h"

#import "MUDeviceItem.h"

@interface MUDevicesDataSource : NSObject <UICollectionViewDataSource>

- (instancetype)initWithCellDelegate:(id<MUDeviceCollectionViewCellDelegate>)cellDelegate;

- (void)loadDataWithCompletion:(void(^)(BOOL success, NSArray<MUDeviceItem *> *devicesList))completion;

- (MUDeviceItem *)getDeviceItemAtIndexPath:(NSIndexPath *)index;

@end

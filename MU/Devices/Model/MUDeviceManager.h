//
//  MUDeviceManager.h
//  MU
//
//  Created by liangjiajian_mac on 2018/4/1.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUDeviceItem.h"

FOUNDATION_EXPORT NSString* kNotifcation_MUDeviceManager_DeviceListChanged;

@interface MUDeviceManager : NSObject

+ (MUDeviceManager *)sharedInstance;

- (void)loadDataWithCompletion:(void(^)(BOOL success, NSArray<MUDeviceItem *> *devicesList))completion;

- (void)addDevice:(MUDeviceItem *)device;

- (void)removeDevice:(MUDeviceItem *)device;

- (void)synchronize;

@end

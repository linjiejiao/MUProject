//
//  MUDeviceItem.m
//  MU
//
//  Created by liang jiajian on 2018/3/22.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUDeviceItem.h"
#import "MUDeviceManager.h"

@implementation MUDeviceItem

- (void)save {
     [[MUDeviceManager sharedInstance] synchronize];
}

@end

@implementation MUDeviceOperationLog

@end

@implementation MUDeviceTimerItem

@end

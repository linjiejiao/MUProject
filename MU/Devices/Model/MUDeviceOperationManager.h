//
//  MUDeviceOperationManager.h
//  MU
//
//  Created by liangjiajian_mac on 2018/3/31.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUDeviceItem.h"

@interface MUDeviceOperationManager : NSObject

+ (MUDeviceOperationManager *)sharedInstance;

- (BOOL)doOperateDevice:(MUDeviceItem *)deviceItem actionType:(MUDeviceAction)action time:(NSTimeInterval)time trigger:(MUDeviceOperationLogTrigger)trigger;

@end

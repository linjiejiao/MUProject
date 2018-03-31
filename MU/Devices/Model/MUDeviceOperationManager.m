//
//  MUDeviceOperationManager.m
//  MU
//
//  Created by liangjiajian_mac on 2018/3/31.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUDeviceOperationManager.h"

@implementation MUDeviceOperationManager

+ (MUDeviceOperationManager *)sharedInstance {
    static MUDeviceOperationManager *sInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sInstance = [[MUDeviceOperationManager alloc] init];
    });
    return sInstance;
}

- (BOOL)doOperateDevice:(MUDeviceItem *)deviceItem actionType:(MUDeviceOperationLogAction)action time:(NSTimeInterval)time trigger:(MUDeviceOperationLogTrigger)trigger {
    NSMutableArray<MUDeviceOperationLog *> *logs = [[NSMutableArray alloc] init];
    if(deviceItem.operationLogs.count > 0){
        [logs addObjectsFromArray:deviceItem.operationLogs];
    }
    MUDeviceOperationLog *newLog = [[MUDeviceOperationLog alloc] init];
    newLog.logActionType = action;
    newLog.logTime = time;
    newLog.triggerType = trigger;
    [logs addObject:newLog];
    deviceItem.operationLogs = logs;
    return YES;
}

@end

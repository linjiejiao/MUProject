//
//  MUDeviceItem.h
//  MU
//
//  Created by liang jiajian on 2018/3/22.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MUDeviceOperationLog;

typedef NS_ENUM(NSUInteger, MUDeviceItemStatus) {
    MUDeviceItemStatus_On,
    MUDeviceItemStatus_Off,
};

typedef NS_ENUM(NSUInteger, MUDeviceItemType) {
    MUDeviceItemType_Touch,
    MUDeviceItemType_AP,
    MUDeviceItemType_GSMDevice,
    MUDeviceItemType_Count, // 类型总数
};

@interface MUDeviceItem : NSObject
@property (assign, nonatomic) int deviceId;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) MUDeviceItemStatus status;
@property (assign, nonatomic) MUDeviceItemType type;
@property (assign, nonatomic) BOOL hasTimer;
@property (strong, nonatomic) NSArray<MUDeviceOperationLog *> *operationLogs;

@end

typedef NS_ENUM(NSUInteger, MUDeviceOperationLogAction) {
    MUDeviceOperationLogAction_On,
    MUDeviceOperationLogAction_Off,
};

typedef NS_ENUM(NSUInteger, MUDeviceOperationLogTrigger) {
    MUDeviceOperationLogTrigger_App,
    MUDeviceOperationLogTrigger_Device,
};

@interface MUDeviceOperationLog : NSObject
@property (assign, nonatomic) NSTimeInterval logTime;
@property (assign, nonatomic) MUDeviceOperationLogAction logActionType;
@property (assign, nonatomic) MUDeviceOperationLogTrigger triggerType;

@end

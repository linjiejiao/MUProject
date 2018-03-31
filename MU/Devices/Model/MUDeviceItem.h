//
//  MUDeviceItem.h
//  MU
//
//  Created by liang jiajian on 2018/3/22.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MUDeviceOperationLog;
@class MUDeviceTimerItem;

typedef NS_ENUM(NSUInteger, MUDeviceAction) {
    MUDeviceAction_On,
    MUDeviceAction_Off,
};

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
@property (strong, nonatomic) NSArray<MUDeviceTimerItem *> *timerItems;

@end

typedef NS_ENUM(NSUInteger, MUDeviceOperationLogTrigger) {
    MUDeviceOperationLogTrigger_App,
    MUDeviceOperationLogTrigger_Device,
};

@interface MUDeviceOperationLog : NSObject
@property (assign, nonatomic) NSTimeInterval logTime;
@property (assign, nonatomic) MUDeviceAction logActionType;
@property (assign, nonatomic) MUDeviceOperationLogTrigger triggerType;

@end

typedef NS_ENUM(NSUInteger, MUDeviceTimerItemStatus) {
    MUDeviceTimerItemStatus_On,
    MUDeviceTimerItemStatus_Off,
};

typedef NS_ENUM(NSUInteger, MUDeviceTimerItemRepeatType) {
    MUDeviceTimerItemRepeatType_OnlyOnce, //定时一次
    MUDeviceTimerItemRepeatType_Weekly, //周循环
};

typedef NS_ENUM(NSUInteger, MUDeviceTimerItemStrtus) {
    MUDeviceTimerItemStrtus_Enable,
    MUDeviceTimerItemStrtus_Disable,
};

@interface MUDeviceTimerItem : NSObject
@property (assign, nonatomic) MUDeviceTimerItemStrtus status;
@property (assign, nonatomic) MUDeviceTimerItemRepeatType repeatType;
@property (assign, nonatomic) MUDeviceAction action;
@property (strong, nonatomic) NSArray<NSNumber *> *weeklyDays;
@property (assign, nonatomic) uint32_t minutesOfDay; //每天凌晨0点0分算起的分钟数

@end

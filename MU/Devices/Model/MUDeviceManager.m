//
//  MUDeviceManager.m
//  MU
//
//  Created by liangjiajian_mac on 2018/4/1.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUDeviceManager.h"
NSString * kNotifcation_MUDeviceManager_DeviceListChanged = @"kNotifcation_MUDeviceManager_DeviceListChanged";

@interface MUDeviceManager ()
@property (strong, nonatomic) NSMutableArray <MUDeviceItem *> *devicesList;

@end

@implementation MUDeviceManager

+ (MUDeviceManager *)sharedInstance {
    static MUDeviceManager *sInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sInstance = [[MUDeviceManager alloc] init];
    });
    return sInstance;
}


- (void)loadDataWithCompletion:(void(^)(BOOL success, NSArray<MUDeviceItem *> *devicesList))completion {
    if(self.devicesList.count > 0){
        if(completion){
            completion(YES, [self.devicesList copy]);
        }
        return;
    }
    // Test Data
    NSMutableArray<MUDeviceItem *> *array = [[NSMutableArray alloc] init];
    MUDeviceItem *item = [[MUDeviceItem alloc] init];
    item.name = @"橙子果园A区（小株）";
    item.status = MUDeviceItemStatus_On;
    MUDeviceTimerItem *timerItem = [[MUDeviceTimerItem alloc] init];
    timerItem.status = MUDeviceTimerItemStrtus_Disable;
    timerItem.repeatType = MUDeviceTimerItemRepeatType_Weekly;
    timerItem.weeklyDays = @[@(1), @(3), @(5)];
    timerItem.minutesOfDay = 7 * 60 + 45;
    MUDeviceTimerItem *timerItem2 = [[MUDeviceTimerItem alloc] init];
    timerItem2.status = MUDeviceTimerItemStrtus_Enable;
    timerItem2.repeatType = MUDeviceTimerItemRepeatType_OnlyOnce;
    timerItem2.minutesOfDay = 12 * 60 + 23;
    item.timerItems = @[timerItem, timerItem2];
    item.hasTimer = YES;
    [array addObject:item];
    item = [[MUDeviceItem alloc] init];
    item.name = @"橙子果园B区（小株）";
    item.status = MUDeviceItemStatus_Off;
    item.hasTimer = NO;
    [array addObject:item];
    item = [[MUDeviceItem alloc] init];
    item.name = @"哈密瓜果园C区（大株）";
    item.status = MUDeviceItemStatus_On;
    item.hasTimer = NO;
    [array addObject:item];
    item = [[MUDeviceItem alloc] init];
    item.name = @"哈密瓜果园D区（大株）";
    item.status = MUDeviceItemStatus_Off;
    item.hasTimer = YES;
    timerItem = [[MUDeviceTimerItem alloc] init];
    timerItem.status = MUDeviceTimerItemStrtus_Enable;
    timerItem.repeatType = MUDeviceTimerItemRepeatType_OnlyOnce;
    timerItem.minutesOfDay = 12 * 60 + 23;
    item.timerItems = @[timerItem];
    [array addObject:item];
    item = [[MUDeviceItem alloc] init];
    item.name = @"哈密瓜果园E区（大株）";
    item.status = MUDeviceItemStatus_On;
    item.hasTimer = NO;
    [array addObject:item];
    item = [[MUDeviceItem alloc] init];
    item.name = @"哈密瓜果园F区（大株）";
    item.status = MUDeviceItemStatus_On;
    item.hasTimer = NO;
    [array addObject:item];
    item = [[MUDeviceItem alloc] init];
    item.name = @"哈密瓜果园G区（大株）";
    item.status = MUDeviceItemStatus_On;
    item.hasTimer = NO;
    [array addObject:item];
    item = [[MUDeviceItem alloc] init];
    item.name = @"哈密瓜果园H区（大株）";
    item.status = MUDeviceItemStatus_On;
    item.hasTimer = NO;
    [array addObject:item];
    self.devicesList = array;
    if(completion){
        completion(YES, [array copy]);
    }
}

- (void)addDevice:(MUDeviceItem *)device {
    if(!device){
        return;
    }
    if(!self.devicesList){
        self.devicesList = [[NSMutableArray alloc] init];
    }
    [self.devicesList addObject:device];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifcation_MUDeviceManager_DeviceListChanged object:nil];
}

- (void)removeDevice:(MUDeviceItem *)device {
    if(!device){
        return;
    }
    [self.devicesList removeObject:device];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifcation_MUDeviceManager_DeviceListChanged object:nil];
}

@end

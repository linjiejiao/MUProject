//
//  MUDevicesDataSource.m
//  MU
//
//  Created by liang jiajian on 2018/3/22.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUDevicesDataSource.h"

@interface MUDevicesDataSource ()
@property (weak, nonatomic) id<MUDeviceCollectionViewCellDelegate> cellDelegate;
@property (strong, nonatomic) NSArray <MUDeviceItem *> *devicesList;

@end

@implementation MUDevicesDataSource

- (instancetype)initWithCellDelegate:(id<MUDeviceCollectionViewCellDelegate>)cellDelegate {
    self = [super init];
    if(self){
        self.cellDelegate = cellDelegate;
    }
    return self;
}

- (void)loadDataWithCompletion:(void(^)(BOOL success, NSArray<MUDeviceItem *> *devicesList))completion {
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

- (MUDeviceItem *)getDeviceItemAtIndexPath:(NSIndexPath *)index {
    if(index.item < self.devicesList.count){
        return self.devicesList[index.item];
    }
    return nil;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.devicesList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MUDeviceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MUDeviceCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    cell.delegate = self.cellDelegate;
    if(indexPath.item < self.devicesList.count){
        cell.deviceItem = self.devicesList[indexPath.item];
    }
    return cell;
}

@end

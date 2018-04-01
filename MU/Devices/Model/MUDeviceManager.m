//
//  MUDeviceManager.m
//  MU
//
//  Created by liangjiajian_mac on 2018/4/1.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUDeviceManager.h"
#import "Sandbox.h"

NSString * kNotifcation_MUDeviceManager_DeviceListChanged = @"kNotifcation_MUDeviceManager_DeviceListChanged";

#define CachedDeviceListFileName    @"device_list"

#define TAG @"MUDeviceManager"

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
    NSString *filePath = [[Sandbox docPath] stringByAppendingPathComponent:CachedDeviceListFileName];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        self.devicesList = [unarchiver decodeObjectForKey:@"devicesList"];
        [unarchiver finishDecoding];
    }
    if(completion){
        completion(YES, [self.devicesList copy]);
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
    [self synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifcation_MUDeviceManager_DeviceListChanged object:nil];
}

- (void)removeDevice:(MUDeviceItem *)device {
    if(!device){
        return;
    }
    [self.devicesList removeObject:device];
    [self synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifcation_MUDeviceManager_DeviceListChanged object:nil];
}

- (void)synchronize {
    NSMutableData *mutableData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
    [archiver encodeObject:self.devicesList forKey:@"devicesList"];
    [archiver finishEncoding];
    NSString *filePath = [[Sandbox docPath] stringByAppendingPathComponent:CachedDeviceListFileName];
    if (![mutableData writeToFile:filePath atomically:YES]) {
        [Log e:TAG format:@"synchronize Failed to write file to %@", filePath];
    }
}

@end

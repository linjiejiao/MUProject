//
//  MUDeviceItem.h
//  MU
//
//  Created by liang jiajian on 2018/3/22.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MUDeviceItemStatus) {
    MUDeviceItemStatus_On,
    MUDeviceItemStatus_Off,
};

@interface MUDeviceItem : NSObject
@property (assign, nonatomic) int deviceId;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) MUDeviceItemStatus status;
@property (assign, nonatomic) BOOL hasTimer;

@end

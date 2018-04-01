//
//  BaseCodingObject.h
//  MU
//
//  Created by liangjiajian_mac on 2018/4/1.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseCodingObject : NSObject <NSCoding>

- (NSArray<NSString *> *)cachePropertyNames; //默认cache所有属性，子类可以覆盖。若有非<NSCoding>属性，需要覆盖该方法并剔除非<NSCoding>属性，否则会崩溃

@end

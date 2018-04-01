//
//  Sandbox.h
//  MU
//
//  Created by liangjiajian_mac on 2018/4/1.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sandbox : NSObject

+ (NSString *)appPath;
+ (NSString *)docPath;
+ (NSString *)libCachePath;
+ (NSString *)tmpPath;

+ (BOOL)touch:(NSString *)path;

@end

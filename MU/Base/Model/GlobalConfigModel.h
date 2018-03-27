//
//  GlobalConfigModel.h
//  MU
//
//  Created by liang jiajian on 2018/3/16.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString* kGlobalConfigModel_isEverLogin;
FOUNDATION_EXPORT NSString* kGlobalConfigModel_NickName;
FOUNDATION_EXPORT NSString* kGlobalConfigModel_Password;

@interface GlobalConfigModel : NSObject

+ (BOOL)getBOOLConfigWithKey:(NSString *)key;

+ (void)setBOOLConfig:(BOOL)config forKey:(NSString *)key;

+ (NSString *)getStringConfigWithKey:(NSString *)key;

+ (void)setStringConfig:(NSString *)config forKey:(NSString *)key;

@end

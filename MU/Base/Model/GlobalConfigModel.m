//
//  GlobalConfigModel.m
//  MU
//
//  Created by liang jiajian on 2018/3/16.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "GlobalConfigModel.h"

NSString const* kGlobalConfigModel_isEverLogin = @"kGlobalConfigModel_isEverLogin";
NSString const* kGlobalConfigModel_NickName = @"kGlobalConfigModel_NickName";
NSString const* kGlobalConfigModel_Password = @"kGlobalConfigModel_Password";

@implementation GlobalConfigModel

+ (NSUserDefaults *)userDefault {
    return [NSUserDefaults standardUserDefaults];
}

+ (BOOL)getBOOLConfigWithKey:(NSString *)key {
    return [self.userDefault boolForKey:key];
}

+ (void)setBOOLConfig:(BOOL)config forKey:(NSString *)key {
    [self.userDefault setBool:config forKey:key];
    [self.userDefault synchronize];
}

+ (NSString *)getStringConfigWithKey:(NSString *)key {
    NSString *config = [self.userDefault stringForKey:key];
    if(![config isKindOfClass:[NSString class]]){
        return nil;
    }
    return config;
}

+ (void)setStringConfig:(NSString *)config forKey:(NSString *)key {
    [self.userDefault setObject:config forKey:key];
    [self.userDefault synchronize];
}

@end

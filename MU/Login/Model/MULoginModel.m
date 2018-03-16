//
//  MULoginModel.m
//  MU
//
//  Created by liang jiajian on 2018/2/27.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MULoginModel.h"
#import "GlobalConfigModel.h"

@implementation MULoginModel

+ (MULoginModel *)sharedInstance {
    static MULoginModel *sInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sInstance = [[MULoginModel alloc] init];
    });
    return sInstance;
}

- (BOOL)isEverLogin {
    return [GlobalConfigModel getBOOLConfigWithKey:kGlobalConfigModel_isEverLogin];
}

- (void)setIsEverLogin:(BOOL)isEverLogin {
    [GlobalConfigModel setBOOLConfig:isEverLogin forKey:kGlobalConfigModel_isEverLogin];
}

@end

//
//  MULoginModel.h
//  MU
//
//  Created by liang jiajian on 2018/2/27.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MULoginModel : NSObject

+ (MULoginModel *)sharedInstamce;

- (BOOL)isEverLogin;

@end

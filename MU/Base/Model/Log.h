//
//  Log.h
//  MySuperApp
//
//  Created by liangjiajian_mac on 2017/5/21.
//  Copyright © 2017年 liangjiajian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Log : NSObject
+(void)v:(NSString*)tag format:(NSString*)format, ...;
+(void)d:(NSString*)tag format:(NSString*)format, ...;
+(void)i:(NSString*)tag format:(NSString*)format, ...;
+(void)w:(NSString*)tag format:(NSString*)format, ...;
+(void)e:(NSString*)tag format:(NSString*)format, ...;

@end

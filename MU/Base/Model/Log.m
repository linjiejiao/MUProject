//
//  Log.m
//  MySuperApp
//
//  Created by liangjiajian_mac on 2017/5/21.
//  Copyright © 2017年 liangjiajian. All rights reserved.
//

#import "Log.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

static const DDLogLevel ddLogLevel = DDLogLevelDebug;

@implementation Log
+(void)v:(NSString*)tag format:(NSString*)format, ... {
    format = [NSString stringWithFormat:@"%@: %@", tag, format];
    va_list args;
    va_start(args, format);
    NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    DDLogVerbose(@"%@", msg);
}

+(void)d:(NSString*)tag format:(NSString*)format, ... {
    format = [NSString stringWithFormat:@"%@: %@", tag, format];
    va_list args;
    va_start(args, format);
    NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    DDLogDebug(@"%@", msg);
}

+(void)i:(NSString*)tag format:(NSString*)format, ... {
    format = [NSString stringWithFormat:@"%@: %@", tag, format];
    va_list args;
    va_start(args, format);
    NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    DDLogInfo(@"%@", msg);
}

+(void)w:(NSString*)tag format:(NSString*)format, ... {
    format = [NSString stringWithFormat:@"%@: %@", tag, format];
    va_list args;
    va_start(args, format);
    NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    DDLogWarn(@"%@", msg);
}

+(void)e:(NSString*)tag format:(NSString*)format, ... {
    format = [NSString stringWithFormat:@"%@: %@", tag, format];
    va_list args;
    va_start(args, format);
    NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    DDLogError(@"%@", msg);
}

@end

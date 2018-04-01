//
//  BaseCodingObject.m
//  MU
//
//  Created by liangjiajian_mac on 2018/4/1.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "BaseCodingObject.h"
#import "objc/runtime.h"

@implementation BaseCodingObject

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    NSDictionary *dict = [aDecoder decodeObjectForKey:NSStringFromClass([self class])];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        NSArray<NSString *> *propertyNames = [self cachePropertyNames];
        for(NSString *property in propertyNames){
            id value = dict[property];
            if(!value || [value isKindOfClass:[NSNull class]]){ //NSDictionary 的value有可能为NSNull
                continue;
            }
            [self setValue:value forKey:property];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray<NSString *> *propertyNames = [self cachePropertyNames];
    NSDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[self dictionaryWithValuesForKeys:propertyNames]];
    [aCoder encodeObject:dict forKey:NSStringFromClass([self class])];
}

- (NSArray<NSString *> *)cachePropertyNames {
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    NSMutableArray *propertyNames = [[NSMutableArray alloc] init];
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = properties[i];
        const char * propName = property_getName(property);
        if (propName) {
            NSString *prop = [NSString stringWithCString:propName encoding:[NSString defaultCStringEncoding]];
            [propertyNames addObject:prop];
        }
    }
    free(properties);
    return propertyNames;
}

@end

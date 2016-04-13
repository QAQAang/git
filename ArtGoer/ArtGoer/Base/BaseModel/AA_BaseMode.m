//
//  AA_BaseMode.m
//  ArtGoer
//
//  Created by dllo on 16/2/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_BaseMode.h"

@implementation AA_BaseMode

- (instancetype)initWithDic:(NSMutableDictionary *)dic{
    self = [super init];
    if (self) {
       [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)modelWithDic:(NSMutableDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _id_AA = value;
    }else{
        NSLog(@"%@错误的key是%@", [self class],key);
    }
}

@end

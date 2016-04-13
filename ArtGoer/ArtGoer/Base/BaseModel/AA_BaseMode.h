//
//  AA_BaseMode.h
//  ArtGoer
//
//  Created by dllo on 16/2/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AA_BaseMode : NSObject

@property (nonatomic, copy) NSString *id_AA;

- (instancetype)initWithDic:(NSMutableDictionary *)dic;

+ (instancetype)modelWithDic:(NSMutableDictionary *)dic;

@end

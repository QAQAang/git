//
//  AA_opusWorkModel.m
//  ArtGoer
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_opusWorkModel.h"

@implementation AA_opusWorkModel

+ (NSMutableArray *)getModel:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        AA_opusWorkModel *model = [AA_opusWorkModel modelWithDic:dic];
        [array addObject:model];
    }
    return array;
}

@end

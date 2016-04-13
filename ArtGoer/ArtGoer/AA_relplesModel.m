//
//  AA_relplesModel.m
//  ArtGoer
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_relplesModel.h"

@implementation AA_relplesModel

+ (NSMutableArray *)getModel:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        AA_relplesModel *model = [AA_relplesModel modelWithDic:dic];
        [array addObject:model];
    }
    return array;
}

@end

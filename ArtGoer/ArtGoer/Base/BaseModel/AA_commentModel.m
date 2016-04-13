//
//  AA_commentModel.m
//  ArtGoer
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_commentModel.h"

@implementation AA_commentModel

+ (NSMutableArray *)getModel:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        AA_commentModel *model = [AA_commentModel modelWithDic:dic];
        [array addObject:model];
    }
    return array;
}

@end

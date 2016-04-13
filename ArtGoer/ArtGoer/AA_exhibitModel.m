//
//  AA_exhibitModel.m
//  ArtGoer
//
//  Created by dllo on 16/3/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_exhibitModel.h"

@implementation AA_exhibitModel

+ (NSMutableArray *)getModel:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        AA_exhibitModel *model = [AA_exhibitModel modelWithDic:dic];
        [array addObject:model];
    }
    return array;
}

@end

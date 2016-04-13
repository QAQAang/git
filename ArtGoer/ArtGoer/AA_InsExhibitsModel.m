//
//  AA_InsExhibitsModel.m
//  ArtGoer
//
//  Created by dllo on 16/3/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_InsExhibitsModel.h"

@implementation AA_InsExhibitsModel

+ (NSMutableArray *)getModel:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        AA_InsExhibitsModel *model = [AA_InsExhibitsModel modelWithDic:dic];
        [array addObject:model];
    }
    return array;
}

@end

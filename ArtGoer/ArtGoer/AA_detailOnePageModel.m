//
//  AA_detailOnePageModel.m
//  ArtGoer
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_detailOnePageModel.h"

@implementation AA_detailOnePageModel

+ (NSMutableArray *)getPageModel:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        AA_detailOnePageModel *model = [AA_detailOnePageModel modelWithDic:dic];
        [array addObject:model];
    }
    return array;
}

@end

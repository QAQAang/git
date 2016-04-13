//
//  AA_authorModel.m
//  ArtGoer
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_authorModel.h"
#import "AA_detailOnePageModel.h"
@implementation AA_authorModel

+ (NSMutableArray *)getAllArtModel:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        AA_authorModel *model = [AA_authorModel modelWithDic:dic];
        [array addObject:model];
    }
    return array;
}

+ (NSMutableArray *)getRecommendArtModel:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        AA_authorModel *model = [AA_authorModel modelWithDic:dic];
        model.exhibitWorkVos = [AA_detailOnePageModel getPageModel:[dic valueForKey:@"exhibitWorkVos"]];
        [array addObject:model];
    }
    return array;
}

@end

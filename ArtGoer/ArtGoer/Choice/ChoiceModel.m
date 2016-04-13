//
//  ChoiceModel.m
//  ArtGoer
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ChoiceModel.h"

@implementation ChoiceModel

static NSString *date;

+ (NSMutableArray *)getModel:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        ChoiceModel *model = [ChoiceModel modelWithDic:dic];
        if (![date isEqualToString:[model.publishAt substringToIndex:10]]) {
            date = [model.publishAt substringToIndex:10];
            [array addObject:date];
        }
        [array addObject:model];
    }
    return array;
}

+ (NSMutableArray *)getRecommendModel:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        ChoiceModel *model = [ChoiceModel modelWithDic:dic];
        [array addObject:model];
    }
    return array;
}

@end

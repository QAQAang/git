//
//  AA_DetailToinstitutionModel.m
//  ArtGoer
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_DetailToinstitutionModel.h"
#import "AA_InsExhibitsModel.h"
@implementation AA_DetailToinstitutionModel

+ (NSMutableArray *)getAllGalleryModel:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        AA_DetailToinstitutionModel *model = [AA_DetailToinstitutionModel modelWithDic:dic];
        [array addObject:model];
    }
    return array;
}

+ (NSMutableArray *)getRecommendGalleryModel:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        AA_DetailToinstitutionModel *model = [AA_DetailToinstitutionModel modelWithDic:dic];
       model.exhibits = [AA_InsExhibitsModel getModel:[dic valueForKey:@"exhibits"]];
        [array addObject:model];
    }
    return array;
}

@end

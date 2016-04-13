//
//  AA_detailPagesModel.m
//  ArtGoer
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_detailPagesModel.h"

@implementation AA_detailPagesModel
+ (AA_detailPagesModel *)getDetailModel:(NSMutableDictionary *)dataDic{
        AA_detailPagesModel *model = [AA_detailPagesModel modelWithDic:dataDic];
        AA_DetailToinstitutionModel *institution = [AA_DetailToinstitutionModel modelWithDic:[dataDic valueForKey:@"gallery"]];
        model.gallery = institution;
        model.works = [AA_detailOnePageModel getPageModel:[dataDic valueForKey:@"works"]];

    return model;
}

+ (NSMutableArray *)getModels:(NSMutableArray *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in dataArr) {
        AA_detailPagesModel *model = [AA_detailPagesModel modelWithDic:dic];
        [array addObject:model];
    }
    return array;
}

@end

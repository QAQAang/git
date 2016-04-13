//
//  AA_DetailToinstitutionModel.h
//  ArtGoer
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_BaseMode.h"

@interface AA_DetailToinstitutionModel : AA_BaseMode

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *attention;
@property (nonatomic, copy) NSString *attentionTimes;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, copy) NSString *employeeId;
@property (nonatomic, copy) NSString *exhibitNum;
@property (nonatomic, copy) NSString *galleryDesc;
@property (nonatomic, copy) NSString *galleryName;
@property (nonatomic, copy) NSString *galleryPic;
@property (nonatomic, copy) NSString *isRecommend;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *telNo;
@property (nonatomic, copy) NSString *updateAt;
@property (nonatomic, copy) NSString *workNum;
@property (nonatomic, retain) NSMutableArray *exhibits;

+ (NSMutableArray *)getAllGalleryModel:(NSMutableArray *)dataArr;

+ (NSMutableArray *)getRecommendGalleryModel:(NSMutableArray *)dataArr;

@end

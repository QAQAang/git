//
//  AA_exhibitModel.h
//  ArtGoer
//
//  Created by dllo on 16/3/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_BaseMode.h"

@interface AA_exhibitModel : AA_BaseMode

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *exhibitCity;
@property (nonatomic, copy) NSString *exhibitEndDate;
@property (nonatomic, copy) NSString *exhibitStartDate;
@property (nonatomic, copy) NSString *galleryId;
@property (nonatomic, copy) NSString *galleryName;
@property (nonatomic, copy) NSString *goodTimes;
@property (nonatomic, copy) NSString *headPic;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *workSrc;
@property (nonatomic, copy) NSString *worksHeight;
@property (nonatomic, copy) NSString *worksId;
@property (nonatomic, copy) NSString *worksName;
@property (nonatomic, copy) NSString *worksPic;
@property (nonatomic, copy) NSString *worksWidth;
@property (nonatomic,copy) NSString *totalViewNums;

+ (NSMutableArray *)getModel:(NSMutableArray *)dataArr;

@end

//
//  AA_detailPagesModel.h
//  ArtGoer
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_BaseMode.h"
#import "AA_DetailToinstitutionModel.h"
#import "AA_detailOnePageModel.h"
@interface AA_detailPagesModel : AA_BaseMode

@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *commentCount;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, copy) NSString *exhibitAddress;
@property (nonatomic, copy) NSString *exhibitCity;
@property (nonatomic, copy) NSString *exhibitDesc;
@property (nonatomic, copy) NSString *exhibitEndDate;
@property (nonatomic, copy) NSString *exhibitNum;
@property (nonatomic, copy) NSString *exhibitPic;
@property (nonatomic, copy) NSString *exhibitStartDate;
@property (nonatomic, retain)  AA_DetailToinstitutionModel *gallery;
@property (nonatomic, copy) NSString *galleryName;
@property (nonatomic, copy) NSString *garreryId;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *shareLink;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *updateAt;
@property (nonatomic, retain) NSMutableArray *works;
@property (nonatomic, copy) NSString *remarks;
@property (nonatomic, copy) NSString *viewerNum;
@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, copy) NSString *isDeleted;

+ (AA_detailPagesModel *)getDetailModel:(NSMutableDictionary *)dataDic;

+ (NSMutableArray *)getModels:(NSMutableArray *)dataArr;

@end

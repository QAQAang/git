//
//  AA_detailOnePageModel.h
//  ArtGoer
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_BaseMode.h"
#import "AA_DetailToinstitutionModel.h"
@interface AA_detailOnePageModel : AA_BaseMode

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *commentCount;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, copy) NSString *exhibitId;
@property (nonatomic, retain) AA_DetailToinstitutionModel *gallery;
@property (nonatomic, copy) NSString *goodTimes;
@property (nonatomic, copy) NSString *praise;
@property (nonatomic, copy) NSString *praiseCount;
@property (nonatomic, retain) NSMutableArray *praiseUsers;
@property (nonatomic, copy) NSString *shareLink;
@property (nonatomic, copy) NSString *shareNum;
@property (nonatomic, copy) NSString *updateAt;
@property (nonatomic, copy) NSString *viewerNum;
@property (nonatomic, copy) NSString *workName;
@property (nonatomic, copy) NSString *workSrc;
@property (nonatomic, copy) NSString *worksDesc;
@property (nonatomic, copy) NSString *worksHeight;
@property (nonatomic, copy) NSString *worksMaterial;
@property (nonatomic, copy) NSString *worksPic;
@property (nonatomic, copy) NSString *worksSize;
@property (nonatomic, copy) NSString *worksWidth;
@property (nonatomic, copy) NSString *worksYears;
@property (nonatomic, copy) NSString *exhibitName;
+ (NSMutableArray *)getPageModel:(NSMutableArray *)dataArr;

@end

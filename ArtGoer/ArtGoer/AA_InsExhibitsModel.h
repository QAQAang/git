//
//  AA_InsExhibitsModel.h
//  ArtGoer
//
//  Created by dllo on 16/3/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_BaseMode.h"

@interface AA_InsExhibitsModel : AA_BaseMode

@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, copy) NSString *exhibitAddress;
@property (nonatomic, copy) NSString *exhibitCity;
@property (nonatomic, copy) NSString *exhibitDesc;
@property (nonatomic, copy) NSString *exhibitEndDate;
@property (nonatomic, copy) NSString *exhibitNum;
@property (nonatomic, copy) NSString *exhibitPic;
@property (nonatomic, copy) NSString *exhibitStartDate;
@property (nonatomic, copy) NSString *galleryName;
@property (nonatomic, copy) NSString *garreryId;
@property (nonatomic, copy) NSString *isDeleted;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *remarks;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *updateAt;
@property (nonatomic, copy) NSString *viewerNum;

+ (NSMutableArray *)getModel:(NSMutableArray *)dataArr;

@end

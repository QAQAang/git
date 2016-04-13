//
//  AA_authorModel.h
//  ArtGoer
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_BaseMode.h"

@interface AA_authorModel : AA_BaseMode

@property (nonatomic, copy) NSString *clientType;
@property (nonatomic, copy) NSString *commentNum;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, retain) NSMutableArray *exhibitWorkVos;
@property (nonatomic, copy) NSString *fansNum;
@property (nonatomic, copy) NSString *headPic;
@property (nonatomic, copy) NSString *isPush;
@property (nonatomic, copy) NSString *likeNum;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *thirdId;
@property (nonatomic, copy) NSString *thirdType;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *updateAt;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *verifyStatus;
@property (nonatomic, copy) NSString *viewerNum;
@property (nonatomic, copy) NSString *watch;
@property (nonatomic, copy) NSString *watchNum;
@property (nonatomic, copy) NSString *worksNum;
@property (nonatomic, copy) NSString *selfDesc;
@property (nonatomic, copy) NSString *mobileNo;
@property (nonatomic, copy) NSString *password;



+ (NSMutableArray *)getAllArtModel:(NSMutableArray *)dataArr;

+ (NSMutableArray *)getRecommendArtModel:(NSMutableArray *)dataArr;

@end

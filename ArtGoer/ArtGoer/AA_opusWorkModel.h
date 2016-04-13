//
//  AA_opusWorkModel.h
//  ArtGoer
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_BaseMode.h"

@interface AA_opusWorkModel : AA_BaseMode

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *commentCount;
@property (nonatomic, copy) NSString *exhibitId;
@property (nonatomic, copy) NSString *goodTimes;
@property (nonatomic, copy) NSString *praise;
@property (nonatomic, copy) NSString *praiseCount;
@property (nonatomic, copy) NSString *shareNum;
@property (nonatomic, copy) NSString *updateAt;
@property (nonatomic, copy) NSString *viewerNum;
@property (nonatomic, copy) NSString *workName;
@property (nonatomic, copy) NSString *worksHeight;
@property (nonatomic, copy) NSString *worksPic;
@property (nonatomic, copy) NSString *worksWidth;

+ (NSMutableArray *)getModel:(NSMutableArray *)dataArr;

@end

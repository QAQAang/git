//
//  AA_commentModel.h
//  ArtGoer
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_BaseMode.h"

@interface AA_commentModel : AA_BaseMode

@property (nonatomic, copy) NSString *commentTxt;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, copy) NSString *goodTimes;
@property (nonatomic, copy) NSString *parentCommentId;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *praise;
@property (nonatomic, retain) NSMutableArray *replies;
@property (nonatomic, copy) NSString *replyNum;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userPic;
@property (nonatomic, copy) NSString *verifyStatus;
@property (nonatomic, copy) NSString *workId;

+ (NSMutableArray *)getModel:(NSMutableArray *)dataArr;

@end

//
//  AA_relplesModel.h
//  ArtGoer
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_BaseMode.h"

@interface AA_relplesModel : AA_BaseMode

@property (nonatomic, copy) NSString *commentId;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, copy) NSString *replyText;
@property (nonatomic, copy) NSString *replyUserId;
@property (nonatomic, copy) NSString *replyUserName;
@property (nonatomic, copy) NSString *replyUserPic;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userPic;

+ (NSMutableArray *)getModel:(NSMutableArray *)dataArr;

@end

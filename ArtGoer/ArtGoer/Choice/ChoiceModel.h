//
//  ChoiceModel.h
//  ArtGoer
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_BaseMode.h"

@interface ChoiceModel : AA_BaseMode

@property (nonatomic, copy) NSString *businessId;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, copy) NSString *curiosityPicUrl;
@property (nonatomic, copy) NSString *isEnterfor;
@property (nonatomic, copy) NSString *joinNums;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *marketingDesc;
@property (nonatomic, copy) NSString *publishAt;
@property (nonatomic, copy) NSString *topicDesc;
@property (nonatomic, copy) NSString *topicLabel;
@property (nonatomic, copy) NSString *topicName;
@property (nonatomic, copy) NSString *topicPic;
@property (nonatomic, copy) NSString *topicType;
@property (nonatomic, copy) NSString *updateAt;
@property (nonatomic, copy) NSString *viewerNum;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *scourceType;
@property (nonatomic, copy) NSString *showTopicHead;
@property (nonatomic, copy) NSString *topicHeadType;
@property (nonatomic, copy) NSString *topicLabelDefine;
@property (nonatomic, copy) NSString *topicLabelId;
@property (nonatomic, copy) NSString *userId;

+ (NSMutableArray *)getModel:(NSMutableArray *)dataArr;

+ (NSMutableArray *)getRecommendModel:(NSMutableArray *)dataArr;

@end

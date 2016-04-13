//
//  AA_CommentCell.h
//  ArtGoer
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AA_commentModel.h"

@protocol CommentModelDelegate <NSObject>

- (void)clickReply;

@end

@interface AA_CommentCell : UITableViewCell

@property (nonatomic, assign) id<CommentModelDelegate> delegate;

@property (nonatomic, retain) AA_commentModel *model;

@end

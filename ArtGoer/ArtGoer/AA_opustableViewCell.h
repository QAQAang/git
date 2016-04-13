//
//  AA_opustableViewCell.h
//  ArtGoer
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_baseView.h"
#import "AA_commentModel.h"
#import "AA_opusWorkModel.h"
#import "AA_opusCommentView.h"

@protocol opusCellDelegate <NSObject>

- (void)touchCommentView;

@end

@interface AA_opustableViewCell : UITableViewCell

@property (nonatomic, retain) AA_opusWorkModel *workModel;

@property (nonatomic, retain) AA_commentModel *commentModel;

@property (nonatomic, assign) id<opusCellDelegate> delegate;

@property (nonatomic, retain) UILabel *textLabel_goodTime;

@end

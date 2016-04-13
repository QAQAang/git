//
//  AA_opusCommentView.h
//  ArtGoer
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_baseView.h"

@protocol opusCommentDelegate <NSObject>

- (void)touchView;

@end

@interface AA_opusCommentView : AA_baseView

@property (nonatomic, retain) UIImageView *imageView_userPic;

@property (nonatomic, retain) UILabel *textLabel_comment;

@property (nonatomic, assign) id<opusCommentDelegate> delegate;

@end

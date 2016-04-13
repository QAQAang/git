//
//  AA_opusCommentView.m
//  ArtGoer
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_opusCommentView.h"

@implementation AA_opusCommentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageView_userPic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 40, 40)];
    self.imageView_userPic.layer.cornerRadius = 20;
    self.imageView_userPic.clipsToBounds = YES;
    [self addSubview:self.imageView_userPic];
    self.textLabel_comment = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, [UIScreen mainScreen].bounds.size.width - 70, 30)];
    self.textLabel_comment.font = [UIFont systemFontOfSize:13];
    self.textLabel_comment.numberOfLines = 2;
    [self addSubview:self.textLabel_comment];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.delegate touchView];
}

@end

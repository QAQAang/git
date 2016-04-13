//
//  AA_opustableViewCell.m
//  ArtGoer
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_opustableViewCell.h"
#import "UIImageView+WebCache.h"
@interface AA_opustableViewCell ()<opusCommentDelegate>

@property (nonatomic, retain) UIImageView *imageView_worksPic;

@property (nonatomic, retain) UILabel *textLabel_workName;

@property (nonatomic, retain) UILabel *textLabel_author;

@property (nonatomic, retain) UILabel *textLabel_total;

@property (nonatomic, retain) AA_opusCommentView *opusView;

@end

@implementation AA_opustableViewCell

- (void)setWorkModel:(AA_opusWorkModel *)workModel{
    _workModel = workModel;
    CGFloat height;
    if ([self.workModel.worksHeight floatValue] / [self.workModel.worksWidth floatValue] * [UIScreen mainScreen].bounds.size.width > 350) {
        height = 350;
    }else{
        height = [self.workModel.worksHeight floatValue] / [self.workModel.worksWidth floatValue] * [UIScreen mainScreen].bounds.size.width;
    }
    self.imageView_worksPic.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
    [self.imageView_worksPic sd_setImageWithURL:[NSURL URLWithString:workModel.worksPic] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    self.textLabel_workName.text = workModel.workName;
    self.textLabel_workName.frame =CGRectMake(10, height + 10, 300, 20);
    self.textLabel_author.text = workModel.author;
    self.textLabel_author.frame = CGRectMake(10, height + 35, 100, 15);
    self.textLabel_total.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 110, height + 35, 100, 15);
    self.textLabel_total.text = [NSString stringWithFormat:@"浏览:%@", workModel.viewerNum];
    self.opusView.frame = CGRectMake(10, height + 60, [UIScreen mainScreen].bounds.size.width - 20, 50);
    self.textLabel_goodTime.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 185, height + 120, 175, 15);
}

- (void)setCommentModel:(AA_commentModel *)commentModel{
    _commentModel = commentModel;
    [self.opusView.imageView_userPic sd_setImageWithURL:[NSURL URLWithString:commentModel.userPic] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    self.opusView.textLabel_comment.text = commentModel.commentTxt;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    NSLog(@"%lf~~~~%lf", [self.workModel.worksHeight floatValue], [self.workModel.worksWidth floatValue]);
    self.imageView_worksPic = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageView_worksPic];
    self.textLabel_workName = [[UILabel alloc] init];
    self.textLabel_workName.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.textLabel_workName];
    self.textLabel_author = [[UILabel alloc] init];
    self.textLabel_author.font = [UIFont systemFontOfSize:14];
    self.textLabel_author.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.textLabel_author];
    self.textLabel_total = [[UILabel alloc] init];
    self.textLabel_total.textAlignment = NSTextAlignmentRight;
    self.textLabel_total.font = [UIFont systemFontOfSize:14];
    self.textLabel_total.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.textLabel_total];
    self.opusView = [[AA_opusCommentView alloc] init];
    self.opusView.delegate = self;
    [self.contentView addSubview:self.opusView];
    self.textLabel_goodTime = [[UILabel alloc] init];
    self.textLabel_goodTime.textAlignment = NSTextAlignmentRight;
    self.textLabel_goodTime.font = [UIFont systemFontOfSize:14];
    self.textLabel_goodTime.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.textLabel_goodTime];
}

- (void)touchView{
    [self.delegate touchCommentView];
}

@end

//
//  AA_authorAllArtCell.m
//  ArtGoer
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_authorAllArtCell.h"
#import "UIImageView+WebCache.h"
#import "AA_sqliteAuthor.h"
@interface AA_authorAllArtCell ()

@property (nonatomic, retain) UIImageView *imageView_headPic;

@property (nonatomic, retain) UILabel *textLabel_author;

@property (nonatomic, retain) UILabel *textLabel_worksNum;

@end

@implementation AA_authorAllArtCell

- (void)setModel:(AA_authorModel *)model{
    _model = model;
    [self.imageView_headPic sd_setImageWithURL:[NSURL URLWithString:model.headPic] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    self.textLabel_author.text = self.model.userName;
    self.textLabel_worksNum.text = [NSString stringWithFormat:@"作品:%@   粉丝:%@", self.model.worksNum, self.model.fansNum];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageView_headPic = [[UIImageView alloc] init];
    self.imageView_headPic.layer.cornerRadius = 25;
    self.imageView_headPic.clipsToBounds = YES;
    [self.contentView addSubview:self.imageView_headPic];
    self.textLabel_author = [[UILabel alloc] init];
    self.textLabel_author.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.textLabel_author];
    self.textLabel_worksNum = [[UILabel alloc] init];
    self.textLabel_worksNum.font = [UIFont systemFontOfSize:14];
    self.textLabel_worksNum.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.textLabel_worksNum];
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addButton setTintColor:[UIColor blackColor]];
    [self.addButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.addButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView_headPic.frame = CGRectMake(10 * AWIDTH, 5, 50 * AWIDTH, 50);
    self.textLabel_author.frame = CGRectMake(65 * AWIDTH, 10, 100 * AWIDTH, 20);
    self.textLabel_worksNum.frame = CGRectMake(65 * AWIDTH, 35, 200 * AWIDTH, 15);
    self.addButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40 * AWIDTH, 25, 30 * AWIDTH, 30);
    
}

- (void)click{
    if ([AA_sqliteAuthor selectUserByTitle:self.model.userName].count == 0) {
        [AA_sqliteAuthor insertUserWithTitle:self.model.userName PicUrl:self.model.headPic Url:self.model.id_AA];
        [self.addButton setImage:[UIImage imageNamed:@"iconfont-jiantou"] forState:UIControlStateNormal];
    }else{
        [self.delegate clickButtonId:self.model.id_AA];
    }
}

@end

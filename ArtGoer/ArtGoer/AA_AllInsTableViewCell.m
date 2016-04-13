//
//  AA_AllInsTableViewCell.m
//  ArtGoer
//
//  Created by dllo on 16/3/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_AllInsTableViewCell.h"
#import "AA_InsExhibitsModel.h"
#import "UIImageView+WebCache.h"
#import "AA_sqliteIns.h"
@interface AA_AllInsTableViewCell ()

@property (nonatomic, retain) UIImageView *imageView_headPic;

@property (nonatomic, retain) UILabel *textLabel_author;

@property (nonatomic, retain) UILabel *textLabel_worksNum;

@end

@implementation AA_AllInsTableViewCell

- (void)setModel:(AA_DetailToinstitutionModel *)model{
    _model = model;
    [self.imageView_headPic sd_setImageWithURL:[NSURL URLWithString:model.galleryPic] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    self.textLabel_author.text = self.model.galleryName;
    self.textLabel_worksNum.text = [NSString stringWithFormat:@"展览:%@   作品:%@   城市:%@", self.model.exhibitNum, self.model.workNum, self.model.cityName];
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
    self.addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.addButton setTintColor:[UIColor blackColor]];
    [self.addButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.addButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView_headPic.frame = CGRectMake(10, 5, 50, 50);
    self.textLabel_author.frame = CGRectMake(65, 10, 100, 20);
    self.textLabel_worksNum.frame = CGRectMake(65, 35, 300, 15);
    self.addButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 25, 30, 30);
    
}

- (void)click{
    if ([AA_sqliteIns selectUserByTitle:self.model.galleryName].count == 0) {
        [AA_sqliteIns insertUserWithTitle:self.model.galleryName PicUrl:self.model.galleryPic Url:self.model.id_AA];
        [self.addButton setImage:[UIImage imageNamed:@"iconfont-jiantou"] forState:UIControlStateNormal];
    }else{
        [self.delegate clickButtonId:self.model.id_AA];
    }
}

@end

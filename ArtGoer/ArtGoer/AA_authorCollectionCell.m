//
//  AA_authorCollectionCell.m
//  ArtGoer
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_authorCollectionCell.h"
#import "UIImageView+WebCache.h"
@interface AA_authorCollectionCell ()

@property (nonatomic, retain) UIImageView *imageView;

@property (nonatomic, retain) UILabel *textlabel_viewer;

@end

@implementation AA_authorCollectionCell

- (void)setModel:(AA_detailOnePageModel *)model{
    _model = model;
    self.imageView.frame = CGRectMake(0, 0, 250 * AWIDTH, 250 * AHEIGHT / [self.model.worksWidth floatValue] * [self.model.worksHeight floatValue]);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.worksPic] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    self.textlabel_viewer.frame = CGRectMake(0, 250 * AHEIGHT / [self.model.worksWidth floatValue] * [self.model.worksHeight floatValue] + 10, 250 * AWIDTH, 50 * AHEIGHT);
    self.textlabel_viewer.text = [NSString stringWithFormat:@"%@\n浏览:%@", self.model.workName, self.model.viewerNum];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageView];
    self.textlabel_viewer = [[UILabel alloc] init];
    self.textlabel_viewer.font = [UIFont systemFontOfSize:15];
    self.textlabel_viewer.textAlignment = 1;
    self.textlabel_viewer.numberOfLines = 2;
    self.textlabel_viewer.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.textlabel_viewer];
}

@end

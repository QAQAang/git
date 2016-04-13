//
//  AA_recommendCell.m
//  ArtGoer
//
//  Created by dllo on 16/3/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_recommendCell.h"
#import "UIImageView+WebCache.h"
@interface AA_recommendCell ()

@property (nonatomic, retain) UIImageView *imageView_topicPic;

@property (nonatomic, retain) UILabel *textLabel_topicName;

@end

@implementation AA_recommendCell

- (void)setModel:(ChoiceModel *)model{
    _model = model;
//    NSLog(@"123123%@", model.topicPic);
    [self.imageView_topicPic sd_setImageWithURL:[NSURL URLWithString:model.topicPic]];
    self.textLabel_topicName.text = model.topicName;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageView_topicPic = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageView_topicPic];
    self.textLabel_topicName = [[UILabel alloc] init];
    self.textLabel_topicName.font = [UIFont systemFontOfSize:16];
    self.textLabel_topicName.numberOfLines = 0;
    [self.contentView addSubview:self.textLabel_topicName];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView_topicPic.frame = CGRectMake(10, 10, ([UIScreen mainScreen].bounds.size.width - 30) / 3, 100);
    self.textLabel_topicName.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 30) / 3 + 20, 10, ([UIScreen mainScreen].bounds.size.width - 30) / 3 * 2, 100);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

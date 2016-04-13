//
//  ChoiceTbViewCell.m
//  ArtGoer
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ChoiceTbViewCell.h"
#import "ChoiceModel.h"
#import "UIImageView+WebCache.h"
@interface ChoiceTbViewCell ()

@property (nonatomic, retain) UIImageView *imageView_choice;

@property (nonatomic, retain) UILabel *textLabel_name;

@property (nonatomic, retain) UILabel *textLabel_viewer;

@end

@implementation ChoiceTbViewCell

- (void)setModel:(ChoiceModel *)model{
    _model = model;
    self.textLabel_name.text = model.topicName;
    self.textLabel_name.textColor = [UIColor whiteColor];
    self.textLabel_viewer.text = [NSString stringWithFormat:@"%@  |  %@浏览", model.topicLabel, model.viewerNum];
    self.textLabel_viewer.textColor = [UIColor whiteColor];
    [self.imageView_choice sd_setImageWithURL:[NSURL URLWithString:model.curiosityPicUrl]];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageView_choice = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageView_choice];
    self.textLabel_name = [[UILabel alloc] init];
    self.textLabel_name.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    self.textLabel_name.textAlignment = 1;
    [self.contentView addSubview:self.textLabel_name];
    self.textLabel_viewer = [[UILabel alloc] init];
    self.textLabel_viewer.font = [UIFont systemFontOfSize:13];
    self.textLabel_viewer.textAlignment = 1;
    [self.contentView addSubview:self.textLabel_viewer];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView_choice.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250 * AHEIGHT);
    self.textLabel_name.frame = CGRectMake(0, 95 * AHEIGHT, [UIScreen mainScreen].bounds.size.width, 30 * AHEIGHT);
    self.textLabel_viewer.frame = CGRectMake(0, 135 * AHEIGHT, [UIScreen mainScreen].bounds.size.width, 20 * AHEIGHT);
}

- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

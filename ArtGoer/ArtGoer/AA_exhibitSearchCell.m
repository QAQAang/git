//
//  AA_exhibitSearchCell.m
//  ArtGoer
//
//  Created by dllo on 16/3/10.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_exhibitSearchCell.h"
#import "UIImageView+WebCache.h"
@interface AA_exhibitSearchCell ()

@property (nonatomic, retain) UIImageView *imageView_exhibitPic;

@property (nonatomic, retain) UILabel *textLabel_name;

@property (nonatomic, retain) UILabel *textLabel_exhibitCity;

@property (nonatomic, retain) UILabel *textLabel_time;

@end

@implementation AA_exhibitSearchCell

- (void)setModel:(AA_detailPagesModel *)model{
    _model = model;
    [self.imageView_exhibitPic sd_setImageWithURL:[NSURL URLWithString:model.exhibitPic] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    self.textLabel_name.text = model.name;
    self.textLabel_exhibitCity.text = [NSString stringWithFormat:@"%@|%@", model.exhibitCity, model.galleryName];
    self.textLabel_time.text = [NSString stringWithFormat:@"%@%@|%@件",[model.exhibitStartDate substringWithRange:NSMakeRange(0, 9)], [model.exhibitEndDate substringWithRange:NSMakeRange(4, 6)], model.exhibitNum];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageView_exhibitPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    [self.contentView addSubview:self.imageView_exhibitPic];
    self.textLabel_name = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, [UIScreen mainScreen].bounds.size.width - 100, 40)];
    self.textLabel_name.numberOfLines = 2;
    [self.contentView addSubview:self.textLabel_name];
    self.textLabel_exhibitCity = [[UILabel alloc] initWithFrame:CGRectMake(100, 55, 150, 15)];
    self.textLabel_exhibitCity.font = [UIFont systemFontOfSize:14];
    self.textLabel_exhibitCity.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.textLabel_exhibitCity];
    self.textLabel_time = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, 150, 15)];
    self.textLabel_time.font = [UIFont systemFontOfSize:14];
    self.textLabel_time.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.textLabel_time];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 99, [UIScreen mainScreen].bounds.size.width, 1)];
    line.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:line];
}

@end

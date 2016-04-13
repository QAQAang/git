//
//  AA_InsSpaceCell.m
//  ArtGoer
//
//  Created by dllo on 16/3/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_InsSpaceCell.h"
#import "UIImageView+WebCache.h"
@interface AA_InsSpaceCell ()

@property (nonatomic, retain) UIImageView *imageView_exhibitPic;

@property (nonatomic, retain) UILabel *textLabel_name;

@property (nonatomic, retain) UILabel *textLabel_city;

@end

@implementation AA_InsSpaceCell

- (void)setModel:(AA_InsExhibitsModel *)model{
    _model = model;
    [self.imageView_exhibitPic sd_setImageWithURL:[NSURL URLWithString:model.exhibitPic] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    self.textLabel_name.text = model.name;
    self.textLabel_city.text = [NSString stringWithFormat:@"%@|%@%@|%@件", model.exhibitCity, [model.exhibitStartDate substringWithRange:NSMakeRange(0, 9)], [model.exhibitEndDate substringWithRange:NSMakeRange(4, 6)], model.exhibitNum];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageView_exhibitPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 225)];
    [self.contentView addSubview:self.imageView_exhibitPic];
    self.textLabel_name = [[UILabel alloc] initWithFrame:CGRectMake(10, 235, [UIScreen mainScreen].bounds.size.width, 40)];
    self.textLabel_name.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:self.textLabel_name];
    self.textLabel_city = [[UILabel alloc] initWithFrame:CGRectMake(10, 280, 200, 15)];
    self.textLabel_city.font = [UIFont systemFontOfSize:14];
    self.textLabel_city.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.textLabel_city];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 299, [UIScreen mainScreen].bounds.size.width - 20, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
}

@end

//
//  AA_mineExhibitCell.m
//  ArtGoer
//
//  Created by dllo on 16/3/11.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_mineExhibitCell.h"
#import "UIImageView+WebCache.h"
@interface AA_mineExhibitCell ()

@property (nonatomic, retain) UIImageView *imageView_headPic;

@property (nonatomic, retain) UILabel *textLabel_title;

@end

@implementation AA_mineExhibitCell

- (void)setDicData:(NSMutableDictionary *)dicData{
    _dicData = dicData;
    [self.imageView_headPic sd_setImageWithURL:[NSURL URLWithString:[dicData objectForKey:@"picUrl"]] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    self.textLabel_title.text = [dicData valueForKey:@"title"];
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
    [self.contentView addSubview:self.imageView_headPic];
    self.textLabel_title = [[UILabel alloc] init];
    self.textLabel_title.numberOfLines = 2;
    [self.contentView addSubview:self.textLabel_title];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView_headPic.frame = CGRectMake(10, 5, 80, 80);
    self.textLabel_title.frame = CGRectMake(100, 25, 200, 30);
}

@end

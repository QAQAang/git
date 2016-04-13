//
//  AA_mineAuthorCell.m
//  ArtGoer
//
//  Created by dllo on 16/3/11.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_mineAuthorCell.h"
#import "UIImageView+WebCache.h"
@interface AA_mineAuthorCell ()

@property (nonatomic, retain) UIImageView *imageView_headPic;

@property (nonatomic, retain) UILabel *textLabel_title;

@end

@implementation AA_mineAuthorCell

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
    self.imageView_headPic.layer.cornerRadius = 25;
    self.imageView_headPic.clipsToBounds = YES;
    [self.contentView addSubview:self.imageView_headPic];
    self.textLabel_title = [[UILabel alloc] init];
    [self.contentView addSubview:self.textLabel_title];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView_headPic.frame = CGRectMake(10, 5, 50, 50);
    self.textLabel_title.frame = CGRectMake(70, 15, 150, 20);
}

@end

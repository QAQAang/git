//
//  CollectionViewCell.m
//  WaterLayout
//
//  Created by dllo on 16/4/11.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AuthorLikeCell.h"
#import "UIImageView+WebCache.h"
@interface AuthorLikeCell ()

@property (nonatomic, retain) UIImageView *imageView;

@property (nonatomic, retain) UILabel *textLabel;

@property (nonatomic, retain) UILabel *detextLabel;

@end

@implementation AuthorLikeCell

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    _dataDic = dataDic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataDic[@"worksPic"]] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.textLabel.text = dataDic[@"workName"];
    self.detextLabel.text = dataDic[@"author"];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width - 30) / 2, self.frame.size.height - 60)];
    [self.contentView addSubview:self.imageView];
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 50, ([UIScreen mainScreen].bounds.size.width - 30) / 2, 20)];
    self.textLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.textLabel];
    self.detextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, ([UIScreen mainScreen].bounds.size.width - 30) / 2, 20)];
    self.detextLabel.font = [UIFont systemFontOfSize:15];
    self.detextLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.detextLabel];
}

@end

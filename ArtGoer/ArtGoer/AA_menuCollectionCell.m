//
//  AA_menuCollectionCell.m
//  ArtGoer
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_menuCollectionCell.h"

@implementation AA_menuCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.font = [UIFont systemFontOfSize:16];
        self.textLabel.textAlignment = 1;
        [self.contentView addSubview:self.textLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 4, 40);
}

@end

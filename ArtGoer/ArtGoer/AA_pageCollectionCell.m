//
//  AA_pageCollectionCell.m
//  ArtGoer
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_pageCollectionCell.h"

@implementation AA_pageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.pageView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.contentView addSubview:self.pageView];
    }
    return self;
}

@end

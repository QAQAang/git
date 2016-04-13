//
//  AA_ galleryView.m
//  ArtGoer
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_ galleryView.h"

@implementation AA__galleryView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    UILabel *lineTop = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, [UIScreen mainScreen].bounds.size.width - 10, 1)];
    lineTop.text = @"-------------------------------------------------------------------------------------------";
    lineTop.textColor = [UIColor lightGrayColor];
    lineTop.font = [UIFont systemFontOfSize:14];
    [self addSubview:lineTop];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 100, 80)];
    [self addSubview:self.imageView];
    self.galleryLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 10, 240, 80)];
    [self addSubview:self.galleryLabel];
    self.addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.addButton setTintColor:[UIColor blackColor]];
    [self.addButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    self.addButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 35, 30, 30);
    [self addSubview:self.addButton];
    UILabel *lineBottom = [[UILabel alloc] initWithFrame:CGRectMake(5, 99, [UIScreen mainScreen].bounds.size.width - 10, 1)];
    lineBottom.text = @"-------------------------------------------------------------------------------------------";
    lineBottom.textColor = [UIColor lightGrayColor];
    lineBottom.font = [UIFont systemFontOfSize:14];
    [self addSubview:lineBottom];
}

- (void)clickButton{
    [self.delegate addGallery];
}

@end

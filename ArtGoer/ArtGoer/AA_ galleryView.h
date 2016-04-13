//
//  AA_ galleryView.h
//  ArtGoer
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_baseView.h"

@protocol galleryViewDelegate <NSObject>

- (void)addGallery;

@end

@interface AA__galleryView : AA_baseView

@property (nonatomic, retain) UIImageView *imageView;

@property (nonatomic, retain) UILabel *galleryLabel;

@property (nonatomic, retain) UIButton *addButton;

@property (nonatomic, assign) id<galleryViewDelegate> delegate;

@end

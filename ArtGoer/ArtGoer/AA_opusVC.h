//
//  AA_opusVC.h
//  ArtGoer
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_baseViewController.h"

@protocol opusVCdelegate <NSObject>

- (void)changeOrigin:(CGFloat)y;

- (void)endScroll;

@end

@interface AA_opusVC : AA_baseViewController

@property (nonatomic, assign) id<opusVCdelegate> delegate;

@end

//
//  AA_authorVC.h
//  ArtGoer
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_baseViewController.h"

@protocol authorVCDelegate <NSObject>

- (void)changeOrigin:(CGFloat)y;

- (void)endScroll;

- (void)goInside:(NSInteger)count ExhibitID:(NSString *)exhibitID Models:(NSMutableArray *)array;

@end

@interface AA_authorVC : AA_baseViewController

@property (nonatomic, assign) id<authorVCDelegate> delegate;

@end

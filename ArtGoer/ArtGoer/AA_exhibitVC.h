//
//  AA_exhibitVC.h
//  ArtGoer
//
//  Created by dllo on 16/3/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_baseViewController.h"

@protocol ExhibitVCDelegate <NSObject>

- (void)changeOrigin:(CGFloat)y;

- (void)endScroll;

- (void)nextViewController:(NSString *)exhibitID;

- (void)goInside:(NSInteger)count ExhibitID:(NSString *)exhibitID Models:(NSMutableArray *)array;

@end


@interface AA_exhibitVC : AA_baseViewController

@property (nonatomic, assign) id<ExhibitVCDelegate> delegate;

@end

//
//  AA_InstitutionVC.h
//  ArtGoer
//
//  Created by dllo on 16/3/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_baseViewController.h"

@protocol institutionDelegate <NSObject>

- (void)changeOrigin:(CGFloat)y;

- (void)endScroll;

- (void)institutionTopagesExid:(NSString *)exid;

@end

@interface AA_InstitutionVC : AA_baseViewController

@property (nonatomic, assign) id<institutionDelegate> delegate;

@end

//
//  AA_onePageVC.h
//  ArtGoer
//
//  Created by dllo on 16/3/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_baseViewController.h"
#import "AA_detailOnePageModel.h"

@protocol onePageDelegate <NSObject>

- (void)changeHeadView:(CGPoint)new :(CGPoint)old;

@end

@interface AA_onePageVC : AA_baseViewController

@property (nonatomic, retain) AA_detailOnePageModel *model;

@property (nonatomic, copy) NSString *exhibitID;

@property (nonatomic, assign) id<onePageDelegate> delegate;

@end

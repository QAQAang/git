//
//  AA_searchPageVC.h
//  ArtGoer
//
//  Created by dllo on 16/3/10.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_baseViewController.h"

@interface AA_searchPageVC : AA_baseViewController

@property (nonatomic, assign) BOOL HTTPMethod;

@property (nonatomic, copy) NSString *searchType;

@property (nonatomic, copy) NSString *searchText;

- (void)getTaskData;

@end

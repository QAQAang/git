//
//  AA_authorTableViewCell.h
//  ArtGoer
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AA_authorModel.h"

@protocol authorCellDelegate <NSObject>

- (void)clickItem:(NSInteger)count Exid:(NSString *)exid Models:(NSMutableArray *)models;

- (void)clickButtonId:(NSString *)userID;

@end

@interface AA_authorTableViewCell : UITableViewCell

@property (nonatomic, retain) AA_authorModel *model;

@property (nonatomic, assign) id<authorCellDelegate> delegate;

@property (nonatomic, retain) UIButton *addButton;

@end

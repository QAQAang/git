//
//  AA_authorAllArtCell.h
//  ArtGoer
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AA_authorModel.h"

@protocol allArtCellDelegate <NSObject>

- (void)clickButtonId:(NSString *)userID;

@end

@interface AA_authorAllArtCell : UITableViewCell

@property (nonatomic, retain) AA_authorModel *model;

@property (nonatomic, assign) id<allArtCellDelegate> delegate;

@property (nonatomic, retain) UIButton *addButton;

@end

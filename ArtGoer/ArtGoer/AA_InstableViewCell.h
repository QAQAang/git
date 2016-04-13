//
//  AA_InstableViewCell.h
//  ArtGoer
//
//  Created by dllo on 16/3/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AA_DetailToinstitutionModel.h"

@protocol insCellDelegate <NSObject>

- (void)clickItemExid:(NSString *)exid;

- (void)clickButtonId:(NSString *)Id;

@end

@interface AA_InstableViewCell : UITableViewCell

@property (nonatomic, retain) AA_DetailToinstitutionModel *model;

@property (nonatomic, assign) id<insCellDelegate> delegate;

@property (nonatomic, retain) UIButton *addButton;

@end

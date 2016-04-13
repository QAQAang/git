//
//  ChoiceTbViewCell.h
//  ArtGoer
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoiceModel.h"
@interface ChoiceTbViewCell : UITableViewCell

@property (nonatomic, retain) ChoiceModel *model;

@property (nonatomic, assign) BOOL pickMove;

@end

//
//  AA_exhibitCell.h
//  ArtGoer
//
//  Created by dllo on 16/3/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AA_exhibitModel.h"

@protocol ExhibitCellDelegate <NSObject>

- (void)clickItemCount:(NSInteger)count Exid:(NSString *)exid;

@end

@interface AA_exhibitCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) NSMutableArray *array;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, retain) AA_exhibitModel *model;

@property (nonatomic, retain) UILabel *textLabel_name;

@property (nonatomic, retain) UILabel *textLabel_galleryName_time;

@property (nonatomic, retain) UILabel *textLabel_totalViewNums;

@property (nonatomic, retain) UICollectionView *collections;

@property (nonatomic, assign) id<ExhibitCellDelegate> delegate;

@end

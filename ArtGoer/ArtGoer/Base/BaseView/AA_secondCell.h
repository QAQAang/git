//
//  AA_secondCell.h
//  ArtGoer
//
//  Created by dllo on 16/3/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WebViewControlBlock)(void);
@interface AA_secondCell : UITableViewCell

@property (nonatomic, copy) NSString *webUrl;

@property (nonatomic, copy) WebViewControlBlock block;

@end

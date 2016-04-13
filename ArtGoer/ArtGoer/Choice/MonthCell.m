//
//  MonthCell.m
//  ArtGoer
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MonthCell.h"

@implementation MonthCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatLabel];
    }
    return self;
}

- (void)creatLabel{
    self.textLabel_month = [[UILabel alloc] init];
    self.textLabel_month.textAlignment = 1;
    self.textLabel_month.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    self.textLabel_month.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.textLabel_month];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel_month.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  AA_replesCell.m
//  ArtGoer
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_replesCell.h"
#import "AA_adaptivelyHW.h"
@interface AA_replesCell ()

@property (nonatomic, retain) UILabel *textLabel_relpes;

@end

@implementation AA_replesCell

- (void)setReplesModel:(AA_relplesModel *)replesModel{
    _replesModel = replesModel;
    NSString *str = [NSString stringWithFormat:@"%@回复%@: %@", replesModel.replyUserName, replesModel.userName, replesModel.replyText];
    self.textLabel_relpes.frame = CGRectMake(85, 5, [UIScreen mainScreen].bounds.size.width - 95, [AA_adaptivelyHW getHeight:str :[UIScreen mainScreen].bounds.size.width - 95 :16]);
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:str];
    [astr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:16] range:[str rangeOfString:replesModel.replyUserName]];
    [astr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:16] range:[str rangeOfString:replesModel.userName]];
    self.textLabel_relpes.attributedText = astr;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.textLabel_relpes = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, [UIScreen mainScreen].bounds.size.width - 95, 25)];
    self.textLabel_relpes.font = [UIFont systemFontOfSize:16];
    self.textLabel_relpes.numberOfLines = 0;
    self.textLabel_relpes.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:self.textLabel_relpes];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel_relpes = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, [UIScreen mainScreen].bounds.size.width - 95, 25)];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  AA_CommentCell.m
//  ArtGoer
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_CommentCell.h"
#import "UIImageView+WebCache.h"
#import "AA_adaptivelyHW.h"

@interface AA_CommentCell ()

@property (nonatomic, retain) UILabel *textlabel_userName;

@property (nonatomic, retain) UILabel *textlabel_commentTxt;

@property (nonatomic, retain) UILabel *textlabel_time;

@property (nonatomic, retain) UIImageView *imageView_userPic;

@property (nonatomic, retain) UIButton *button_reply;

@property (nonatomic, retain) UIView *line;

@end

@implementation AA_CommentCell

- (void)setModel:(AA_commentModel *)model{
    _model = model;
    [self.imageView_userPic sd_setImageWithURL:[NSURL URLWithString:model.userPic]];
    self.textlabel_userName.text = model.userName;
    self.textlabel_time.text = [AA_CommentCell compareTime:model.createAt];
    CGRect frame = self.textlabel_commentTxt.frame;
    frame.size.height = [AA_adaptivelyHW getHeight:model.commentTxt :[UIScreen mainScreen].bounds.size.width - 110 :17];
    self.textlabel_commentTxt.frame = frame;
    self.textlabel_commentTxt.text = model.commentTxt;
    frame = self.button_reply.frame;
    frame.origin.y = [AA_adaptivelyHW getHeight:model.commentTxt :[UIScreen mainScreen].bounds.size.width - 110 :17] + 65;
    self.button_reply.frame = frame;
    [self.button_reply setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.button_reply setTitle:[NSString stringWithFormat:@"赞 %@   评论 %@", model.goodTimes, model.replyNum] forState:UIControlStateNormal];
    frame = self.line.frame;
    frame.origin.y = [AA_adaptivelyHW getHeight:model.commentTxt :[UIScreen mainScreen].bounds.size.width - 110 :17] + 89;
    self.line.frame = frame;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifierA{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifierA];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageView_userPic = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    self.imageView_userPic.layer.cornerRadius = self.imageView_userPic.frame.size.width / 2;
    // 将多余的部分剪切掉
    self.imageView_userPic.clipsToBounds = YES;
    [self.contentView addSubview:self.imageView_userPic];
    self.textlabel_userName = [[UILabel alloc] initWithFrame:CGRectMake(85, 20, 200, 25)];
    self.textlabel_userName.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [self.contentView addSubview:self.textlabel_userName];
    self.textlabel_time = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 20, 90, 25)];
    self.textlabel_time.font = [UIFont systemFontOfSize:17];
    self.textlabel_time.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.textlabel_time];
    self.textlabel_commentTxt = [[UILabel alloc] initWithFrame:CGRectMake(85, 50, [UIScreen mainScreen].bounds.size.width - 110, 25)];
    self.textlabel_commentTxt.textColor = [UIColor darkGrayColor];
    self.textlabel_commentTxt.numberOfLines = 0;
    self.textlabel_commentTxt.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.textlabel_commentTxt];
    self.button_reply = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button_reply.frame = CGRectMake(85, 80, 100, 15);
    [self.button_reply addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    self.button_reply.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.button_reply setTitle:@"123" forState:UIControlStateNormal];
    [self.contentView addSubview:self.button_reply];
    self.line = [[UIView alloc] initWithFrame:CGRectMake(20, 109, [UIScreen mainScreen].bounds.size.width - 40, 1)];
    self.line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.line];
}



- (void)click{
    [self.delegate clickReply];
}

+ (NSString *)compareTime:(NSString *)creatTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *creatData = [dateFormatter dateFromString:creatTime];
    NSTimeInterval time = [date timeIntervalSinceDate:creatData];
//    int hours = ((int)time)%(3600*24)/3600;
    int hours = ((int)time)/3600;
    NSString *currentTime = [dateFormatter stringFromDate:date];
    NSInteger currentDay = [[currentTime substringWithRange:NSMakeRange(8, 2)] integerValue];
    NSInteger creatDay = [[creatTime substringWithRange:NSMakeRange(8, 2)] integerValue];
    NSInteger currentHour = [[currentTime substringWithRange:NSMakeRange(11, 2)] integerValue];
    NSInteger creatHour = [[creatTime substringWithRange:NSMakeRange(11, 2)] integerValue];
        if (currentDay == creatDay) {
            if (creatHour != currentHour) {
                return [NSString stringWithFormat:@"%ld小时前", currentHour - creatHour];
            }else{
                return @"1小时以内";
            }
        }else{
            if (hours >= currentHour) {
                return @"昨天";
            }else if (hours / 24 + currentHour == 1){
                return @"前天";
            }else{
                return [NSString stringWithFormat:@"%@月%@日", [creatTime substringWithRange:NSMakeRange(5, 2) ], [creatTime substringWithRange:NSMakeRange(8, 2)]];
            }
        }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  AA_secondCell.m
//  ArtGoer
//
//  Created by dllo on 16/3/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_secondCell.h"

@interface AA_secondCell ()<UIScrollViewDelegate, UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation AA_secondCell

- (void)setWebUrl:(NSString *)webUrl {
    _webUrl = webUrl;
    [_webView sizeToFit];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]];
    self.webView.delegate = self;
    _webView.scrollView.scrollEnabled = NO;
    [self.webView loadRequest:request];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.webView = [[UIWebView alloc] init];
        self.webView.delegate = self;
        self.webView.scrollView.delegate = self;
        self.webView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.webView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.webView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

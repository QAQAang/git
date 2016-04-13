//
//  AA_secondViewController.h
//  ArtGoer
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_baseViewController.h"
#import <WebKit/WebKit.h>
#import "ChoiceModel.h"
@interface AA_secondViewController : AA_baseViewController

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *commentUrl;

@property (nonatomic, retain) WKWebView *webView;

@property (nonatomic, retain) ChoiceModel *model;

@end

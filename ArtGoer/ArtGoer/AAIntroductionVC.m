//
//  AAIntroductionVC.m
//  ArtGoer
//
//  Created by dllo on 16/4/11.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AAIntroductionVC.h"
@interface AAIntroductionVC ()

@property (nonatomic, retain) UIView *headView;

@property (nonatomic, retain) UILabel *label;

@end

@implementation AAIntroductionVC

- (void)setIntroduction:(NSString *)introduction{
    _introduction = introduction;
    if (introduction == nil || [introduction  isEqual: @""]) {
        _introduction = @"这是一位神秘的艺术家";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(80, 75, [UIScreen mainScreen].bounds.size.width - 100, 30)];
    self.label.numberOfLines = 0;
    self.label.font = [UIFont systemFontOfSize:15];
    self.label.text = self.introduction;
    [self.label sizeToFit];
    [self.view addSubview:self.label];
    [self creatHeadView];
}

- (void)creatHeadView{
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 50)];
    self.headView.backgroundColor = [UIColor whiteColor];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle: @"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(5, 10, 40, 30);
    backButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:backButton];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 25, 10, 50, 30)];
    title.text = @"简介";
    title.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:title];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.headView addSubview:line1];
    [self.view addSubview:self.headView];
}

- (void)clickBack{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

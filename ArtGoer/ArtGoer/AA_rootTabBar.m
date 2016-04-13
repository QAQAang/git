//
//  AA_rootTabBar.m
//  ArtGoer
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_rootTabBar.h"
#import "AA_choiceVC.h"
#import "AA_findViewController.h"
#import "AA_exhibitVC.h"
#import "AA_MineVC.h"
@interface AA_rootTabBar ()

@end

@implementation AA_rootTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addVC];
}

- (void)addVC{
//    self.tabBar.translucent = NO;
    AA_choiceVC *choice = [[AA_choiceVC alloc] init];
    choice.title = @"精选";
    [self addChildViewController:choice];
    AA_findViewController *find = [[AA_findViewController alloc] init];
    find.title = @"展览";
    [self addChildViewController:find];
    AA_MineVC *mine = [[AA_MineVC alloc] init];
    mine.title = @"我的";
    [self addChildViewController:mine];
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

//
//  AA_replesVC.m
//  ArtGoer
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_replesVC.h"
#import "AA_replesCell.h"
#import "AA_relplesModel.h"
#import "AA_adaptivelyHW.h"
#import "UIImageView+WebCache.h"
@interface AA_replesVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) UIView *viewNav;

@property (nonatomic, retain) NSMutableArray *arrayReples;

@end

@implementation AA_replesVC

- (NSMutableArray *)arrayReples{
    if (_arrayReples == nil) {
        _arrayReples = [NSMutableArray array];
        _arrayReples = [AA_relplesModel getModel:self.array];
    }
    return _arrayReples;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatnaV];
    [self creatTableV];
}

- (void)creatnaV{
    self.viewNav = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 40)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.frame = CGRectMake(5, 5, 40, 30);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
    self.viewNav.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39, [UIScreen mainScreen].bounds.size.width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 30)];
    label.text = @"回复";
    label.textAlignment = 1;
    [self.viewNav addSubview:label];
    [self.viewNav addSubview:line];
    [self.viewNav addSubview:button];
    [self.view addSubview:self.viewNav];
}

- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 60) style:0];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = NO;
//    self.tableV.tableHeaderView = self.headView;
//    self.tableV.tableHeaderView.backgroundColor = [UIColor clearColor];
//    self.tableV.tableHeaderView.frame = self.headView.frame;
    [self.tableV registerClass:[AA_replesCell class] forCellReuseIdentifier:@"reples"];
    [self.view addSubview:self.tableV];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
    return self.arrayReples.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:nil];
        [cell.contentView addSubview:self.headView];
        return cell;
    }
    AA_replesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reples"];
    cell.replesModel = self.arrayReples[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.headHeight;
    }else{
    AA_relplesModel *replesModel = self.arrayReples[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%@回复%@: %@", replesModel.replyUserName, replesModel.userName, replesModel.replyText];
    return [AA_adaptivelyHW getHeight:str :[UIScreen mainScreen].bounds.size.width - 95 :16] + 5;
    }
}

- (void)turnBack{
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

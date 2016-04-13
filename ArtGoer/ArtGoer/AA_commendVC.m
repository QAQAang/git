//
//  AA_commendVC.m
//  ArtGoer
//
//  Created by dllo on 16/3/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_commendVC.h"
#import "AA_CommentCell.h"
#import "AA_adaptivelyHW.h"
@interface AA_commendVC ()<UITableViewDataSource, UITableViewDelegate, CommentModelDelegate>

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) NSMutableArray *array;

@property (nonatomic, retain) UIView *viewWin;

@end

@implementation AA_commendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableV];
    [self creatWindow];
    [self getTaskData];
}

- (void)getTaskData{
    self.array = [NSMutableArray array];
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:self.commendUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableDictionary *dic = [[NSJSONSerialization JSONObjectWithData:data options:0 error:&error] valueForKey:@"data"];
        self.array = [AA_commentModel getModel:[dic valueForKey:@"exhibitCommentVos"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableV reloadData];
        });
    }] resume];
}

- (void)creatWindow{
    self.viewWin = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 40)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.frame = CGRectMake(5, 5, 40, 30);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
    self.viewWin.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39, [UIScreen mainScreen].bounds.size.width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 30)];
    label.text = @"评论";
    label.textAlignment = 1;
    [self.viewWin addSubview:label];
    [self.viewWin addSubview:line];
    [self.viewWin addSubview:button];
    [self.view addSubview:self.viewWin];
}

- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:0];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = NO;
    [self.tableV registerClass:[AA_CommentCell class] forCellReuseIdentifier:@"comment"];
    [self.view addSubview:self.tableV];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AA_CommentCell *comment = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    comment.selectionStyle = UITableViewCellSelectionStyleNone;
    comment.model = self.array[indexPath.row];
    comment.delegate = self;
    return comment;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AA_commentModel *model = self.array[indexPath.row];
    return 85 + [AA_adaptivelyHW getHeight:model.commentTxt :[UIScreen mainScreen].bounds.size.width - 110 :17];
}

- (void)clickReply{
    
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

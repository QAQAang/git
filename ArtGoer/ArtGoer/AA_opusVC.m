//
//  AA_opusVC.m
//  ArtGoer
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_opusVC.h"
#import "AA_opustableViewCell.h"
#import "AA_commentModel.h"
#import "AA_opusWorkModel.h"
#import "AA_opusPicVC.h"
#import "AA_checkNet.h"
@interface AA_opusVC ()<UITableViewDataSource, UITableViewDelegate, opusCellDelegate>

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) NSMutableArray *arrayWork;

@property (nonatomic, retain) NSMutableArray *arrayComment;

@property (nonatomic, retain) NSMutableArray *arrayTotal;

@end

@implementation AA_opusVC

- (NSMutableArray *)arrayTotal{
    if (_arrayTotal == nil) {
        _arrayTotal = [NSMutableArray array];
    }
    return _arrayTotal;
}

- (NSMutableArray *)arrayWork{
    if (_arrayWork == nil) {
        _arrayWork = [NSMutableArray array];
    }
    return _arrayWork;
}

- (NSMutableArray *)arrayComment{
    if (_arrayComment == nil) {
        _arrayComment = [NSMutableArray array];
    }
    return _arrayComment;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self creatTableV];
    if ([AA_checkNet checknet]) {
        [self getTaskData];
    }else{
        NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(prompt:) userInfo:nil repeats:YES];
    }
}

- (void)prompt:(NSTimer *)time{
    [time invalidate];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查网络连接" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([AA_checkNet checknet]) {
            [self getTaskData];
        }else{
            NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(prompt:) userInfo:nil repeats:YES];
        }
    }];
    [alert addAction:action];
    [self.parentViewController presentViewController:alert animated:NO completion:^{
        
    }];
}

- (void)getTaskData{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/hot/exhibitWorker?pageIndex=1&token=07d48315-f9be-4d20-a2db-657f7284ad5c"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableArray *array = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] valueForKey:@"data"];
        self.arrayWork = [AA_opusWorkModel getModel:[array valueForKey:@"exhibitWorkVo"]];
        self.arrayComment = [AA_commentModel getModel:[array valueForKey:@"exhibitWorkCommentVo"]];
        self.arrayTotal = [array valueForKey:@"totalConmment"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableV reloadData];
        });
    }]resume];
}

- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 149) style:0];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = NO;
    self.tableV.bounces = NO;
    self.tableV.backgroundColor = [UIColor whiteColor];
    [self.tableV addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.tableV registerClass:[AA_opustableViewCell class] forCellReuseIdentifier:@"opus"];
    [self.view addSubview:self.tableV];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayWork.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AA_opustableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"opus"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.workModel = self.arrayWork[indexPath.row];
    cell.commentModel = self.arrayComment[indexPath.row];
    cell.textLabel_goodTime.text = [NSString stringWithFormat:@"赞:%@    评论:%@", [self.arrayWork[indexPath.row] valueForKey:@"goodTimes"], self.arrayTotal[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AA_opusWorkModel *workModel = self.arrayWork[indexPath.row];
    CGFloat height;
    if ([workModel.worksHeight floatValue] / [workModel.worksWidth floatValue] * [UIScreen mainScreen].bounds.size.width > 350) {
        height = 350;
    }else{
        height = [workModel.worksHeight floatValue] / [workModel.worksWidth floatValue] * [UIScreen mainScreen].bounds.size.width;
    }
    return height + 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AA_opusWorkModel *workModel = self.arrayWork[indexPath.row];
    AA_opusPicVC *opusPic = [[AA_opusPicVC alloc] init];
    opusPic.model = workModel;
    [self presentViewController:opusPic animated:YES completion:^{
        
    }];
}

- (void)touchCommentView{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.delegate endScroll];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    CGPoint new = [[change valueForKey:@"new"] CGPointValue];
    CGPoint old = [[change valueForKey:@"old"] CGPointValue];
    [self.delegate changeOrigin:new.y - old.y];
}

@end

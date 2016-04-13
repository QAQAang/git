//
//  AA_choiceVC.m
//  ArtGoer
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_choiceVC.h"
#import "ChoiceTbViewCell.h"
#import "AA_NetWorkTool.h"
#import "ChoiceModel.h"
#import "MonthCell.h"
#import "UIImageView+WebCache.h"
#import "AA_secondViewController.h"
#import "AA_checkNet.h"
#import "MJRefresh.h"

#define URL @"http://api.artgoer.cn:8084/artgoer/api/v1/user/0/v3/topic/recommendHome?pageIndex=%ld&token=df68e038-143e-41cb-b554-456f78f184fc" , self.pager

@interface AA_choiceVC ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) UIScrollView *scroll;

@property (nonatomic, retain) NSMutableArray *array;

@property (nonatomic, retain) NSMutableArray *monthArr;

@property (nonatomic, retain) NSMutableArray *scrArr;

@property (nonatomic, retain) UIPageControl  *page;

@property (nonatomic, retain) NSTimer *time;

@property (nonatomic , assign)NSInteger pager;

@end

@implementation AA_choiceVC

- (NSMutableArray *)monthArr{
    if (_monthArr == nil) {
        _monthArr = [NSMutableArray arrayWithObjects:@"JAN", @"FEB", @"MAR",@"APR",@"MAY",@"JUN",@"JUL",@"AUG",@"SEP",@"OCT",@"NOV",@"DEC", nil];
    }
    return _monthArr;
}

- (NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
        _pager = 1;
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableV];
    [self creatScroll];
    if ([AA_checkNet checknet]) {
        [self dataTask:nil];
       [self scrollImage];
    }else{
        NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(prompt:) userInfo:nil repeats:YES];
    }
}

- (void)dataTask:(NSString *)strUrl{
    NSString *url;
    if (strUrl) {
        url = strUrl;
    }else
        url = @"http://api.artgoer.cn:8084/artgoer/api/v1/user/0/v3/topic/recommendHome?pageIndex=1&token=df68e038-143e-41cb-b554-456f78f184fc";
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableArray *arr = [[NSJSONSerialization JSONObjectWithData:data options:0 error:&error] valueForKey:@"data"];
        if (self.array.count > 0) {
            self.array = [ChoiceModel getModel:arr];
        }
        else{
            [self.array removeAllObjects];
            self.array = [ChoiceModel getModel:arr];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",self.array);
            [self.tableV reloadData];
            if (strUrl) {
                [self.tableV.mj_header endRefreshing];
            }
        });
    }] resume];
}

- (void)scrollImage{
    self.scrArr = [NSMutableArray array];
    [self.scrArr addObject:[[[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/topic/topicDetailInfo?topicId=547&token=07d48315-f9be-4d20-a2db-657f7284ad5c"]] options:0 error:nil] valueForKey:@"data"] valueForKey:@"topicPic"]];
    [self.scrArr addObject:[[[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/topic/topicDetailInfo?topicId=539&token=07d48315-f9be-4d20-a2db-657f7284ad5c"]] options:0 error:nil] valueForKey:@"data"] valueForKey:@"topicPic"]];
    [self.scrArr addObject:[[[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/topic/topicDetailInfo?topicId=534&token=07d48315-f9be-4d20-a2db-657f7284ad5c"]] options:0 error:nil] valueForKey:@"data"] valueForKey:@"topicPic"]];
    [self.scrArr addObject:[[[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/topic/topicDetailInfo?topicId=524&token=07d48315-f9be-4d20-a2db-657f7284ad5c"]] options:0 error:nil] valueForKey:@"data"] valueForKey:@"topicPic"]];
    [self.scrArr addObject:[[[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/topic/topicDetailInfo?topicId=581&token=07d48315-f9be-4d20-a2db-657f7284ad5c"]] options:0 error:nil] valueForKey:@"data"] valueForKey:@"topicPic"]];
    for (int i = 0; i < 7; i++) {
        if (i == 0) {
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, 414 * AWIDTH, 250 * AHEIGHT)];
            [imageV sd_setImageWithURL:[NSURL URLWithString:self.scrArr[4]]];
            [self.scroll addSubview:imageV];
        }else if (i == 6){
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, 414 * AWIDTH, 250 * AHEIGHT)];
            [imageV sd_setImageWithURL:[NSURL URLWithString:self.scrArr[0]]];
            [self.scroll addSubview:imageV];
        }else{
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, 414 * AWIDTH, 250 * AHEIGHT)];
            [imageV sd_setImageWithURL:[NSURL URLWithString:self.scrArr[i - 1]]];
            [self.scroll addSubview:imageV];
        }
    }
}

- (void)prompt:(NSTimer *)time{
    [time invalidate];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查网络连接" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([AA_checkNet checknet]) {
            [self dataTask:nil];
            [self scrollImage];
        }else{
            NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(prompt:) userInfo:nil repeats:YES];
        }
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:NO completion:^{
        
    }];
}

- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = NO;
    self.tableV.backgroundColor = [UIColor whiteColor];
    [self.tableV registerClass:[ChoiceTbViewCell class] forCellReuseIdentifier:@"tbcell"];
    [self.tableV registerClass:[MonthCell class] forCellReuseIdentifier:@"month"];
    [self.view addSubview:self.tableV];
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    self.tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}
                             
- (void)loadNewData{
    self.pager = 1;
    NSString *strUrl = [NSString stringWithFormat:URL];
    [self dataTask:strUrl];
}

- (void)loadMoreData{
    self.pager ++;
    NSString *url = [NSString stringWithFormat:URL];
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableArray *arr = [[NSJSONSerialization JSONObjectWithData:data options:0 error:&error] valueForKey:@"data"];
//        [ChoiceModel getModel:arr];
        NSMutableArray *result = [ChoiceModel getModel:arr];
        if (result.count > 0) {
            [self.array addObjectsFromArray:result];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableV reloadData];
            [self.tableV.mj_footer endRefreshing];
        });
    }] resume];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (void)creatScroll{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250 * AHEIGHT)];
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250 * AHEIGHT)];
    self.scroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 7, 250 * AHEIGHT);
    self.scroll.delegate = self;
    self.scroll.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width, 0);
    self.scroll.pagingEnabled = YES;
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 50 * AWIDTH, 230 * AHEIGHT, 100 * AWIDTH, 20 * AHEIGHT)];
    self.page.alpha = 0.9;
    self.page.numberOfPages = 5;
    self.page.pageIndicatorTintColor = [UIColor whiteColor];
    self.page.currentPageIndicatorTintColor = [UIColor orangeColor];
    [view addSubview:self.scroll];
    [view addSubview:self.page];
    self.tableV.tableHeaderView = view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.array[indexPath.row] isKindOfClass:[NSString class]] ) {
        return 30 * AHEIGHT;
    }else{
        return 250 * AHEIGHT;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChoiceTbViewCell *tbcell = [tableView dequeueReusableCellWithIdentifier:@"tbcell"];
    MonthCell *month = [tableView dequeueReusableCellWithIdentifier:@"month"];
    tbcell.selectionStyle = UITableViewCellSelectionStyleNone;
    month.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.array[indexPath.row] isKindOfClass:[NSString class]] ) {
        NSString *dateM = [self.array[indexPath.row] substringWithRange:NSMakeRange(5, 2)];
        month.textLabel_month.text = [NSString stringWithFormat:@"- %@.%@ -", self.monthArr[dateM.integerValue - 1], [self.array[indexPath.row] substringWithRange:NSMakeRange(8, 2)]];
        return month;
    }else{
            tbcell.model = self.array[indexPath.row];
        return tbcell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.array[indexPath.row] isKindOfClass:[ChoiceModel class]]) {
        CATransform3D rotation;
        rotation = CATransform3DMakeRotation( (90.0 * M_PI) / 180, 0.0, 0.7, 0.4);
        rotation.m34 = 1.0 / - (600 * AHEIGHT) ;
        
        cell.layer.shadowColor = [[UIColor blackColor] CGColor];
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        cell.alpha = 0;
        cell.layer.transform = rotation;
//        cell.layer.anchorPoint = CGPointMake(0, 0.5);
        [UIView beginAnimations:@"rotation" context:NULL];
        [UIView setAnimationDuration:0.8];
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        [UIView commitAnimations];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.array[indexPath.row] isKindOfClass:[ChoiceModel class]]) {
        ChoiceModel *model = self.array[indexPath.row];
        AA_secondViewController *secdVC = [[AA_secondViewController alloc] init];
#warning mark !!! 收藏跳转注意 !!!
        secdVC.model = model;
        secdVC.commentUrl = [NSString stringWithFormat:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/topic/specialGraphicComment?topicId=%@&pageIndex=1&token=07d48315-f9be-4d20-a2db-657f7284ad5c", [self.array[indexPath.row] valueForKey:@"id_AA"]];
        secdVC.url = [self.array[indexPath.row] valueForKey:@"marketingDesc"];
        secdVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:secdVC animated:YES completion:^{
            
        }];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.scroll) {
        [self.time setFireDate:[NSDate distantFuture]];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (scrollView == self.scroll) {
        self.page.currentPage = ([UIScreen mainScreen].bounds.size.width + self.scroll.contentOffset.x) / [UIScreen mainScreen].bounds.size.width - 1;
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (self.scroll.contentOffset.x >= [UIScreen mainScreen].bounds.size.width && self.scroll.contentOffset.x <= [UIScreen mainScreen].bounds.size.width * 5) {
        self.page.currentPage = (NSInteger)(self.scroll.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
    }else if (self.scroll.contentOffset.x < [UIScreen mainScreen].bounds.size.width){
        self.page.currentPage = 5;
    }else if (self.scroll.contentOffset.x > [UIScreen mainScreen].bounds.size.width * 5){
        self.page.currentPage = 0;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.scroll) {
        NSDate *date = [NSDate dateWithTimeInterval:3 sinceDate:[NSDate date]];
        [self.time setFireDate:date];
        if (self.scroll.contentOffset.x >= [UIScreen mainScreen].bounds.size.width * 6) {
            self.scroll.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width, 0);
        }else if (self.scroll.contentOffset.x <= 0){
            self.scroll.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width * 5, 0); 
        }
    }
}


- (void)fireTime{
    dispatch_queue_t queue = dispatch_queue_create("TimerQueue", NULL);
    dispatch_async(queue, ^{
        [self creatTimer];
    });
}

- (void)creatTimer{
    self.time = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeOffset) userInfo:nil repeats:YES];
//    self.time = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(changeOffset) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.time forMode:@"NSRunLoopCommonModes"];
    [[NSRunLoop currentRunLoop] run];

}

- (void)changeOffset{
    if (self.scroll.contentOffset.x > 0 && self.scroll.contentOffset.x < [UIScreen mainScreen].bounds.size.width * 5) {
        self.page.currentPage = (NSInteger)(self.scroll.contentOffset.x / ([UIScreen mainScreen].bounds.size.width - 1));
    }else if (self.scroll.contentOffset.x == 0){
        self.page.currentPage = 5;
    }else if (self.scroll.contentOffset.x == [UIScreen mainScreen].bounds.size.width * 5){
        self.page.currentPage = 0;
    }
    if ([UIScreen mainScreen].bounds.size.width + self.scroll.contentOffset.x == [UIScreen mainScreen].bounds.size.width * 6) {
        self.scroll.contentOffset = CGPointMake(0, 0);
    }
    [self.scroll scrollRectToVisible:CGRectMake([UIScreen mainScreen].bounds.size.width + self.scroll.contentOffset.x , 0, [UIScreen mainScreen].bounds.size.width, 250) animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fireTime];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.time invalidate];
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

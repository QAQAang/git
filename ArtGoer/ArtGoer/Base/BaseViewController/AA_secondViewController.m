//
//  AA_secondViewController.m
//  ArtGoer
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_secondViewController.h"
#import "AA_CommentCell.h"
#import "AA_commentModel.h"
#import "AA_adaptivelyHW.h"
#import "AA_commendVC.h"
#import "AA_secondCell.h"
#import "AA_recommendCell.h"
#import "AA_replesVC.h"
#import "AA_sqliteTools.h"
@interface AA_secondViewController ()<UITableViewDataSource, UITableViewDelegate, CommentModelDelegate, UIWebViewDelegate, WKNavigationDelegate, WKUIDelegate>

@property (nonatomic , retain) UITableView *tableV;

@property (nonatomic, retain) NSMutableArray *arrayComment;

@property (nonatomic, retain) NSMutableArray *arrayRecommend;

@property (nonatomic, retain) UIView *viewWin;

@property (nonatomic, assign) CGFloat webViewHeight;

@property (nonatomic, retain) UIButton *collectBtn;

@end

@implementation AA_secondViewController

- (NSMutableArray *)arrayComment{
    if (_arrayComment == nil) {
        _arrayComment = [NSMutableArray array];
    }
    return _arrayComment;
}

- (NSMutableArray *)arrayRecommend{
    if (_arrayRecommend == nil) {
        _arrayRecommend = [NSMutableArray array];
    }
    return _arrayRecommend;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.view addSubview:self.webView];
    self.webViewHeight = CGRectGetHeight(self.webView.frame);
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.hidden = YES;
    [self.webView sizeThatFits:CGSizeZero];
    [self.webView loadRequest:request];
    [self creatWindow];
    [self creatCommentView];
    [self getTaskData];
//    [self.webView addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)getTaskData{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:self.commentUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableDictionary *dic = [[NSJSONSerialization JSONObjectWithData:data options:0 error:&error] valueForKey:@"data"];
        self.arrayComment = [AA_commentModel getModel:[dic valueForKey:@"exhibitCommentVos"]];
        self.arrayRecommend = [ChoiceModel getRecommendModel:[dic valueForKey:@"topicVos"]];
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
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 45, 5, 40, 30);
    if ([AA_sqliteTools selectUserByTitle:self.model.topicName].count == 0) {
        [self.collectBtn setImage:[UIImage imageNamed:@"off.jpg"] forState:UIControlStateNormal];
    }else{
        [self.collectBtn setImage:[UIImage imageNamed:@"on"] forState:UIControlStateNormal];
    }
    [self.collectBtn addTarget:self action:@selector(ClickCollect) forControlEvents:UIControlEventTouchUpInside];
    [self.viewWin addSubview:self.collectBtn];
    [self.viewWin addSubview:line];
    [self.viewWin addSubview:button];
    [self.view addSubview:self.viewWin];
}

- (void)creatCommentView{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 60) style:UITableViewStylePlain];
//    self.tableV.scrollEnabled = NO;
    self.tableV.separatorStyle = NO;
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.tableV registerClass:[AA_secondCell class] forCellReuseIdentifier:@"secondCell"];
    [self.tableV registerClass:[AA_CommentCell class] forCellReuseIdentifier:@"commentCell"];
    [self.tableV registerClass:[AA_recommendCell class] forCellReuseIdentifier:@"recommendCell"];
    [self.view addSubview:self.tableV];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return self.arrayComment.count;
    }else{
        return self.arrayRecommend.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.webViewHeight;
    }else if (indexPath.section == 1){
        AA_commentModel *model = self.arrayComment[indexPath.row];
        return 90 + [AA_adaptivelyHW getHeight:model.commentTxt :[UIScreen mainScreen].bounds.size.width - 110 :17];
    }else{
        return 120;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else if (section == 1){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 25, 0, 100, 20)];
        label.text = @"精彩评论";
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:15];
        [view addSubview:label];
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(20, 9, [UIScreen mainScreen].bounds.size.width / 2 - 65, 1)];
        line1.backgroundColor = [UIColor blackColor];
        [view addSubview:line1];
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 + 55, 9, [UIScreen mainScreen].bounds.size.width / 2 - 65, 1)];
        line2.backgroundColor = [UIColor blackColor];
        [view addSubview:line2];
        return view;
    }else{
        UILabel *recommend = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, 30)];
        recommend.text = @"推/荐/阅/读";
        recommend.textAlignment = 1;
        return recommend;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AA_secondCell *webCell = [tableView dequeueReusableCellWithIdentifier:@"secondCell"];
        webCell.webUrl = self.url;
        return webCell;
    }else if (indexPath.section == 1){
        AA_CommentCell *comment = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
        comment.selectionStyle = UITableViewCellSelectionStyleNone;
        comment.model = self.arrayComment[indexPath.row];
        comment.delegate = self;
        return comment;
    }else{
        AA_recommendCell *recomCell = [tableView dequeueReusableCellWithIdentifier:@"recommendCell"];
        recomCell.selectionStyle = UITableViewCellSelectionStyleNone;
        recomCell.model = self.arrayRecommend[indexPath.row];
        return recomCell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else if (section == 1){
        UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
        more.frame = CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 30);
        [more setTitle:@"MORE" forState:UIControlStateNormal];
        [more setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [more addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        return more;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1){
        return 20;
    }else{
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1){
        return 50;
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        AA_replesVC *reples = [[AA_replesVC alloc] init];
        reples.headView = [[self tableView:tableView cellForRowAtIndexPath:indexPath] valueForKey:@"contentView"];
        AA_commentModel *model = self.arrayComment[indexPath.row];
        reples.headHeight = 90 + [AA_adaptivelyHW getHeight:model.commentTxt :[UIScreen mainScreen].bounds.size.width - 110 :17];
        reples.array = [self.arrayComment[indexPath.row] valueForKey:@"replies"];
        [self presentViewController:reples animated:YES completion:^{
            
        }];
    }else if (indexPath.section == 2){
        AA_secondViewController *secdVC = [[AA_secondViewController alloc] init];
        secdVC.commentUrl = [NSString stringWithFormat:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/topic/specialGraphicComment?topicId=%@&pageIndex=1&token=07d48315-f9be-4d20-a2db-657f7284ad5c", [self.arrayRecommend[indexPath.row] valueForKey:@"id_AA"]];
        secdVC.url = [self.arrayRecommend[indexPath.row] valueForKey:@"marketingDesc"];
        secdVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:secdVC animated:YES completion:^{
            
        }];
    }
}

- (void)turnBack{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        self.webViewHeight = [result floatValue];
        [self.tableV reloadData];
    }];
}

- (void)ClickCollect{
    if ([AA_sqliteTools selectUserByTitle:self.model.topicName].count == 0) {
        [AA_sqliteTools insertUserWithTitle:self.model.topicName PicUrl:self.model.topicPic Url:self.url Comment:self.commentUrl];
        [self.collectBtn setImage:[UIImage imageNamed:@"on"] forState:UIControlStateNormal];
    }else{
        [AA_sqliteTools deleteUserWithTitle:self.model.topicName];
        [self.collectBtn setImage:[UIImage imageNamed:@"off.jpg"] forState:UIControlStateNormal];
    }
}

- (void)click{
    AA_commendVC *commendVc = [[AA_commendVC alloc] init];
    commendVc.commendUrl = self.commentUrl;
    commendVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:commendVc animated:YES completion:^{
        
    }];
}

- (void)clickReply{
    
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

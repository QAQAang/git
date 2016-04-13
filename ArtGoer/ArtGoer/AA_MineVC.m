//
//  AA_MineVC.m
//  ArtGoer
//
//  Created by dllo on 16/3/10.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_MineVC.h"
#import "AA_mineButton.h"
#import "AA_sqliteAuthor.h"
#import "AA_sqliteExhibit.h"
#import "AA_sqliteIns.h"
#import "AA_sqliteTools.h"
#import "AA_mineAuthorCell.h"
#import "AA_mineExhibitCell.h"
#import "AA_pagesVC.h"
#import "AA_secondViewController.h"
#import "AA_authorSpaceVC.h"
#import "AA_InstitutionSpaceVC.h"
#import "SJLCleanCache.h"
@interface AA_MineVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UIButton *collectBtn;

@property (nonatomic, retain) UIButton *clearCache;

@property (nonatomic, retain) UIImageView *headPic;

@property (nonatomic, retain) UIView *menuView;

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) UIView *line;

@property (nonatomic, retain) UIView *contentView;

@property (nonatomic, retain) NSMutableArray *array;

@property (nonatomic, retain) AA_mineButton *exhibitBtn;

@property (nonatomic, retain) AA_mineButton *subjectBtn;

@property (nonatomic, retain) AA_mineButton *authorBtn;

@property (nonatomic, retain) AA_mineButton *insBtn;

@property (nonatomic, retain) NSMutableArray *btnArr;

@property (nonatomic, retain) UILabel *headTitle;

@property (nonatomic, assign) NSInteger pickCount;

@property (nonatomic, retain) UIAlertController *alert;

@end

@implementation AA_MineVC

- (NSMutableArray *)btnArr{
    if (_btnArr == nil) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self creatView];
    [self creatBtn];
    [self creatTableView];
}

- (void)creatView{
    self.contentView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.headPic = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 50 * AWIDTH, 100 * AHEIGHT, 100 * AWIDTH, 100 * AHEIGHT)];
    self.headPic.layer.cornerRadius = self.headPic.frame.size.width / 2;
    self.headPic.clipsToBounds = YES;
    self.headPic.layer.shadowColor = [UIColor blackColor].CGColor;
    self.headPic.layer.shadowOpacity = 2;
    self.headPic.image = [UIImage imageNamed:@"2.jpg"];
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 4 - 40 * AWIDTH, 300 * AHEIGHT, 80 * AWIDTH, 125 * AHEIGHT);
    [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [self.collectBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.collectBtn addTarget:self action:@selector(clickCollect) forControlEvents:UIControlEventTouchUpInside];
    self.collectBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    [self.contentView addSubview:self.collectBtn];
    self.line = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 4 + 21 * AWIDTH, 362* AHEIGHT, [UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.width / 4 - 20 * AWIDTH, 1)];
    self.line.backgroundColor = [UIColor lightGrayColor];
    self.line.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.line.layer.shadowOpacity = 1;
    [self.contentView addSubview:self.line];
    self.clearCache = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clearCache.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 4 - 50 * AWIDTH, 450 * AHEIGHT, 100 * AWIDTH, 125 * AHEIGHT);
    self.clearCache.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22 * AWIDTH];
    [self.clearCache setTitle:@"清除缓存" forState:UIControlStateNormal];
    [self.clearCache setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.clearCache setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.clearCache addTarget:self action:@selector(clearcache) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.clearCache];
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 10 * AWIDTH, 20 * AHEIGHT, 75 * AWIDTH, [UIScreen mainScreen].bounds.size.height)];
    self.menuView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.menuView.layer.shadowOffset = CGSizeMake(5, 0);
    self.menuView.layer.shadowOpacity = 1;
    self.menuView.backgroundColor = [UIColor whiteColor];
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.menuView addGestureRecognizer:recognizer];
    [self.view addSubview:self.contentView];
    
}

- (void)creatBtn{
    self.exhibitBtn = [AA_mineButton buttonWithType:UIButtonTypeCustom];
    [self.exhibitBtn setTitle:@"展览" forState:UIControlStateNormal];
    [self.exhibitBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.exhibitBtn.alpha = 0.3;
    self.exhibitBtn.type = @"exhibit";
    self.exhibitBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.exhibitBtn.frame = CGRectMake(0, 100, 75, 50);
    [self.exhibitBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView addSubview:self.exhibitBtn];
    [self.btnArr addObject:self.exhibitBtn];
    self.subjectBtn = [AA_mineButton buttonWithType:UIButtonTypeCustom];
    [self.subjectBtn setTitle:@"专题" forState:UIControlStateNormal];
    self.subjectBtn.type = @"subject";
    [self.subjectBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.subjectBtn.alpha = 0.3;
    self.subjectBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.subjectBtn.frame = CGRectMake(0, 175, 75, 50);
    [self.subjectBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView addSubview:self.subjectBtn];
    [self.btnArr addObject:self.subjectBtn];
    self.authorBtn = [AA_mineButton buttonWithType:UIButtonTypeCustom];
    [self.authorBtn setTitle:@"关注" forState:UIControlStateNormal];
    [self.authorBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.authorBtn.alpha = 0.3;
    self.authorBtn.type = @"author";
    self.authorBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.authorBtn.frame = CGRectMake(0, 250, 75, 50);
    [self.authorBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView addSubview:self.authorBtn];
    [self.btnArr addObject:self.authorBtn];
    self.insBtn = [AA_mineButton buttonWithType:UIButtonTypeCustom];
    [self.insBtn setTitle:@"机构" forState:UIControlStateNormal];
    [self.insBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.insBtn.alpha = 0.3;
    self.insBtn.type = @"ins";
    self.insBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.insBtn.frame = CGRectMake(0, 325, 75, 50);
    [self.insBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView addSubview:self.insBtn];
    [self.btnArr addObject:self.insBtn];
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
}

- (void)creatTableView{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width + 65, 20, [UIScreen mainScreen].bounds.size.width - 75, [UIScreen mainScreen].bounds.size.height - 20) style:0];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.tableV registerClass:[AA_mineAuthorCell class] forCellReuseIdentifier:@"author"];
    [self.tableV registerClass:[AA_mineExhibitCell class] forCellReuseIdentifier:@"exhibit"];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 75, 40)];
    self.headTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width - 75, 30)];
    self.headTitle.font = [UIFont systemFontOfSize:16];
    self.headTitle.textAlignment = 1;
    [headView addSubview:self.headTitle];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39, [UIScreen mainScreen].bounds.size.width - 75, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    self.tableV.tableHeaderView = headView;
    [headView addSubview:line];
    [self.view addSubview:self.tableV];
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.headPic];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.pickCount == 1 || self.pickCount == 2) {
        AA_mineExhibitCell *cell = [self.tableV dequeueReusableCellWithIdentifier:@"exhibit"];
        cell.dicData = self.array[indexPath.row];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        return cell;
    }else{
        AA_mineAuthorCell *cell = [self.tableV dequeueReusableCellWithIdentifier:@"author"];
        cell.dicData = self.array[indexPath.row];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.pickCount == 1 || self.pickCount == 2) {
        return 100;
    }else{
        return 60;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.pickCount == 1) {
        AA_pagesVC *pages = [[AA_pagesVC alloc] init];
        pages.exhibitID = [self.array[indexPath.row] valueForKey:@"url"];
        [self presentViewController:pages animated:YES completion:^{
            
        }];
    }else if (self.pickCount == 2){
        AA_secondViewController *second = [[AA_secondViewController alloc] init];
        second.url = [self.array[indexPath.row] valueForKey:@"url"];
        second.commentUrl = [self.array[indexPath.row] valueForKey:@"comment"];
        second.model = [[ChoiceModel alloc] init];
        second.model.topicName = [self.array[indexPath.row] valueForKey:@"title"];
        second.model.topicPic = [self.array[indexPath.row] valueForKey:@"picUrl"];
        [self presentViewController:second animated:YES completion:^{
            
        }];
    }else if (self.pickCount == 3){
        AA_authorSpaceVC *author = [[AA_authorSpaceVC alloc] init];
        author.userId = [self.array[indexPath.row] valueForKey:@"url"];
        [self presentViewController:author animated:YES completion:^{
            
        }];
    }else if (self.pickCount == 4){
        AA_InstitutionSpaceVC *institution = [[AA_InstitutionSpaceVC alloc] init];
        institution.galleryID = [self.array[indexPath.row] valueForKey:@"url"];
        [self presentViewController:institution animated:YES completion:^{
            
        }];
    }
}

- (void)clearcache{
    NSString *path1 = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath1 = [path1 stringByAppendingPathComponent:@"com.lanou3g.ArtGoer"];
    NSString *path2 = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath2 = [path2 stringByAppendingPathComponent:@"default"];
    self.alert = [UIAlertController alertControllerWithTitle:@"清除成功" message:[NSString stringWithFormat:@"共清理%.2lfMB", [SJLCleanCache folderSizeAtPath:filePath1] + [SJLCleanCache folderSizeAtPath:filePath2]] preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:self.alert animated:YES completion:^{
        [SJLCleanCache removeCache:filePath1];
        [SJLCleanCache removeCache:filePath2];
        NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(dismissAlert) userInfo:nil repeats:YES];
        [time fire];
    }];
    
}

- (void)clickCollect{

    [UIView animateWithDuration:1.2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.contentView.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.headPic.frame = CGRectMake(10, 25, 50, 50);
        self.headPic.layer.cornerRadius = 25;
        self.menuView.frame = CGRectMake(0, 20, 75, [UIScreen mainScreen].bounds.size.height);
        self.tableV.frame = CGRectMake(75, 20, [UIScreen mainScreen].bounds.size.width - 75, [UIScreen mainScreen].bounds.size.height - 20);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissAlert{
    [self.alert dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [UIView animateWithDuration:1.2 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.contentView.frame = [UIScreen mainScreen].bounds;
            self.headPic.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 -50, 100, 100, 100);
            self.headPic.layer.cornerRadius = 50;
            self.menuView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 10, 20, 75, [UIScreen mainScreen].bounds.size.height);
            self.tableV.frame = CGRectMake([UIScreen mainScreen].bounds.size.width + 65, 20, [UIScreen mainScreen].bounds.size.width - 75, [UIScreen mainScreen].bounds.size.height - 20);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)click:(AA_mineButton *)sender{
    if (sender.pickYN == NO) {
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sender.alpha = 0.7;
        sender.titleLabel.font = [UIFont systemFontOfSize:21];
        sender.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        sender.layer.shadowOpacity = 1;
        if ([sender.type isEqualToString:@"exhibit"]) {
            self.headTitle.text = @"展览";
            self.pickCount = 1;
            self.array = [AA_sqliteExhibit selectUserByTitle:nil];
            [self.tableV reloadData];
        }else if ([sender.type isEqualToString:@"subject"]){
            self.headTitle.text = @"专题";
            self.pickCount = 2;
            self.array = [AA_sqliteTools selectUserByTitle:nil];
            [self.tableV reloadData];
        }else if ([sender.type isEqualToString:@"author"]){
            self.headTitle.text = @"关注";
            self.pickCount = 3;
            self.array = [AA_sqliteAuthor selectUserByTitle:nil];
            [self.tableV reloadData];
        }else if ([sender.type isEqualToString:@"ins"]){
            self.headTitle.text = @"机构";
            self.pickCount = 4;
            self.array = [AA_sqliteIns selectUserByTitle:nil];
            [self.tableV reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
        }
        for (int i = 0; i < self.btnArr.count; i++) {
            if ([[self.btnArr[i] valueForKey:@"pickYN"] boolValue] == YES) {
                AA_mineButton *button = self.btnArr[i];
                [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                button.alpha = 0.3;
                button.titleLabel.font = [UIFont systemFontOfSize:20];
                button.layer.shadowColor = [UIColor clearColor].CGColor;
                button.layer.shadowOpacity = 0;
                button.pickYN = NO;
                self.btnArr[i] = button;
            }
        }
        sender.pickYN = YES;
    }else{
        [sender setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        sender.alpha = 0.3;
        sender.titleLabel.font = [UIFont systemFontOfSize:20];
        sender.layer.shadowColor = [UIColor clearColor].CGColor;
        sender.layer.shadowOpacity = 0;
        sender.pickYN = NO;
    }
}



@end

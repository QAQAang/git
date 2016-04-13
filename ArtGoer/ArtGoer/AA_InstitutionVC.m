//
//  AA_InstitutionVC.m
//  ArtGoer
//
//  Created by dllo on 16/3/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_InstitutionVC.h"
#import "AA_DetailToinstitutionModel.h"
#import "AA_InsExhibitsModel.h"
#import "AA_InstableViewCell.h"
#import "AA_AllInsTableViewCell.h"
#import "AA_InstitutionSpaceVC.h"
#import "AA_sqliteIns.h"
#import "AA_checkNet.h"
@interface AA_InstitutionVC ()<UITableViewDataSource, UITableViewDelegate, insCellDelegate>

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) NSMutableArray *arrayRecommend;

@property (nonatomic, retain) NSMutableArray *arrayAllArt;

@end

@implementation AA_InstitutionVC

- (NSMutableArray *)arrayAllArt{
    if (_arrayAllArt == nil) {
        _arrayAllArt = [NSMutableArray array];
    }
    return _arrayAllArt;
}

- (NSMutableArray *)arrayRecommend{
    if (_arrayRecommend == nil) {
        _arrayRecommend = [NSMutableArray array];
    }
    return _arrayRecommend;
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
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/v3/discoveryGalleries?pageIndex=1&token=07d48315-f9be-4d20-a2db-657f7284ad5c"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            NSMutableDictionary *dic = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] valueForKey:@"data"];
            self.arrayAllArt = [AA_DetailToinstitutionModel getAllGalleryModel:[dic valueForKey:@"allGalleryVos"]];
            self.arrayRecommend = [AA_DetailToinstitutionModel getRecommendGalleryModel:[dic valueForKey:@"recommendGalleryVos"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableV reloadData];
            });
        }
    }] resume];
    
}

- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 149) style:0];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = NO;
    self.tableV.bounces = NO;
    [self.tableV addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    self.tableV.backgroundColor = [UIColor whiteColor];
    [self.tableV registerClass:[AA_AllInsTableViewCell class] forCellReuseIdentifier:@"allArt"];
    [self.view addSubview:self.tableV];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return self.arrayRecommend.count;
    }else{
        return self.arrayAllArt.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AA_InstableViewCell *recommend = [[AA_InstableViewCell alloc] initWithStyle:0 reuseIdentifier:nil];
        recommend.selectionStyle = UITableViewCellSelectionStyleNone;
        recommend.model = self.arrayRecommend[indexPath.row];
        recommend.delegate = self;
        if ([AA_sqliteIns selectUserByTitle:recommend.model.galleryName].count == 0) {
            [recommend.addButton setImage:[UIImage imageNamed:@"iconfont-jiahao"] forState:UIControlStateNormal];
        }else{
            [recommend.addButton setImage:[UIImage imageNamed:@"iconfont-jiantou"] forState:UIControlStateNormal];
        }
        return recommend;
    }else{
        AA_AllInsTableViewCell *allArt = [[AA_AllInsTableViewCell alloc] initWithStyle:0 reuseIdentifier:@"allArt"];
        allArt.model = self.arrayAllArt[indexPath.row];
        allArt.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([AA_sqliteIns selectUserByTitle:allArt.model.galleryName].count == 0) {
            [allArt.addButton setImage:[UIImage imageNamed:@"iconfont-jiahao"] forState:UIControlStateNormal];
        }else{
            [allArt.addButton setImage:[UIImage imageNamed:@"iconfont-jiantou"] forState:UIControlStateNormal];
        }
        return allArt;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 220;
    }else{
        return 60;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 2, 20)];
        line.backgroundColor = [UIColor blackColor];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 120, 20)];
        title.text = @"推荐机构";
        title.font = [UIFont systemFontOfSize:16];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
        [view addSubview:line];
        [view addSubview:title];
        return view;
    }else{
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 2, 20)];
        line.backgroundColor = [UIColor blackColor];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 120, 20)];
        title.text = @"全部机构";
        title.font = [UIFont systemFontOfSize:16];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
        [view addSubview:line];
        [view addSubview:title];
        return view;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AA_InstitutionSpaceVC *space = [[AA_InstitutionSpaceVC alloc] init];
        space.galleryID = [self.arrayRecommend[indexPath.row] valueForKey:@"id_AA"];
        [self presentViewController:space animated:YES completion:^{
            
        }];
    }else{
        AA_InstitutionSpaceVC *space = [[AA_InstitutionSpaceVC alloc] init];
        space.galleryID = [self.arrayAllArt[indexPath.row] valueForKey:@"id_AA"];
        [self presentViewController:space animated:YES completion:^{
            
        }];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.delegate endScroll];
}

- (void)clickItemExid:(NSString *)exid{
    [self.delegate institutionTopagesExid:exid];
}

- (void)clickButtonId:(NSString *)Id{

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    CGPoint new = [[change valueForKey:@"new"] CGPointValue];
    CGPoint old = [[change valueForKey:@"old"] CGPointValue];
    [self.delegate changeOrigin:new.y - old.y];
}

@end

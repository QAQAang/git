//
//  AA_exhibitVC.m
//  ArtGoer
//
//  Created by dllo on 16/3/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_exhibitVC.h"
#import "AA_exhibitCell.h"
#import "AA_detailPagesModel.h"
#import "AA_checkNet.h"
#import "SDImageCache.h"
@interface AA_exhibitVC ()<UITableViewDataSource, UITableViewDelegate, ExhibitCellDelegate>

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) NSMutableArray *array;

@property (nonatomic, retain) NSMutableArray *arrayTot;

//@property (nonatomic, retain)

@end

@implementation AA_exhibitVC



- (void)viewDidLoad {
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
    self.array = [NSMutableArray array];
    self.arrayTot = [NSMutableArray array];
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/0/v3/disExhibitsAndInit?pageIndex=1&timeSort=0&citySort=0&token=df68e038-143e-41cb-b554-456f78f184fc"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableArray *dataArr = [[NSJSONSerialization JSONObjectWithData:data options:0 error:&error] valueForKey:@"data"];
        for (NSMutableDictionary *dic in dataArr) {
            [self.array addObject:[AA_exhibitModel getModel:[dic valueForKey:@"exhibitArtistList"]]];
            [self.arrayTot addObject:[dic valueForKey:@"totalViewNums"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableV reloadData];
        });
    }] resume];
}

- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 149) style:0];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = NO;
    self.tableV.bounces = NO;
    self.tableV.backgroundColor = [UIColor whiteColor];
    [self.tableV addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.tableV registerClass:[AA_exhibitCell class] forCellReuseIdentifier:@"reuse"];
    [self.view addSubview:self.tableV];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AA_exhibitCell *cexhibit = [[AA_exhibitCell alloc] initWithStyle:0 reuseIdentifier:@"reuse"];
    cexhibit.selectionStyle = UITableViewCellSelectionStyleNone;
    cexhibit.array = self.array[indexPath.row];
    cexhibit.delegate = self;
    AA_exhibitModel *model = self.array[indexPath.row][0];
    model.totalViewNums = self.arrayTot[indexPath.row];
    cexhibit.model = model;
    return cexhibit;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 225;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AA_exhibitModel *model = self.array[indexPath.row][0];
    [self.delegate nextViewController:model.id_AA];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.delegate endScroll];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    CGPoint new = [[change valueForKey:@"new"] CGPointValue];
    CGPoint old = [[change valueForKey:@"old"] CGPointValue];
    [self.delegate changeOrigin:new.y - old.y];
}



- (void)clickItemCount:(NSInteger)count Exid:(NSString *)exid{
//    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/exhibit/%@?token=07d48315-f9be-4d20-a2db-657f7284ad5c", exid]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSMutableDictionary *dataDic = [[NSJSONSerialization JSONObjectWithData:data options:0 error:&error] valueForKey:@"data"];
//        AA_detailPagesModel *model = [AA_detailPagesModel getDetailModel:dataDic];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.delegate goInside:count ExhibitID:exid Models:model.works];
//        });
//    }] resume];
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/0/v3/disExhibitsAndInit?citySort=0&pageIndex=1&timeSort=0&token=df68e038-143e-41cb-b554-456f78f184fc"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableDictionary *dataDic = [[NSJSONSerialization JSONObjectWithData:data options:0 error:&error] valueForKey:@"data"];
        AA_detailPagesModel *model = [AA_detailPagesModel getDetailModel:dataDic];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate goInside:count ExhibitID:exid Models:model.works];
        });
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
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

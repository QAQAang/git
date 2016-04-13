//
//  AA_searchPageVC.m
//  ArtGoer
//
//  Created by dllo on 16/3/10.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_searchPageVC.h"
#import "AA_exhibitSearchCell.h"
#import "AA_institutionSearchCell.h"
#import "AA_peasonSearchCell.h"
#import "AA_authorModel.h"
#import "AA_DetailToinstitutionModel.h"
#import "AA_detailPagesModel.h"
#import "AA_InstitutionSpaceVC.h"
#import "AA_authorSpaceVC.h"
#import "AA_pagesVC.h"
@interface AA_searchPageVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) NSMutableArray *arrayModel;

@end

@implementation AA_searchPageVC

- (void)viewDidLoad{
    [super viewDidLoad];
    [self creatView];
}

- (void)getTaskData{
    if (self.searchText != nil) {
        if (self.HTTPMethod == 0) {
            NSMutableURLRequest *request  =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/%@/search", self.searchType]]];
            request.HTTPMethod = @"POST";
            request.HTTPBody = [[NSString stringWithFormat:@"pageIndex=1&key=%@&token=07d48315-f9be-4d20-a2db-657f7284ad5c", self.searchText] dataUsingEncoding:NSUTF8StringEncoding];
            [request setValue:[NSString stringWithFormat:@" %ld", (unsigned long)[NSString stringWithFormat:@"pageIndex=1&key=%@&token=07d48315-f9be-4d20-a2db-657f7284ad5c", [self.searchText stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]]].length] forHTTPHeaderField:@"Content-Length"];
            [request setValue:@" api.artgoer.cn:8084" forHTTPHeaderField:@"Host"];
            [request setValue:@" application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            
            [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSMutableArray *dataArr = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] valueForKey:@"data"];
                if (dataArr != nil) {
                    if ([self.searchType isEqualToString:@"talents"] || [self.searchType isEqualToString:@"arts"]) {
                        self.arrayModel = [AA_authorModel getAllArtModel:dataArr];
                    }else{
                        self.arrayModel = [AA_DetailToinstitutionModel getAllGalleryModel:dataArr];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableV reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
                    });
                }
            }]resume];
            
        }else{
            [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/0/exhibits/search?exhibitName=%@&pageIndex=1&token=df68e038-143e-41cb-b554-456f78f184fc", [self.searchText stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]]]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (data != nil) {
                    self.arrayModel = [AA_detailPagesModel getModels:[[[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] valueForKey:@"data"] valueForKey:@"exhibits"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableV reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
                    });
                }
            }]resume];
        }
    }
}

- (void)creatView{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:0];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = NO;
    self.tableV.bounces = NO;
    self.tableV.backgroundColor = [UIColor whiteColor];
    if (self.HTTPMethod == 1) {
        [self.tableV registerClass:[AA_exhibitSearchCell class] forCellReuseIdentifier:@"exhibit"];
    }else{
        if ([self.searchType isEqualToString:@"talents"] || [self.searchType isEqualToString:@"arts"]) {
            [self.tableV registerClass:[AA_peasonSearchCell class] forCellReuseIdentifier:@"peason"];
        }else{
            [self.tableV registerClass:[AA_institutionSearchCell class] forCellReuseIdentifier:@"ins"];
        }
    }
    [self.view addSubview:self.tableV];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.HTTPMethod == 1) {
        AA_exhibitSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"exhibit"];
        cell.model = self.arrayModel[indexPath.row];
        return cell;
    }else{
        if ([self.searchType isEqualToString:@"talents"] || [self.searchType isEqualToString:@"arts"]) {
             AA_peasonSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"peason"];
            cell.model = self.arrayModel[indexPath.row];
            return cell;
        }else{
            AA_institutionSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ins"];
            cell.model = self.arrayModel[indexPath.row];
            return cell;
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.searchType isEqualToString:@"gallery"]) {
        AA_InstitutionSpaceVC *insSpace = [[AA_InstitutionSpaceVC alloc] init];
        insSpace.galleryID = [self.arrayModel[indexPath.row] valueForKey:@"id_AA"];
        [self presentViewController:insSpace animated:NO completion:^{
            
        }];
    }else if ([self.searchType isEqualToString:@"arts"]){
        AA_authorSpaceVC *authorSpace = [[AA_authorSpaceVC alloc] init];
        authorSpace.userId = [self.arrayModel[indexPath.row] valueForKey:@"id_AA"];
        [self presentViewController:authorSpace animated:NO completion:^{
            
        }];
    }else if ([self.searchType isEqualToString:@"talents"]){
        
    }else{
        AA_pagesVC *pages  =[[AA_pagesVC alloc] init];
        pages.exhibitID = [self.arrayModel[indexPath.row] valueForKey:@"id_AA"];
        [self presentViewController:pages animated:NO completion:^{
            
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.HTTPMethod == 1) {
        return 100;
    }else{
        return 60;
    }
}

@end

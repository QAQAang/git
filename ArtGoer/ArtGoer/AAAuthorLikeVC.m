//
//  AAAuthorLikeVC.m
//  ArtGoer
//
//  Created by dllo on 16/4/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AAAuthorLikeVC.h"
#import "AuthorLikeCell.h"
#import "WaterLayout.h"
#import "AA_opusWorkModel.h"
#import "AA_opusPicVC.h"
@interface AAAuthorLikeVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) UICollectionView *collection;

@property (nonatomic, retain) UIView *headView;

@property (nonatomic, retain) NSMutableArray *dataArr;

@property (nonatomic, retain) WaterLayout *layout;

@property (nonatomic, retain) UICollectionViewFlowLayout *nonLayout;

@end

@implementation AAAuthorLikeVC

- (void)viewDidLoad{
    [super viewDidLoad];
    [self creatHeadView];
    [self creatCollection];
    [self getTaskData];
}

- (void)getTaskData{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/new_likes?pageIndex=1&token=07d48315-f9be-4d20-a2db-657f7284ad5c&otherUserId=%@", self.userId]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:&error]);
        self.dataArr = [[[NSJSONSerialization JSONObjectWithData:data options:0 error:&error] valueForKey:@"data"] valueForKey:@"works"];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.dataArr.count == 0) {
                self.collection.collectionViewLayout = self.nonLayout;
            }else{
                self.collection.collectionViewLayout = self.layout;
            }
            [self.collection reloadData];
        });
    }]resume];
}

- (void)creatCollection{
    self.layout = [[WaterLayout alloc] init];
    self.layout.lineNumber = 2;
    self.layout.lineSpacing = 10;
    self.layout.rowSpacing = 10;
    self.layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    [self.layout computeIndexCellHeightWithWidthBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
        CGFloat height = [[self.dataArr[indexPath.row] valueForKey:@"worksHeight"] floatValue] * width / [[self.dataArr[indexPath.row] valueForKey:@"worksWidth"] floatValue] + 60;
        return height;
    }];
    self.nonLayout = [[UICollectionViewFlowLayout alloc] init];
    self.nonLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.nonLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 70);
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 60) collectionViewLayout:self.layout];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.backgroundColor = [UIColor whiteColor];
    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"none"];
    [self.collection registerClass:[AuthorLikeCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collection];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataArr.count == 0) {
        return 1;
    }else{
        return self.dataArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArr.count == 0) {
        UICollectionViewCell *noneCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"none" forIndexPath:indexPath];
        UILabel *label = [[UILabel alloc] initWithFrame:collectionView.frame];
        label.textColor = [UIColor grayColor];
        label.text = @"没找到, 汪!";
        label.font = [UIFont systemFontOfSize:19];
        label.textAlignment = NSTextAlignmentCenter;
        if (noneCell.subviews.count == 1) {
            [noneCell.contentView addSubview:label];
        }
        return noneCell;
    }else{
        AuthorLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.dataDic = self.dataArr[indexPath.row];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArr.count != 0) {
        AA_opusWorkModel *model = [AA_opusWorkModel modelWithDic:self.dataArr[indexPath.row]];
        AA_opusPicVC *opusPic = [[AA_opusPicVC alloc] init];
        opusPic.model = model;
        [self presentViewController:opusPic animated:YES completion:^{
            
        }];
    }
}

- (void)creatHeadView{
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 50)];
    self.headView.backgroundColor = [UIColor whiteColor];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle: @"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(5, 10, 40, 30);
    backButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:backButton];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 25, 10, 50, 30)];
    title.text = @"喜欢";
    title.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:title];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.headView addSubview:line1];
    [self.view addSubview:self.headView];
}

- (void)clickBack{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end

//
//  AA_onePageRootVC.m
//  ArtGoer
//
//  Created by dllo on 16/3/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_onePageRootVC.h"
#import "AA_onePageVC.h"
#import "AA_pageCollectionCell.h"
@interface AA_onePageRootVC ()<UIScrollViewDelegate, onePageDelegate>

//@property (nonatomic, retain) UICollectionView *collection;

@property (nonatomic, retain) UIScrollView *contentView;

@property (nonatomic, retain) UIView *headView;

@end

@implementation AA_onePageRootVC


- (void)viewDidLoad{
    [super viewDidLoad];
    [self addChildVC];
    [self creatScroll];
    [self creatHeadView];
//    [self creatCollection];
//    [self.collection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.itemCount inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
}

- (void)addChildVC{
    for (int i = 0; i < self.arrayModel.count; i++) {
        AA_detailOnePageModel *model = self.arrayModel[i];
        AA_onePageVC *page = [[AA_onePageVC alloc] init];
        page.model = model;
        page.exhibitID = self.exhibitID;
        page.delegate = self;
        [self addChildViewController:page];
    }
}
/*
//- (void)creatCollection{
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    layout.minimumInteritemSpacing = 0;
//    layout.minimumLineSpacing = 0;
//    layout.itemSize = [UIScreen mainScreen].bounds.size;
//    self.collection = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
//    self.collection.delegate = self;
//    self.collection.dataSource = self;
//    self.collection.pagingEnabled = YES;
//    self.collection.backgroundColor = [UIColor whiteColor];
//    [self.collection registerClass:[AA_pageCollectionCell class] forCellWithReuseIdentifier:@"cell"];
//    [self.view addSubview:self.collection];
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.childViewControllers.count;
//}
//
//- (AA_pageCollectionCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    AA_pageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    [cell.pageView addSubview:self.childViewControllers[indexPath.row].view];
//    return cell;
//}
*/

- (void)creatScroll{
    self.contentView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.contentView.pagingEnabled = YES;
    self.contentView.delegate = self;
    self.contentView.bounces = NO;
    self.contentView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width * self.itemCount, 0);
    self.contentView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.childViewControllers.count, [UIScreen mainScreen].bounds.size.height);
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [view addSubview:[self.childViewControllers[i] valueForKey:@"view"]];
        [self.contentView addSubview:view];
    }
    [self.view addSubview:self.contentView];
}

- (void)creatHeadView{
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 50)];
    self.headView.backgroundColor = [UIColor clearColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 5, 40, 40);
    button.backgroundColor = [UIColor blackColor];
    button.layer.cornerRadius = 20;
    button.clipsToBounds = YES;
    button.alpha = 0.6;
    [button setImage:[UIImage imageNamed:@"btn_back_normal"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:button];
    [self.view addSubview:self.headView];
}

- (void)changeHeadView:(CGPoint)new :(CGPoint)old{
    if (self.headView.frame.origin.y == 20) {
        if (old.y - new.y <= -20) {
            [UIView animateWithDuration:0.6 animations:^{
                CGRect frame = self.headView.frame;
                frame.origin.y = - 30;
                self.headView.frame = frame;
            }];
        }
    }else if (self.headView.frame.origin.y == -30){
        if (old.y - new.y >= 20) {
            [UIView animateWithDuration:0.6 animations:^{
                CGRect frame = self.headView.frame;
                frame.origin.y = 20;
                self.headView.frame = frame;
            }];
        }
    }
}

- (void)clickBack{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end

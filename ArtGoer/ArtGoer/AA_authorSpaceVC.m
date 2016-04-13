//
//  AA_authorSpaceVC.m
//  ArtGoer
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_authorSpaceVC.h"
#import "AA_authorLayout.h"
#import "UIImageView+WebCache.h"
#import "AA_detailOnePageModel.h"
#import "AA_authorCollectionCell.h"
#import "AA_sqliteAuthor.h"
#import "AAIntroductionVC.h"
#import "AAAuthorExhibitVC.h"
#import "AAAuthorLikeVC.h"
@interface AA_authorSpaceVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UIImageView *headPic;

@property (nonatomic, retain) UIScrollView *contentView;

@property (nonatomic, retain) UILabel *authorLabel;

@property (nonatomic, retain) UILabel *viewerNum;

@property (nonatomic, retain) UIButton *addButton;

@property (nonatomic, retain) UICollectionView *menuCollection;

@property (nonatomic, retain) UICollectionView *picCollection;

@property (nonatomic, retain) UIView *headView;

@property (nonatomic, retain) NSMutableArray *arrayMenu;

@property (nonatomic, retain) NSMutableArray *arrayPic;

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, copy) NSString *picUrl;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, retain) NSMutableDictionary *dic;

@end

@implementation AA_authorSpaceVC

- (NSMutableArray *)arrayPic{
    if (_arrayPic == nil) {
        _arrayPic = [NSMutableArray array];
    }
    return _arrayPic;
}

- (NSMutableArray *)arrayMenu{
    if (_arrayMenu == nil) {
        _arrayMenu = [NSMutableArray arrayWithObjects: @"简介", @"展览", @"喜欢", @"收藏", @"点评", @"粉丝", @"关注", nil];
    }
    return _arrayMenu;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self creatHeadView];
    [self creatContent];
    [self getTaskData];
}

- (void)getTaskData{
//
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/artist/listAllArtisWorks?userId=%@&token=07d48315-f9be-4d20-a2db-657f7284ad5c", self.userId]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableArray *array = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] valueForKey:@"data"];
        self.arrayPic = [AA_detailOnePageModel getPageModel:array];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.picCollection reloadData];
        });
    }] resume];
}

- (void)creatContent{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/baseInfo?token=07d48315-f9be-4d20-a2db-657f7284ad5c&otherUserId=%@", self.userId]]];
    self.dic = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] valueForKey:@"data"];
    
    self.contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 70)];
    self.contentView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 100);
    [self.view addSubview:self.contentView];
    // 头像
    self.headPic = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width  / 2 - 50  * AWIDTH, 20, 100 * AWIDTH, 100 * AHEIGHT)];
    self.picUrl = [self.dic valueForKey:@"headPic"];
    [self.headPic sd_setImageWithURL:[NSURL URLWithString:[self.dic valueForKey:@"headPic"]] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    self.headPic.layer.cornerRadius = 50  * AWIDTH;
    self.headPic.clipsToBounds = YES;
    [self.contentView addSubview:self.headPic];
    // 名字
    self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 125, [UIScreen mainScreen].bounds.size.width, 20)];
    self.userName = [self.dic valueForKey:@"userName"];
    self.authorLabel.text = [NSString stringWithFormat:@"%@的线上展厅",[self.dic valueForKey:@"userName"]];
    self.authorLabel.textAlignment = 1;
    self.authorLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17 * AWIDTH];
    [self.contentView addSubview:self.authorLabel];
    // 访问
    self.viewerNum = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100  * AWIDTH, 155, 200 * AWIDTH, 15)];
    self.viewerNum.textAlignment = 1;
    self.viewerNum.text = [NSString stringWithFormat:@"浏览:%@", [self.dic valueForKey:@"viewerNum"]];
    self.viewerNum.font = [UIFont systemFontOfSize:14 * AWIDTH];
    self.viewerNum.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.viewerNum];
    // 收藏按钮
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
#warning mark !!!!!!!! 收藏
    if ([AA_sqliteAuthor selectUserByTitle:self.userName].count == 0) {
        [self.addButton setTitle:@"+ 关注" forState:UIControlStateNormal];
    }else{
        [self.addButton setTitle:@"已关注" forState:UIControlStateNormal];
    }
    self.addButton.titleLabel.font = [UIFont systemFontOfSize:15 * AWIDTH];
    self.addButton.layer.borderWidth = 2;
    [self.addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.addButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.addButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 25, 180, 50 * AWIDTH, 20);
    [self.addButton addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.addButton];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 6, 30);
    self.menuCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 210, [UIScreen mainScreen].bounds.size.width, 30) collectionViewLayout:layout];
    self.menuCollection.delegate = self;
    self.menuCollection.dataSource = self;
    self.menuCollection.bounces = NO;
    self.menuCollection.showsHorizontalScrollIndicator = NO;
    self.menuCollection.showsVerticalScrollIndicator = NO;
    self.menuCollection.backgroundColor = [UIColor whiteColor];
    [self.menuCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.contentView addSubview:self.menuCollection];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 249, [UIScreen mainScreen].bounds.size.width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
    AA_authorLayout *picLayout = [[AA_authorLayout alloc] init];
    self.picCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 250, [UIScreen mainScreen].bounds.size.width, self.contentView.contentSize.height - 250) collectionViewLayout:picLayout];
    self.picCollection.delegate = self;
    self.picCollection.dataSource = self;
    self.picCollection.bounces = NO;
    self.picCollection.showsHorizontalScrollIndicator = NO;
    self.picCollection.showsVerticalScrollIndicator = NO;
    self.picCollection.backgroundColor = [UIColor whiteColor];
    [self.picCollection registerClass:[AA_authorCollectionCell class] forCellWithReuseIdentifier:@"author"];
    [self.contentView addSubview:self.picCollection];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.menuCollection) {
        return self.arrayMenu.count;
    }else{
        return self.arrayPic.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.menuCollection) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 6, 30)];
        label.text = self.arrayMenu[indexPath.row];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = 1;
        [cell.contentView addSubview:label];
        return cell;
    }else{
        AA_authorCollectionCell *author = [collectionView dequeueReusableCellWithReuseIdentifier:@"author" forIndexPath:indexPath];
        author.model = self.arrayPic[indexPath.row];
        if (indexPath.row == 0) {
            self.x = author.frame.origin.x;
        }
        return author;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.menuCollection) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width / 6, 30);
    }else{
        return CGSizeMake(250 * AWIDTH, 250 * AHEIGHT / [[self.arrayPic[indexPath.row] valueForKey:@"worksWidth"] floatValue] * [[self.arrayPic[indexPath.row] valueForKey:@"worksHeight"] floatValue]);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.menuCollection) {
        if (indexPath.row == 0) {
            AAIntroductionVC *intro = [[AAIntroductionVC alloc] init];
            intro.introduction = [self.dic valueForKey:@"personalProfile"];
            [self presentViewController:intro animated:YES completion:^{
                
            }];
        }else if (indexPath.row == 1){
            AAAuthorExhibitVC *aExhibit = [[AAAuthorExhibitVC alloc] init];
            aExhibit.userId = [self.dic valueForKey:@"id"];
            [self presentViewController:aExhibit animated:YES completion:^{
                
            }];
        }else if (indexPath.row == 2){
            AAAuthorLikeVC *alike = [[AAAuthorLikeVC alloc] init];
            alike.userId = [self.dic valueForKey:@"id"];
            [self presentViewController:alike animated:YES completion:^{
                
            }];
        }
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
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.headView addSubview:line1];
    [self.view addSubview:self.headView];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSInteger count = 300 * AWIDTH;
    if ((NSInteger)self.picCollection.contentOffset.x % count - 165 * AWIDTH > 0) {
        [self.picCollection setContentOffset:CGPointMake(self.x * AWIDTH - 60 * AWIDTH + count * (NSInteger)(self.picCollection.contentOffset.x / (count)) + count, 0) animated:YES];
    }else{
        [self.picCollection setContentOffset:CGPointMake(self.x * AWIDTH - 60 * AWIDTH + count * (NSInteger)(self.picCollection.contentOffset.x / (count)), 0) animated:YES];
    }
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSInteger count = 300 * AWIDTH;
    if ((NSInteger)self.picCollection.contentOffset.x % count - 165 * AWIDTH > 0) {
        
        [self.picCollection setContentOffset:CGPointMake(self.x * AWIDTH - 60 * AWIDTH + count * (NSInteger)(self.picCollection.contentOffset.x / (count)) + count, 0) animated:YES];
    }else{
        [self.picCollection setContentOffset:CGPointMake(self.x * AWIDTH - 60 * AWIDTH + count * (NSInteger)(self.picCollection.contentOffset.x / (count)), 0) animated:YES];
    }
}

- (void)clickBack{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)clickAdd{
    if ([AA_sqliteAuthor selectUserByTitle:self.userName].count == 0) {
        [AA_sqliteAuthor insertUserWithTitle:self.userName PicUrl:self.picUrl Url:self.userId];
        [self.addButton setTitle:@"已关注" forState:UIControlStateNormal];
    }else{
        [AA_sqliteAuthor deleteUserWithTitle:self.userName];
        [self.addButton setTitle:@"+ 关注" forState:UIControlStateNormal];
    }
}

@end

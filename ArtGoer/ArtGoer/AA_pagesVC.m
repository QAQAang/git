//
//  AA_pagesVC.m
//  ArtGoer
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_pagesVC.h"
#import "AA_detailPagesModel.h"
#import "AA_detailOnePageModel.h"
#import "UIImageView+WebCache.h"
#import "AA_adaptivelyHW.h"
#import "AA_ galleryView.h"
#import "AA_onePageVC.h"
#import "AA_onePageRootVC.h"
#import "AA_sqliteExhibit.h"
@interface AA_pagesVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIWebViewDelegate>

@property (nonatomic, retain) AA_detailPagesModel *modelPages;

@property (nonatomic, retain) UIView *headView;

@property (nonatomic, retain) UIScrollView *contentView;

@property (nonatomic, retain) UICollectionView *picCollection;

@property (nonatomic, retain) UILabel *titleLabel;

@property (nonatomic, retain) UILabel *nameLabel;

@property (nonatomic, retain) UILabel *artistLabel;

@property (nonatomic, retain) AA__galleryView *galleryView;

@property (nonatomic, retain) UIWebView *webView;

@property (nonatomic, retain) NSTimer *time;

@property (nonatomic, assign) CGFloat beginDragg;

@property (nonatomic, retain) UIButton *collectBtn;

@end

@implementation AA_pagesVC

- (void)viewDidLoad{
    [super viewDidLoad];
    [self creatContentView];
    [self creatHeadView];
    [self getTaskData];
}

- (void)getTaskData{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/exhibit/%@?token=07d48315-f9be-4d20-a2db-657f7284ad5c", self.exhibitID]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableDictionary *dataDic = [[NSJSONSerialization JSONObjectWithData:data options:0 error:&error] valueForKey:@"data"];
        self.modelPages = [AA_detailPagesModel getDetailModel:dataDic];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.titleLabel.text = [NSString stringWithFormat:@"共%ld件作品", (unsigned long)self.modelPages.works.count];
            [self.picCollection reloadData];
            self.nameLabel.text = self.modelPages.name;
            self.nameLabel.frame = CGRectMake(5, 620, [UIScreen mainScreen].bounds.size.width - 10, [AA_adaptivelyHW getHeight:self.modelPages.name :[UIScreen mainScreen].bounds.size.width - 10 :18]);
            self.artistLabel.text = [NSString stringWithFormat:@"艺术家:%@", self.modelPages.artist];
            self.artistLabel.frame = CGRectMake(10, 620 + [AA_adaptivelyHW getHeight:self.modelPages.name :[UIScreen mainScreen].bounds.size.width - 10 :18] + 10, [UIScreen mainScreen].bounds.size.width - 15, [AA_adaptivelyHW getHeight:self.modelPages.artist :[UIScreen mainScreen].bounds.size.width - 10 :15]);
            self.galleryView.frame = CGRectMake(0, 620 + self.nameLabel.frame.size.height + self.artistLabel.frame.size.height + 30, [UIScreen mainScreen].bounds.size.width, 100);
            [self.galleryView.imageView sd_setImageWithURL:[NSURL URLWithString:self.modelPages.gallery.galleryPic] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
            self.galleryView.galleryLabel.text = self.modelPages.galleryName;
            self.contentView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 760 + self.nameLabel.frame.size.height + self.artistLabel.frame.size.height);
            NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.modelPages.exhibitDesc]];
            [self.webView loadRequest:request];
        });
    }] resume];
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
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 75, 10, 150, 30)];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.textAlignment = 1;
    [self.headView addSubview:self.titleLabel];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 45, 10, 40, 30);
    if ([AA_sqliteExhibit selectUserByTitle:self.modelPages.artist].count == 0) {
        [self.collectBtn setImage:[UIImage imageNamed:@"off.jpg"] forState:UIControlStateNormal];
    }else{
        [self.collectBtn setImage:[UIImage imageNamed:@"on"] forState:UIControlStateNormal];
    }
    [self.collectBtn addTarget:self action:@selector(clickCollect) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.collectBtn];
    [self.headView addSubview:line1];
    [self.view addSubview:self.headView];
}

- (void)clickBack{
    [self.contentView removeObserver:self forKeyPath:@"contentOffset"];
    [self.time invalidate];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)creatContentView{
    self.contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.contentView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 50);
    self.contentView.delegate = self;
    [self.contentView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 5;
    layout.itemSize = CGSizeMake(250, 250);
    self.picCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, 540) collectionViewLayout:layout];
    self.picCollection.backgroundColor = [UIColor whiteColor];
    self.picCollection.delegate = self;
    self.picCollection.dataSource = self;
    [self.picCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"pic"];
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 620, [UIScreen mainScreen].bounds.size.width - 10, 30)];
    self.nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.nameLabel.numberOfLines = 0;
    [self.contentView addSubview:self.nameLabel];
    self.artistLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 660, [UIScreen mainScreen].bounds.size.width - 10, 20)];
    self.artistLabel.font = [UIFont systemFontOfSize:15];
    self.artistLabel.numberOfLines = 0;
    self.artistLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.artistLabel];
    self.galleryView = [[AA__galleryView alloc] initWithFrame:CGRectMake(0, 700, [UIScreen mainScreen].bounds.size.width, 100)];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.webView.delegate = self;
    self.webView.hidden = YES;
    self.webView.scrollView.scrollEnabled = NO;
    [self.contentView addSubview:self.webView];
    [self.contentView addSubview:self.galleryView];
    [self.contentView addSubview:self.picCollection];
    [self.view addSubview:self.contentView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelPages.works.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pic" forIndexPath:indexPath];
    AA_detailOnePageModel *model = self.modelPages.works[indexPath.row];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250 * [model.worksWidth floatValue] / [model.worksHeight floatValue], 250 )];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.worksPic] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    imageView.layer.borderWidth = 0.5;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.shadowOpacity = 0.6;
    imageView.layer.shadowOffset = CGSizeMake(0, 3);                        
    cell.backgroundView = imageView;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    AA_detailOnePageModel *model = self.modelPages.works[indexPath.row];
    return CGSizeMake(250 * [model.worksWidth floatValue] / [model.worksHeight floatValue], 250);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AA_onePageRootVC *page = [[AA_onePageRootVC alloc] init];
    page.arrayModel = self.modelPages.works;
    page.itemCount = indexPath.row;
    page.exhibitID = self.exhibitID;
    [self presentViewController:page animated:YES completion:^{
        
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGRect frame = webView.frame;
    frame.origin.y = self.contentView.frame.size.height  + 10;
    frame.size.height = webView.scrollView.contentSize.height;
    webView.frame = frame;
    CGSize size = self.contentView.contentSize;
    size.height = size.height + webView.scrollView.contentSize.height;
    self.contentView.contentSize = size;
    webView.hidden = NO;
    self.time = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(changeOffset) userInfo:nil repeats:YES];
}

- (void)changeOffset{
    self.picCollection.contentOffset = CGPointMake(self.picCollection.contentOffset.x + 1, 0);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.time invalidate];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    CGSize new =[[change valueForKey:@"new"] CGSizeValue];
    CGSize old = [[change valueForKey:@"old"] CGSizeValue];
    if (self.headView.frame.origin.y == 20) {
        if (old.height - new.height <= -20) {
            [UIView animateWithDuration:0.6 animations:^{
                CGRect frame = self.headView.frame;
                frame.origin.y = - 30;
                self.headView.frame = frame;
            }];
        }
    }else if (self.headView.frame.origin.y == -30){
        if (old.height - new.height >= 20) {
            [UIView animateWithDuration:0.6 animations:^{
                CGRect frame = self.headView.frame;
                frame.origin.y = 20;
                self.headView.frame = frame;
            }];
        }
    }
}

- (void)clickCollect{
    if ([AA_sqliteExhibit selectUserByTitle:self.modelPages.artist].count == 0) {
        [AA_sqliteExhibit insertUserWithTitle:self.modelPages.artist PicUrl:self.modelPages.exhibitPic Url:self.exhibitID];
        [self.collectBtn setImage:[UIImage imageNamed:@"on"] forState:UIControlStateNormal];
    }else{
        [AA_sqliteExhibit deleteUserWithTitle:self.modelPages.artist];
        [self.collectBtn setImage:[UIImage imageNamed:@"off.jpg"] forState:UIControlStateNormal];
    }
}

@end

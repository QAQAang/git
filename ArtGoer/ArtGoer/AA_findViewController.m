//
//  AA_findViewController.m
//  ArtGoer
//
//  Created by dllo on 16/3/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_findViewController.h"
#import "AA_exhibitVC.h"
#import "AA_menuCollectionCell.h"
#import "AA_exhibitVC.h"
#import "AA_pagesVC.h"
#import "AA_onePageRootVC.h"
#import "AA_opusVC.h"
#import "AA_authorVC.h"
#import "AA_InstitutionVC.h"
#import "AA_searchVC.h"
@interface AA_findViewController ()<UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ExhibitVCDelegate, opusVCdelegate, authorVCDelegate, institutionDelegate>

@property (nonatomic, retain) UIView *headView;

@property (nonatomic, retain) UIButton *screeningButton;

@property (nonatomic, retain) UIButton *searchButton;

@property (nonatomic, retain) UIView *menuView;

@property (nonatomic, retain) UICollectionView *menuCollection;

@property (nonatomic, retain) NSMutableArray *arrayMenutxt;

@property (nonatomic, retain) UIScrollView *contentScroll;

@property (nonatomic, retain) UIView *contentView;

@property (nonatomic, retain) UIView *scrollLine;

@property (nonatomic, assign) BOOL pick;

@end

@implementation AA_findViewController

- (NSMutableArray *)arrayMenutxt{
    if (_arrayMenutxt == nil) {
        _arrayMenutxt = [NSMutableArray arrayWithObjects:@"展览", @"作品", @"艺术家", @"机构", nil];
    }
    return _arrayMenutxt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pick = YES;
    [self addchildVC];
    [self creatHeadView];
    [self creatScroll];
}

- (void)addchildVC{
    AA_exhibitVC *exhibit = [[AA_exhibitVC alloc] init];
    exhibit.delegate = self;
    [self addChildViewController:exhibit];
    AA_opusVC *opus = [[AA_opusVC alloc] init];
    opus.delegate = self;
    [self addChildViewController:opus];
    AA_authorVC *author = [[AA_authorVC alloc] init];
    author.delegate = self;
    [self addChildViewController:author];
    AA_InstitutionVC *institution = [[AA_InstitutionVC alloc] init];
    institution.delegate = self;
    [self addChildViewController:institution];
}

- (void)creatScroll{
    self.contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 90, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 149)];
    self.contentScroll.pagingEnabled = YES;
    self.contentScroll.delegate = self;
    self.contentScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, [UIScreen mainScreen].bounds.size.height - 149);
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [view addSubview:[self.childViewControllers[i] valueForKey:@"view"]];
        [self.contentScroll addSubview:view];
    }
    [self.contentView addSubview:self.contentScroll];
}

-(void)creatHeadView{
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20)];
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    self.screeningButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.screeningButton.frame = CGRectMake(5, 10, 40, 30);
    [self.screeningButton setTitle:@"地区" forState:UIControlStateNormal];
    [self.screeningButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.screeningButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.screeningButton addTarget:self action:@selector(clickToScreening) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.screeningButton];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 30, 10, 60, 30)];
    title.text = @"发现";
    title.font = [UIFont systemFontOfSize:16];
    [self.headView addSubview:title];
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 10, 40, 30);
    [self.searchButton addTarget:self action:@selector(clickToSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.searchButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.headView addSubview:self.searchButton];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.headView addSubview:line1];
    [self.contentView addSubview:self.headView];
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 40)];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 39, [UIScreen mainScreen].bounds.size.width, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 4, 40);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    self.menuCollection = [[UICollectionView alloc] initWithFrame:CGRectMake( 0, 0, [UIScreen mainScreen].bounds.size.width, 40) collectionViewLayout:layout];
    self.menuCollection.delegate = self;
    self.menuCollection.dataSource = self;
    self.menuCollection.backgroundColor = [UIColor whiteColor];
    self.scrollLine = [[UIView alloc] initWithFrame:CGRectMake(0, 37, [UIScreen mainScreen].bounds.size.width / 4, 2)];
    self.scrollLine.backgroundColor = [UIColor blackColor];
    [self.menuCollection registerClass:[AA_menuCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    [self.menuView addSubview:self.menuCollection];
    [self.menuView addSubview:self.scrollLine];
    [self.menuView addSubview:line2];
    [self.contentView addSubview:self.menuView];
    [self.view addSubview:self.contentView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayMenutxt.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AA_menuCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.arrayMenutxt[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.contentScroll scrollRectToVisible:CGRectMake([UIScreen mainScreen].bounds.size.width * indexPath.row , 90, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 149) animated:YES];
    self.pick = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollLine.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 4 * indexPath.row, 37, [UIScreen mainScreen].bounds.size.width / 4, 2);
    } completion:^(BOOL finished) {
        self.pick = YES;
    }];
    
}

- (void)clickToScreening{
}

- (void)clickToSearch{
    AA_searchVC *search = [[AA_searchVC alloc] init];
    [self presentViewController:search animated:YES completion:^{
        
    }];
}

- (void)changeOrigin:(CGFloat)y{
    if (self.contentView.frame.origin.y <= 20 && self.contentView.frame.origin.y >= -30) {
        CGRect frame = self.contentView.frame;
        if (self.contentView.frame.origin.y - y > 20 || self.contentView.frame.origin.y - y < - 30) {
            return;
        }
        frame.origin.y = self.contentView.frame.origin.y - y;
        self.contentView.frame = frame;
    }
}

- (void)endScroll{
    if (self.contentView.frame.origin.y >= -27) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.contentView.frame;
            frame.origin.y = 20;
            self.contentView.frame = frame;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.contentView.frame;
            frame.origin.y = -30;
            self.contentView.frame = frame;
        }];
    }
}

- (void)nextViewController:(NSString *)exhibitID{
    AA_pagesVC *pages = [[AA_pagesVC alloc] init];
    pages.exhibitID = exhibitID;
    [self presentViewController:pages animated:YES completion:^{
        
    }];
}

- (void)goInside:(NSInteger)count ExhibitID:(NSString *)exhibitID Models:(NSMutableArray *)array{
    AA_onePageRootVC *page = [[AA_onePageRootVC alloc] init];
    page.arrayModel = array;
    page.itemCount = count;
    page.exhibitID = exhibitID;
    [self presentViewController:page animated:YES completion:^{
        
    }];
}

- (void)institutionTopagesExid:(NSString *)exid{
    AA_pagesVC *pages = [[AA_pagesVC alloc] init];
    pages.exhibitID = exid;
    [self presentViewController:pages animated:YES completion:^{
        
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (self.pick) {
        CGFloat x = self.contentScroll.contentOffset.x / ([UIScreen mainScreen].bounds.size.width * 4) * ([UIScreen mainScreen].bounds.size.width);
        self.scrollLine.frame = CGRectMake(x, 37, [UIScreen mainScreen].bounds.size.width / 4, 2);
    }
    if (self.contentScroll.contentOffset.x > [UIScreen mainScreen].bounds.size.width / 4) {
        self.screeningButton.hidden = YES;
    }else{
        self.screeningButton.hidden = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.contentScroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view.layer removeAllAnimations];
    [self.contentScroll removeObserver:self forKeyPath:@"contentOffset"];
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

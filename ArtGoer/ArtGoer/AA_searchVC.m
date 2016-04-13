//
//  AA_searchVC.m
//  ArtGoer
//
//  Created by dllo on 16/3/10.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_searchVC.h"
#import "AA_searchPageVC.h"
#import "AA_menuCollectionCell.h"
@interface AA_searchVC ()<UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>

@property (nonatomic, retain) AA_searchPageVC *exhibit;

@property (nonatomic, retain) AA_searchPageVC *ins;

@property (nonatomic, retain) AA_searchPageVC *talents;

@property (nonatomic, retain) AA_searchPageVC *arts;

@property (nonatomic, retain) UIView *headView;

@property (nonatomic, retain) UIButton *backButton;

@property (nonatomic, retain) UISearchBar *search;

@property (nonatomic, retain) UIView *menuView;

@property (nonatomic, retain) UICollectionView *menuCollection;

@property (nonatomic, retain) NSMutableArray *arrayMenutxt;

@property (nonatomic, retain) UIScrollView *contentScroll;

@property (nonatomic, retain) UIView *contentView;

@property (nonatomic, retain) UIView *scrollLine;

@property (nonatomic, assign) BOOL pick;

@end

@implementation AA_searchVC

- (NSMutableArray *)arrayMenutxt{
    if (_arrayMenutxt == nil) {
        _arrayMenutxt = [NSMutableArray arrayWithObjects:@"展览", @"机构", @"达人", @"艺术家", nil];
    }
    return _arrayMenutxt;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self addChildVC];
    [self creatHeadView];
    [self creatScroll];
    [self creatSearchBar];
}

- (void)addChildVC{
    self.exhibit = [[AA_searchPageVC alloc] init];
    self.exhibit.HTTPMethod = 1;
    [self addChildViewController:self.exhibit];
    self.ins = [[AA_searchPageVC alloc] init];
    self.ins.HTTPMethod = 0;
    self.ins.searchType = @"gallery";
    [self addChildViewController:self.ins];
    self.talents = [[AA_searchPageVC alloc] init];
    self.talents.HTTPMethod = 0;
    self.talents.searchType = @"talents";
    [self addChildViewController:self.talents];
    self.arts = [[AA_searchPageVC alloc] init];
    self.arts.HTTPMethod = 0;
    self.arts.searchType = @"arts";
    [self addChildViewController:self.arts];
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
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(5, 10, 40, 30);
    [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.backButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.backButton];
    
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

- (void)creatSearchBar{
    self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(50, 5, [UIScreen mainScreen].bounds.size.width - 60, 40)];
    self.search.searchBarStyle = UISearchBarStyleMinimal;
    self.search.delegate = self;
    [self.headView addSubview:self.search];
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
    if (indexPath.row == 0) {
        [self.exhibit getTaskData];
    }else if (indexPath.row == 1){
        [self.ins getTaskData];
    }else if (indexPath.row == 2){
        [self.talents getTaskData];
    }else{
        [self.arts getTaskData];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (self.pick) {
        CGFloat x = self.contentScroll.contentOffset.x / ([UIScreen mainScreen].bounds.size.width * 4) * ([UIScreen mainScreen].bounds.size.width);
        self.scrollLine.frame = CGRectMake(x, 37, [UIScreen mainScreen].bounds.size.width / 4, 2);
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.exhibit.searchText = searchText;
    self.ins.searchText = searchText;
    self.talents.searchText = searchText;
    self.arts.searchText = searchText;
    NSInteger x = self.contentScroll.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    if (x == 0) {
        [self.exhibit getTaskData];
    }else if (x == 1){
        [self.ins getTaskData];
    }else if (x == 2){
        [self.talents getTaskData];
    }else{
        [self.arts getTaskData];
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

- (void)clickBack{
    [self dismissViewControllerAnimated:YES completion:^{
         
    }];
}

@end

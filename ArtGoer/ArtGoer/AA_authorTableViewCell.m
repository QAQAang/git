//
//  AA_authorTableViewCell.m
//  ArtGoer
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_authorTableViewCell.h"
#import "AA_detailOnePageModel.h"
#import "UIImageView+WebCache.h"
#import "AA_sqliteAuthor.h"
@interface AA_authorTableViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UIImageView *imageView_headPic;

@property (nonatomic, retain) UILabel *textLabel_author;

@property (nonatomic, retain) UILabel *textLabel_worksNum;



@property (nonatomic, retain) UICollectionView *collection;

@end

@implementation AA_authorTableViewCell

- (void)setModel:(AA_authorModel *)model{
    _model = model;
    [self.imageView_headPic sd_setImageWithURL:[NSURL URLWithString:model.headPic] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    self.textLabel_author.text = self.model.userName;
    self.textLabel_worksNum.text = [NSString stringWithFormat:@"作品:%@   粉丝:%@", self.model.worksNum, self.model.fansNum];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.imageView_headPic = [[UIImageView alloc] init];
    self.imageView_headPic.layer.cornerRadius = 25;
    self.imageView_headPic.clipsToBounds = YES;
    [self.contentView addSubview:self.imageView_headPic];
    self.textLabel_author = [[UILabel alloc] init];
    self.textLabel_author.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.textLabel_author];
    self.textLabel_worksNum = [[UILabel alloc] init];
    self.textLabel_worksNum.font = [UIFont systemFontOfSize:14];
    self.textLabel_worksNum.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.textLabel_worksNum];
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.addButton];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 5;
    layout.itemSize = CGSizeMake(125, 125);
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 60, [UIScreen mainScreen].bounds.size.width - 10, 150) collectionViewLayout:layout];
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.contentView addSubview:self.collection];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.exhibitWorkVos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    AA_detailOnePageModel *model = self.model.exhibitWorkVos[indexPath.row];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125 * [model.worksWidth floatValue] / [model.worksHeight floatValue], 125 )];
    [image sd_setImageWithURL:[NSURL URLWithString:model.worksPic] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    cell.backgroundView = image;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate clickItem:indexPath.row Exid:[self.model.exhibitWorkVos[indexPath.row] valueForKey:@"exhibitId"] Models:self.model.exhibitWorkVos];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView_headPic.frame = CGRectMake(10, 5, 50, 50);
    self.textLabel_author.frame = CGRectMake(65, 10, 100, 20);
    self.textLabel_worksNum.frame = CGRectMake(65, 35, 200, 15);
    self.addButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 25, 30, 30);
    
}

- (void)click{
    if ([AA_sqliteAuthor selectUserByTitle:self.model.userName].count == 0) {
        [AA_sqliteAuthor insertUserWithTitle:self.model.userName PicUrl:self.model.headPic Url:self.model.id_AA];
        [self.addButton setImage:[UIImage imageNamed:@"iconfont-jiantou"] forState:UIControlStateNormal];
    }else{
        [self.delegate clickButtonId:self.model.id_AA];
    }
}

@end

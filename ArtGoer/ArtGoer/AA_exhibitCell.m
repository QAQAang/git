//
//  AA_exhibitCell.m
//  ArtGoer
//
//  Created by dllo on 16/3/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_exhibitCell.h"
#import "AA_exhibitModel.h"
#import "UIImageView+WebCache.h"
#import "AA_baseCollectionCell.h"
@interface AA_exhibitCell ()

@end

@implementation AA_exhibitCell

- (NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)setModel:(AA_exhibitModel *)model{
    _model = model;
    self.textLabel_name.text = model.name;
    self.textLabel_galleryName_time.text = [NSString stringWithFormat:@"%@ | %@\n%@%@", model.galleryName, model.exhibitCity, [model.exhibitStartDate substringToIndex:9], [model.exhibitEndDate substringWithRange:NSMakeRange(4, 6)]];
    self.textLabel_totalViewNums.text = [NSString stringWithFormat:@"浏览%@", model.totalViewNums];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.textLabel_name = [[UILabel alloc] init];
    self.textLabel_name.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.textLabel_name];
    self.textLabel_galleryName_time = [[UILabel alloc] init];
    self.textLabel_galleryName_time.font = [UIFont systemFontOfSize:12];
    self.textLabel_galleryName_time.textColor = [UIColor grayColor];
    self.textLabel_galleryName_time.numberOfLines = 2;
    [self.contentView addSubview:self.textLabel_galleryName_time];
    self.textLabel_totalViewNums = [[UILabel alloc] init];
    self.textLabel_totalViewNums.font = [UIFont systemFontOfSize:13];
    self.textLabel_totalViewNums.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.textLabel_totalViewNums];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.itemSize = CGSizeMake(90, 125);
    self.collections = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 75, [UIScreen mainScreen].bounds.size.width - 10, 150) collectionViewLayout:layout];
    self.collections.backgroundColor = [UIColor whiteColor];
    self.collections.delegate = self;
    self.collections.dataSource = self;
    [self.collections registerClass:[AA_baseCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    [self.contentView addSubview:self.collections];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 224, [UIScreen mainScreen].bounds.size.width - 20, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel_name.frame = CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 20);
    self.textLabel_galleryName_time.frame = CGRectMake(10, 30, [UIScreen mainScreen].bounds.size.width / 2 - 20, 35);
    self.textLabel_totalViewNums.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 85, 50, 75, 20);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AA_baseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    AA_exhibitModel *model = self.array[indexPath.row];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125 * [model.worksWidth floatValue] / [model.worksHeight floatValue], 125 )];
    cell.imageView.frame = CGRectMake(0, 0, 125 * [model.worksWidth floatValue] / [model.worksHeight floatValue], 125 );
//    @"http://7xavon.com1.z0.glb.clouddn.com/Fre7473YgEYFjgEn4S3rMOXVcYXl?imageView2/0/w/990/h/621";
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/0/w/990/h/%ld", model.worksPic, 990 / [model.worksWidth integerValue] * [model.worksHeight integerValue] / 2]] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    AA_exhibitModel *model = self.array[indexPath.row];
    return CGSizeMake(125 * [model.worksWidth floatValue] / [model.worksHeight floatValue], 125);
//    return CGSizeMake(90, 125);
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate clickItemCount:indexPath.row Exid:self.model.id_AA];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  AA_opusPicVC.m
//  ArtGoer
//
//  Created by dllo on 16/3/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_opusPicVC.h"
#import "AA_commentModel.h"
#import "AA_CommentCell.h"
#import "UIImageView+WebCache.h"
#import "AA_adaptivelyHW.h"
@interface AA_opusPicVC ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) UIImageView *pic;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, retain) UILabel *label_workName;

@property (nonatomic, retain) UILabel *label_author;

@property (nonatomic, retain) UIView *cell1;

@property (nonatomic, retain) NSMutableArray *arrayCommend;

@property (nonatomic, retain) UIScrollView *scroll;

@property (nonatomic, retain) AA_commentModel *commentModel;

@property (nonatomic, retain) AA_detailOnePageModel *praiseModel;

@property (nonatomic, retain) UIView *headView;

@end

@implementation AA_opusPicVC

- (NSMutableArray *)arrayCommend{
    if (_arrayCommend == nil) {
        _arrayCommend = [NSMutableArray array];
    }
    return _arrayCommend;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self creatSCroll];
    [self creatPic];
    [self creatCell1];
    [self creatTableV];
    [self getTaskData];
    [self creatHeadView];
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

- (void)clickBack{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)creatSCroll{
    self.scroll = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.scroll.delegate = self;
    CGFloat picHeight;
    if (self.height > [UIScreen mainScreen].bounds.size.height - 130) {
        picHeight = [UIScreen mainScreen].bounds.size.height - 130;
    }else{
        picHeight = self.height;
    }
    self.scroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, picHeight + 130);
    [self.view addSubview:self.scroll];
}

- (void)creatPic{
    self.height = [UIScreen mainScreen].bounds.size.width / [self.model.worksWidth floatValue] * [self.model.worksHeight floatValue];
    if (self.height > [UIScreen mainScreen].bounds.size.height - 130) {
        self.pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 130)];
    }else{
        self.pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.height)];
    }
    [self.pic sd_setImageWithURL:[NSURL URLWithString:self.model.worksPic] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    [self.scroll addSubview:self.pic];
}

- (void)creatCell1{
    self.cell1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 130)];
    self.label_workName = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, [UIScreen mainScreen].bounds.size.width - 20, 30)];
    self.label_workName.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.label_workName.text = self.model.workName;
    [self.cell1 addSubview:self.label_workName];
    self.label_author = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, [UIScreen mainScreen].bounds.size.width - 20, 20)];
    self.label_author.font = [UIFont systemFontOfSize:15];
    self.label_author.text = [NSString stringWithFormat:@"%@", self.model.author];
    [self.cell1 addSubview:self.label_author];
    if ([self.model.goodTimes integerValue] > 4) {
        for (int i = 0; i < 5; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50 - (20 * i), 90, 30, 30)];
            imageView.tag = 1000 + i;
            imageView.layer.cornerRadius = 15;
            imageView.clipsToBounds = YES;
            imageView.layer.borderWidth = 1;
            imageView.layer.borderColor = [UIColor whiteColor].CGColor;
            [self.cell1 addSubview:imageView];
        }
    }else{
        for (int i = 0; i < [self.model.goodTimes integerValue]; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50 - (20 * i), 90, 30, 30)];
            imageView.tag = 1000 + i;
            imageView.layer.cornerRadius = 15;
            imageView.clipsToBounds = YES;
            imageView.layer.borderWidth = 1;
            imageView.layer.borderColor = [UIColor whiteColor].CGColor;
            [self.cell1 addSubview:imageView];
        }
    }
    UILabel *goodTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 95, 150, 20)];
    goodTime.text = [NSString stringWithFormat:@"喜欢:%@", self.model.goodTimes];
    goodTime.textColor = [UIColor lightGrayColor];
    goodTime.font = [UIFont systemFontOfSize:14];
    [self.cell1 addSubview:goodTime];
}

- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, self.pic.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:0];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.scrollEnabled = NO;
    self.tableV.separatorStyle = NO;
    [self.tableV registerClass:[AA_CommentCell class] forCellReuseIdentifier:@"comment"];
    [self.scroll addSubview:self.tableV];
}

- (void)getTaskData{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/exhibit_second/work/%@?userId=126323&workId=%@&token=07d48315-f9be-4d20-a2db-657f7284ad5c", self.model.id_AA, self.model.id_AA]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableDictionary *dataDic = [[NSJSONSerialization JSONObjectWithData:data options:0 error:&error] valueForKey:@"data"];
        self.praiseModel = [AA_detailOnePageModel modelWithDic:dataDic];
        if ([self.model.goodTimes integerValue] > 4) {
            for (int i = 0; i < 5; i++) {
                UIImageView *image = [self.cell1 viewWithTag:i + 1000];
                [image sd_setImageWithURL:[NSURL URLWithString:[self.praiseModel.praiseUsers[i] valueForKey:@"headPic"]] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
                [[self.cell1 viewWithTag:i + 1000] setValue:image.image forKey:@"image"];
            }
        }else{
            for (int i = 0; i < [self.model.goodTimes integerValue]; i++) {
                for (int i = 0; i < [self.model.goodTimes integerValue]; i++) {
                    UIImageView *image = [self.cell1 viewWithTag:i + 1000];
                    [image sd_setImageWithURL:[NSURL URLWithString:[self.praiseModel.praiseUsers[i] valueForKey:@"headPic"]] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
                    [[self.cell1 viewWithTag:i + 1000] setValue:image.image forKey:@"image"];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableV reloadData];
        });
        
    }]resume];
    NSString *url = [NSString stringWithFormat:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/exhibit/%@/work/%@/comments?token=07d48315-f9be-4d20-a2db-657f7284ad5c", self.model.exhibitId, self.model.id_AA];
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableArray *dataDic = [[NSJSONSerialization JSONObjectWithData:data options:0 error:&error] valueForKey:@"data"];
        self.arrayCommend = [AA_commentModel getModel:dataDic];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableV reloadData];
            CGRect frame = self.tableV.frame;
            frame.size.height = self.tableV.contentSize.height;
            self.tableV.frame = frame;
            CGFloat pickHeight;
            if (self.height >= [UIScreen mainScreen].bounds.size.height - 130) {
                pickHeight = [UIScreen mainScreen].bounds.size.height - 130 + self.tableV.frame.size.height;
            }else{
                pickHeight = self.height + self.tableV.frame.size.height;
            }
            if (pickHeight < [UIScreen mainScreen].bounds.size.height) {
                self.scroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 130);
            }else{
                self.scroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.pic.frame.size.height + self.tableV.frame.size.height);
            }
        });
    }]resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.arrayCommend.count == 0) {
        return 2;
    }
    return 1 + self.arrayCommend.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.arrayCommend.count == 0) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:nil];
            [cell.contentView addSubview:self.cell1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:nil];
            cell.textLabel.text = @"终于等到你来点评了";
            cell.textLabel.textAlignment = 1;
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.textLabel.textColor = [UIColor grayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:nil];
            [cell.contentView addSubview:self.cell1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            AA_CommentCell *comment = [tableView dequeueReusableCellWithIdentifier:@"comment"];
            comment.model = self.arrayCommend[indexPath.row - 1];
            comment.selectionStyle = UITableViewCellSelectionStyleNone;
            return comment;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.arrayCommend.count == 0) {
        if (indexPath.row == 0) {
            return 130;
        }else{
            return 200;
        }
    }else{
        if (indexPath.row == 0) {
            return 130;
        }else{
            AA_commentModel *model = self.arrayCommend[indexPath.row - 1];
            return 90 + [AA_adaptivelyHW getHeight:model.commentTxt :[UIScreen mainScreen].bounds.size.width - 110 :17];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    CGPoint new = [[change valueForKey:@"new"] CGPointValue];
    CGPoint old = [[change valueForKey:@"old"] CGPointValue];
    if (self.scroll.contentOffset.y > 0) {
        CGRect frame = self.pic.frame;
        frame.origin.y = frame.origin.y + (new.y - old.y) * 0.5;
        self.pic.frame = frame;
    }else if(self.scroll.contentOffset.y < 0){
        if (self.height > [UIScreen mainScreen].bounds.size.height - 130) {
            CGFloat picHeighy = [UIScreen mainScreen].bounds.size.height - 130;
            self.pic.frame = CGRectMake(self.scroll.contentOffset.y / 2, self.scroll.contentOffset.y, [UIScreen mainScreen].bounds.size.width - self.scroll.contentOffset.y / picHeighy * [UIScreen mainScreen].bounds.size.width, picHeighy - self.scroll.contentOffset.y);
        }else{
            self.pic.frame = CGRectMake(self.scroll.contentOffset.y / 2, self.scroll.contentOffset.y, [UIScreen mainScreen].bounds.size.width - self.scroll.contentOffset.y / self.height * [UIScreen mainScreen].bounds.size.width, self.height - self.scroll.contentOffset.y);
        }
    }
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

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.scroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.scroll removeObserver:self forKeyPath:@"contentOffset"];
}

@end

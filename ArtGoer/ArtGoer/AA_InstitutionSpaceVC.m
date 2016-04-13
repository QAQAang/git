//
//  AA_InstitutionSpaceVC.m
//  ArtGoer
//
//  Created by dllo on 16/3/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_InstitutionSpaceVC.h"
#import "UIImageView+WebCache.h"
#import "AA_InsExhibitsModel.h"
#import "AA_InsSpaceCell.h"
#import "AA_sqliteIns.h"
#import "AA_pagesVC.h"
@interface AA_InstitutionSpaceVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UIImageView *headPic;

@property (nonatomic, retain) UIView *contentView;

@property (nonatomic, retain) UILabel *authorLabel;

@property (nonatomic, retain) UILabel *viewerNum;

@property (nonatomic, retain) UIButton *addButton;

@property (nonatomic, retain) UIView *headView;

@property (nonatomic, retain) UILabel *telephoneLabel;

@property (nonatomic, retain) UILabel *addresLabel;

@property (nonatomic, retain) NSMutableArray *arrayModel;

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) UILabel *exhibitNum;

@property (nonatomic, retain) UILabel *workNum;

@property (nonatomic, copy) NSString *picUrl;

@property (nonatomic, copy) NSString *galleryName;

@end

@implementation AA_InstitutionSpaceVC

- (NSMutableArray *)arrayModel{
    if (_arrayModel == nil) {
        _arrayModel = [NSMutableArray array];
    }
    return _arrayModel;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self creatHeadView];
    [self creatContent];
    [self getTaskData];
}

- (void)getTaskData{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/gallery/%@/exhibits?pageIndex=1&token=07d48315-f9be-4d20-a2db-657f7284ad5c", self.galleryID]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.arrayModel = [AA_InsExhibitsModel getModel:[[[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] valueForKey:@"data"] valueForKey:@"exhibitVos"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableV reloadData];
        });
    }]resume];
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
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 75, 10, 150, 30)];
    titleLabel.text = @"机构主页";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = 1;
    [self.headView addSubview:titleLabel];
    [self.view addSubview:self.headView];
    
}

- (void)creatContent{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/gallery/%@/baseInfo?token=07d48315-f9be-4d20-a2db-657f7284ad5c", self.galleryID]]];
    NSMutableDictionary *dic = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] valueForKey:@"data"];
    
     self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 380)];
    self.headPic = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width  / 2 -50, 20, 100, 100)];
    [self.headPic sd_setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"galleryPic"]] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    self.headPic.layer.cornerRadius = 50;
    self.headPic.clipsToBounds = YES;
    [self.contentView addSubview:self.headPic];
    self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, 20)];
    self.galleryName = [dic valueForKey:@"galleryName"];
    self.authorLabel.text = [dic valueForKey:@"galleryName"];
    self.authorLabel.textAlignment = 1;
    self.authorLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [self.contentView addSubview:self.authorLabel];
    self.viewerNum = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100, 185, 200, 15)];
    self.viewerNum.text = [NSString stringWithFormat:@"%@人关注", [dic valueForKey:@"attentionTimes"]];
    self.viewerNum.textAlignment = 1;
    self.viewerNum.font = [UIFont systemFontOfSize:14];
    self.viewerNum.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.viewerNum];
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([AA_sqliteIns selectUserByTitle:self.galleryName].count == 0) {
        [self.addButton setTitle:@"+ 关注" forState:UIControlStateNormal];
    }else{
        [self.addButton setTitle:@"已关注" forState:UIControlStateNormal];
    }
    self.addButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.addButton.layer.borderWidth = 1;
    [self.addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.addButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.addButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 50, 215, 100, 40);
    [self.addButton addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.addButton];
    self.telephoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 290, [UIScreen mainScreen].bounds.size.width, 15)];
    self.telephoneLabel.text = [NSString stringWithFormat:@"电话:%@", [dic valueForKey:@"telNo"]];
    self.telephoneLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.telephoneLabel];
    self.addresLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 320, [UIScreen mainScreen].bounds.size.width, 15)];
    self.addresLabel.text = [NSString stringWithFormat:@"地址:%@", [dic valueForKey:@"address"]];
    self.addresLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.addresLabel];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 339, [UIScreen mainScreen].bounds.size.width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
    self.exhibitNum = [[UILabel alloc] initWithFrame:CGRectMake(10, 360, 100, 20)];
    self.exhibitNum.font = [UIFont systemFontOfSize:15];
    self.exhibitNum.text = [NSString stringWithFormat:@"展览数(%@)", [dic valueForKey:@"exhibitNum"]];
    [self.contentView addSubview:self.exhibitNum];
    self.workNum = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 110, 360, 100, 20)];
    self.workNum.textAlignment = NSTextAlignmentRight;
    self.workNum.font = [UIFont systemFontOfSize:15];
    self.workNum.text = [NSString stringWithFormat:@"全部作品(%@)", [dic valueForKey:@"workNum"]];
    [self.contentView addSubview:self.workNum];
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 70) style:0];
    self.tableV.tableHeaderView = self.contentView;
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = NO;
    self.tableV.bounces = NO;
    self.tableV.backgroundColor = [UIColor whiteColor];
    [self.tableV registerClass:[AA_InsSpaceCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableV];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AA_InsSpaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = self.arrayModel[indexPath.row];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AA_pagesVC *pages = [[AA_pagesVC alloc] init];
    AA_InsExhibitsModel *model = self.arrayModel[indexPath.row];
    pages.exhibitID = model.id_AA;
    [self presentViewController:pages animated:YES completion:^{
        
    }];
}

- (void)clickBack{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)clickAdd{
    if ([AA_sqliteIns selectUserByTitle:self.galleryName].count == 0) {
        [AA_sqliteIns insertUserWithTitle:self.galleryName PicUrl:self.picUrl Url:self.galleryID];
        [self.addButton setTitle:@"已关注" forState:UIControlStateNormal];
    }else{
        [AA_sqliteIns deleteUserWithTitle:self.galleryName];
        [self.addButton setTitle:@"+ 关注" forState:UIControlStateNormal];
    }
}

@end

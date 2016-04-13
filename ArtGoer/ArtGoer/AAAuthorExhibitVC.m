//
//  AAAuthorExhibitVC.m
//  ArtGoer
//
//  Created by dllo on 16/4/11.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AAAuthorExhibitVC.h"
#import "AA_InsSpaceCell.h"
#import "AA_InsExhibitsModel.h"
#import "AA_pagesVC.h"
@interface AAAuthorExhibitVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UIView *headView;

@property (nonatomic, retain) NSMutableArray *dataArr;

@property (nonatomic, retain) UITableView *tableV;

@end

@implementation AAAuthorExhibitVC

- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatHeadView];
    [self creatTableV];
    [self getTaskData];
}

- (void)getTaskData{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.artgoer.cn:8084/artgoer/api/v1/user/126323/exhibit/artsJoinExhibits?pageIndex=1&otherUserId=%@&token=07d48315-f9be-4d20-a2db-657f7284ad5c", self.userId]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:&error]);
        self.dataArr = [AA_InsExhibitsModel getModel:[[NSJSONSerialization JSONObjectWithData:data options:0 error:&error] valueForKey:@"data"]];
        NSLog(@"%ld", (unsigned long)self.dataArr.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", [self.dataArr valueForKey:@"exhibitPic"]);
            [self.tableV reloadData];
        });
    }]resume];
}

- (void)creatTableV{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50) style:0];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.tableV registerClass:[AA_InsSpaceCell class] forCellReuseIdentifier:@"ins"];
    [self.view addSubview:self.tableV];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArr.count == 0) {
        return 1;
    }else{
        return self.dataArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AA_InsSpaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ins"];
    if (self.dataArr.count == 0) {
        UITableViewCell *nulling = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        nulling.textLabel.text = @"没有更多数据";
        nulling.textLabel.textColor = [UIColor grayColor];
        nulling.textLabel.textAlignment = NSTextAlignmentCenter;
        nulling.selectionStyle = UITableViewCellAccessoryNone;
        return nulling;
    }else{
        cell.model = self.dataArr[indexPath.row];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArr.count == 0) {
        return 50;
    }else{
        return 300;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AA_pagesVC *pages = [[AA_pagesVC alloc] init];
    AA_InsExhibitsModel *model = self.dataArr[indexPath.row];
    pages.exhibitID = model.id_AA;
    [self presentViewController:pages animated:YES completion:^{
        
    }];
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
    title.text = @"展览";
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

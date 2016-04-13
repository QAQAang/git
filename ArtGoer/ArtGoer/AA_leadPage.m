//
//  AA_leadPage.m
//  ArtGoer
//
//  Created by dllo on 16/3/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#define SCREEN_FRAME ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "AA_leadPage.h"

@interface AA_leadPage ()

{
    UIPageControl *pageControl; //指示当前处于第几个引导页
    UIScrollView *scrollView; //用于存放并显示引导页
    UIImageView *imageViewOne;
    UIImageView *imageViewTwo;
    UIImageView *imageViewThree;
    
}

@end

@implementation AA_leadPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化UI控件
    scrollView=[[UIScrollView alloc]initWithFrame:SCREEN_FRAME];
    scrollView.pagingEnabled=YES;
    [self.view addSubview:scrollView];
    
    
    pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 10)];
    pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.0];
    [self.view addSubview:pageControl];
    pageControl.numberOfPages=3;
    
    [self createViewOne];
    [self createViewTwo];
    [self createViewThree];
    
    
}


-(void)createViewOne{
    
    UIView *view = [[UIView alloc] initWithFrame:SCREEN_FRAME];
    
    imageViewOne = [[UIImageView alloc] initWithFrame:SCREEN_FRAME];
    imageViewOne.contentMode = UIViewContentModeScaleAspectFit;
    imageViewOne.image = [UIImage imageNamed:@"lead1"];
    [view addSubview:imageViewOne];
    
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress1:)];
    imageViewOne.userInteractionEnabled = YES;
    [imageViewOne addGestureRecognizer:singleTap1];
    
    
    [scrollView addSubview:view];
    
}

-(void)createViewTwo{
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    imageViewTwo = [[UIImageView alloc] initWithFrame:SCREEN_FRAME];
    imageViewTwo.contentMode = UIViewContentModeScaleAspectFit;
    imageViewTwo.image = [UIImage imageNamed:@"lead2"];
    [view addSubview:imageViewTwo];
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress2:)];
    imageViewTwo.userInteractionEnabled = YES;
    [imageViewTwo addGestureRecognizer:singleTap1];
    
    [scrollView addSubview:view];
    
}

-(void)createViewThree{
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    imageViewThree = [[UIImageView alloc] initWithFrame:SCREEN_FRAME];
    imageViewThree.contentMode = UIViewContentModeScaleAspectFit;
    imageViewThree.image = [UIImage imageNamed:@"lead3"];
    [view addSubview:imageViewThree];
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress3:)];
    imageViewThree.userInteractionEnabled = YES;
    [imageViewThree addGestureRecognizer:singleTap1];
    
    [scrollView addSubview:view];
}

#pragma mark -- tap image
-(void)buttonpress1:(id)sender
{
    CGFloat pageWidth = CGRectGetWidth(self.view.bounds);
    CGPoint scrollPoint = CGPointMake(pageWidth, 0);
    [scrollView setContentOffset:scrollPoint animated:YES];
    
    pageControl.currentPage = 1;
    
}

-(void)buttonpress2:(id)sender
{
    CGFloat pageWidth = CGRectGetWidth(self.view.bounds);
    CGPoint scrollPoint = CGPointMake(pageWidth*2, 0);
    [scrollView setContentOffset:scrollPoint animated:YES];
    pageControl.currentPage = 2;
    
}

-(void)buttonpress3:(id)sender
{
    NSLog(@"引导页完成");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

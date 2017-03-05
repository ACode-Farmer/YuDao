//
//  TSLaunchViewController.m
//  demo
//
//  Created by wangyz on 16/4/21.
//  Copyright © 2016年 topsports2. All rights reserved.
//

#import "TSLaunchViewController.h"
#import "YDMainViewController.h"

#define kWidth self.view.bounds.size.width
#define kHeight self.view.bounds.size.height

@interface TSLaunchViewController ()<UIScrollViewDelegate>

{
    NSArray *imgArr;//存放滚动图片的数组
}

@property (nonatomic, strong) UIScrollView *scrollView;//滚动视图
@property (nonatomic, strong) UIPageControl *pageControl;//滚动点

@end

@implementation TSLaunchViewController

#pragma mark - 控制器周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /**
     *引动页中图片的设置
     */
    imgArr = @[@"launchImage_00", @"launchImage_01", @"launchImage_02", @"launchImage_03"];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(kWidth * imgArr.count, kHeight);
        
        [self addImageViewONScrollView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:(CGRectMake(kWidth/3, kHeight*15/16, kWidth/3, kHeight/16))];
        
        _pageControl.numberOfPages = imgArr.count;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    }
    
    return _pageControl;
}

#pragma mark - scrollView

/**
 *  在scrollView上添加图片
 */

- (void)addImageViewONScrollView {
    
    for (int i = 0; i < imgArr.count; i++) {
        
        UIImage *img = [UIImage imageNamed:imgArr[i]];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth * i, 0, kWidth, kHeight)];
        
        //在滚动页最后一页添加按钮
        if (i  == imgArr.count - 1) {
            
            imgView.userInteractionEnabled = YES;
            
            UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
            
            button.frame = CGRectMake(kWidth/3, kHeight * 7/8, kWidth/3, kHeight/16);
            button.layer.borderWidth = 2;
            button.layer.cornerRadius = 5;
            //button.layer.borderColor = [UIColor whiteColor].CGColor;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            button.clipsToBounds = YES;
            
            [button setTitle:@"点击进入" forState:(UIControlStateNormal)];
            [button setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
            [button addTarget:self action:@selector(go:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [imgView addSubview:button];
        }
        
        imgView.image = img;
        [_scrollView addSubview:imgView];
    }
}

//代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.pageControl.currentPage = scrollView.contentOffset.x/kWidth;
}

/**
 *  点击按钮方法
 */
- (void)go:(id)sender {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setBool:YES forKey:@"isFirst"];
    [user synchronize];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[YDMainViewController alloc] init];
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

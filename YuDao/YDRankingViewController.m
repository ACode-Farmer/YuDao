//
//  YDRankingViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDRankingViewController.h"
#import "YDAllListViewController.h"
#import "YDAllListItem.h"
#import "YDRTypeView.h"
#import "YDOrdinaryTableViewController.h"

@interface YDRankingViewController ()<UIScrollViewDelegate,YDRTypeViewDelegate,YDOrdinaryTableViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) YDAllListViewController *oneVC;
@property (nonatomic, strong) YDAllListViewController *twoVC;
@property (nonatomic, strong) YDAllListViewController *threeVC;
@property (nonatomic, strong) YDAllListViewController *fourVC;
@property (nonatomic, strong) YDAllListViewController *fiveVC;
@property (nonatomic, strong) YDAllListViewController *sixVC;
@property (nonatomic, strong) YDRTypeView *typeView;

@property (nonatomic, strong) YDOrdinaryTableViewController *ordinaryVC;

@end

@implementation YDRankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"排行榜";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self.view addSubview:self.typeView];
    [self.view addSubview:self.scrollView];
    [self y_addSubControllers];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark Events
- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender{
    self.ordinaryVC.isShow = !self.ordinaryVC.isShow;
    if (self.ordinaryVC.isShow) {
        [UIView animateWithDuration:0.25 animations:^{
            self.ordinaryVC.view.height = self.ordinaryVC.tableView.rowHeight * 8;
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.ordinaryVC.view.height = 0;
        }];
    }
}

#pragma mark Private Methods -
- (void)y_addSubControllers{
    NSArray *controllers = @[self.oneVC,self.twoVC,self.threeVC,self.fourVC,self.fiveVC,self.sixVC];
    [controllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YDAllListViewController *vc = (YDAllListViewController *)obj;
        [self.scrollView addSubview:vc.view];
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        vc.view.frame = CGRectMake(idx * screen_width, 0, screen_width, self.scrollView.bounds.size.height);
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger i = scrollView.contentOffset.x/screen_width;
    [self.typeView setIndex:i];
   
}

#pragma mark - YDRTypeViewDelegate
- (void)typeViewWithButton:(UIButton *)sender{
    NSUInteger index = sender.tag - 1000;
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = index * screen_width;
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - YDOrdinaryTableViewControllerDelegate
- (void)OrdinaryTableViewControllerWith:(UITableView *)tableView{
    self.ordinaryVC.isShow = !self.ordinaryVC.isShow;
    self.ordinaryVC.view.height = 0;
}

#pragma mark - Getters

- (YDOrdinaryTableViewController *)ordinaryVC{
    if (!_ordinaryVC) {
        _ordinaryVC = [YDOrdinaryTableViewController new];
        _ordinaryVC.view.frame = CGRectMake(screen_width-124, 64, 124, 0);
        _ordinaryVC.isShow = NO;
        _ordinaryVC.selectedDelegate = self;
        [self.view addSubview:_ordinaryVC.view];
        [self addChildViewController:_ordinaryVC];
        [_ordinaryVC didMoveToParentViewController:self];
    }
    return _ordinaryVC;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.frame = CGRectMake(0, CGRectGetMaxY(self.typeView.frame), screen_width, screen_height);
        _scrollView.contentSize = CGSizeMake(6*screen_width, screen_height);
    }
    return _scrollView;
}

- (YDRTypeView *)typeView{
    if (!_typeView) {
        CGRect frame = CGRectMake(0, 64, screen_width, 40*widthHeight_ratio);
        _typeView = [[YDRTypeView alloc] initWithFrame:frame titles:@[@"里程",@"时速",@"油耗",@"滞留",@"积分",@"喜欢"]];
        _typeView.delegate = self;
    }
    return _typeView;
}

- (YDAllListViewController *)oneVC{
    if (!_oneVC) {
        _oneVC = [YDAllListViewController new];
    }
    return _oneVC;
}

- (YDAllListViewController *)twoVC{
    if (!_twoVC) {
        _twoVC = [YDAllListViewController new];
    }
    return _twoVC;
}

- (YDAllListViewController *)threeVC{
    if (!_threeVC) {
        _threeVC = [YDAllListViewController new];
    }
    return _threeVC;
}

- (YDAllListViewController *)fourVC{
    if (!_fourVC) {
        _fourVC = [YDAllListViewController new];
    }
    return _fourVC;
}

- (YDAllListViewController *)fiveVC{
    if (!_fiveVC) {
        _fiveVC = [YDAllListViewController new];
    }
    return _fiveVC;
}

- (YDAllListViewController *)sixVC{
    if (!_sixVC) {
        _sixVC = [YDAllListViewController new];
    }
    return _sixVC;
}


@end

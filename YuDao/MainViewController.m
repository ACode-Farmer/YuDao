//
//  MainViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MainViewController.h"
#import "DrivingViewController.h"
#import "MainCommonViewController.h"
#import "ListViewController.h"
#import "CornerButton.h"

@interface MainViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) CornerButton *topBtn;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *coverView = [UIView new];
    [self.view addSubview:coverView];
    DrivingViewController *drVC = [DrivingViewController new];
    CGRect drframe = CGRectMake(0, 0, screen_width, 0.8 * (screen_height-64-48));
    drVC.view.frame = drframe;
    [self.contentView addSubview:drVC.view];
    [self addChildViewController:drVC];
    [drVC didMoveToParentViewController:self];
    
    ListViewController *mcVC = [ListViewController new];
    mcVC.mainTitle = @"排行榜";
    CGRect mcframe = CGRectMake(0, CGRectGetMaxY(drframe)+5, screen_width, screen_height);
    mcVC.view.frame = mcframe;
    [self.contentView addSubview:mcVC.view];
    [self addChildViewController:mcVC];
    [mcVC didMoveToParentViewController:self];
}

#pragma mark lazy load -
- (CornerButton *)topBtn{
    if (!_topBtn) {
        _topBtn = [CornerButton circularButtonWithImageName:@"回到顶部.png"];
        _topBtn.hidden = YES;
        [_topBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_topBtn];
        
        _topBtn.sd_layout
        .bottomSpaceToView(self.view,100)
        .rightSpaceToView(self.view,50)
        .heightIs(50)
        .widthEqualToHeight();
    }
    return _topBtn;
}

- (UIScrollView *)contentView{
    if (!_contentView) {
        _contentView = [UIScrollView new];
        _contentView.contentSize = CGSizeMake(screen_width, 4*screen_height);
        _contentView.backgroundColor = [UIColor lightGrayColor];
        _contentView.delegate = self;
        [self.view addSubview:_contentView];
        _contentView.sd_layout
        .topSpaceToView(self.view,64)
        .leftSpaceToView(self.view,0)
        .widthIs(screen_width)
        .heightIs(screen_height-48);
    }
    return _contentView;
}

#pragma mark topBtn action -
- (void)topBtnAction:(UIButton *)sender{
    CGPoint offset = self.contentView.contentOffset;
    offset.y = 0;
    [self.contentView setContentOffset:offset animated:YES];
}

#pragma mark contentView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > 0.55*screen_height) {
        self.topBtn.hidden = NO;
    }else{
        self.topBtn.hidden = YES;
    }
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

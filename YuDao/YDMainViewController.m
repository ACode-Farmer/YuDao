//
//  MainViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMainViewController.h"
#import "YDDrivingViewController.h"
#import "YDListViewController.h"
#import "CornerButton.h"
#import "TaskViewController.h"
#import "DynamicViewController.h"
#import "YDMainViewConfigure.h"

@interface YDMainViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) CornerButton *topBtn;

@property (nonatomic, strong) YDDrivingViewController *drVC;
@property (nonatomic, strong) YDListViewController *liVC;
@property (nonatomic, strong) TaskViewController *tkVC;
@property (nonatomic, strong) DynamicViewController *dyVC;

@end

@implementation YDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = ({
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screen_width/2, 40)];
        titleLable.text = @"奔驰AMG－C63";
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.textColor = [UIColor blackColor];
        titleLable.font = [UIFont systemFontOfSize:14];
        UIView *coverView = [UIView new];
        [self.view addSubview:coverView];
        titleLable;
    });
    
    _drVC = [YDDrivingViewController new];
    CGRect drframe = CGRectMake(0, 0, screen_width, kDrivingViewHeight);
    _drVC.view.frame = drframe;
    [self.contentView addSubview:_drVC.view];
    [self addChildViewController:_drVC];
    [_drVC didMoveToParentViewController:self];
    
    _liVC = [YDListViewController new];
    [self.contentView addSubview:_liVC.view];
    [self addChildViewController:_liVC];
    [_liVC didMoveToParentViewController:self];
    _liVC.view.sd_layout
    .topSpaceToView(_drVC.view,kMainViewMargin)
    .centerXEqualToView(_contentView)
    .widthIs(screen_width);
    
    _tkVC = [TaskViewController new];
    [self.contentView addSubview:_tkVC.view];
    [self addChildViewController:_tkVC];
    [_tkVC didMoveToParentViewController:self];
    _tkVC.view.sd_layout
    .topSpaceToView(_liVC.view,kMainViewMargin)
    .centerXEqualToView(_contentView)
    .widthIs(screen_width);
    
    _dyVC = [DynamicViewController new];
    [self.contentView addSubview:_dyVC.view];
    [self addChildViewController:_dyVC];
    [_dyVC didMoveToParentViewController:self];
    _dyVC.view.sd_layout
    .topSpaceToView(_tkVC.view,kMainViewMargin)
    .centerXEqualToView(_contentView)
    .widthIs(screen_width);
    
    [_contentView setupAutoContentSizeWithBottomView:_dyVC.view bottomMargin:0];
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
        _contentView.contentSize = CGSizeMake(screen_width, 6*screen_height);
        _contentView.backgroundColor = [UIColor lightGrayColor];
        _contentView.delegate = self;
        _contentView.showsVerticalScrollIndicator = NO;
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
//    if (scrollView.contentOffset.y > 0.55*screen_height) {
//        self.topBtn.hidden = NO;
//    }else{
//        self.topBtn.hidden = YES;
//    }
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
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

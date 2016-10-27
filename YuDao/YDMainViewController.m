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
#import "YDRankingViewController.h"
#import "CaptureViewController.h"
#import "YDSearchViewController.h"
#import "YDPersonalDataController.h"

#import "YDTodayFirstLoginView.h"

@interface YDMainViewController ()<UIScrollViewDelegate,YDListViewControllerDelegate,YDDynamicVCDelegate>

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) CornerButton *topBtn;

@property (nonatomic, strong) YDDrivingViewController *drVC;
@property (nonatomic, strong) YDListViewController *liVC;
@property (nonatomic, strong) TaskViewController *tkVC;
@property (nonatomic, strong) DynamicViewController *dyVC;

@property (nonatomic, strong) YDTodayFirstLoginView *TFLView;

@end

@implementation YDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = ({
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"二维码"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
        leftBarButton;
    });
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"搜索"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
        rightBarButton;
    });
    self.navigationItem.titleView = ({
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screen_width/2, 40)];
        titleLable.text = @"奔驰AMG－C63";
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.textColor = [UIColor blackColor];
        titleLable.font = [UIFont systemFontOfSize:16];
        UIView *coverView = [UIView new];
        [self.view addSubview:coverView];
        titleLable;
    });
    
    NSArray *controllers = @[self.drVC,self.liVC,self.tkVC,self.dyVC];
    [controllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = (UIViewController *)obj;
        [self.contentView addSubview:vc.view];
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
    }];
    [self layoutFourMainViews];
    
    [_contentView setupAutoContentSizeWithBottomView:_dyVC.view bottomMargin:70];
    [self todayFirstLoginAnimation];
}

- (void)todayFirstLoginAnimation{
    [self.view addSubview:self.TFLView];
    [UIView animateWithDuration:0.8 animations:^{
        self.TFLView.y = 0;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.TFLView.y = -50;
        } completion:^(BOOL finished) {
            [self.TFLView removeFromSuperview];
        }];
    });
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

- (void)dealloc{
    NSLog(@"mainVC");
}

#pragma mark - Events
- (void)leftBarButtonItemAction:(id)sender{
    
     CaptureViewController *capture = [CaptureViewController new];
     capture.CaptureSuccessBlock = ^(CaptureViewController *captureVC,NSString *s){
     [captureVC dismissViewControllerAnimated:NO completion:nil];
     };
     capture.CaptureFailBlock = ^(CaptureViewController *captureVC){
     [captureVC dismissViewControllerAnimated:NO completion:nil];
     };
     capture.CaptureCancelBlock = ^(CaptureViewController *captureVC){
     [captureVC dismissViewControllerAnimated:NO completion:nil];
     };
     
     [self presentViewController:capture animated:YES completion:nil];
    
}

- (void)rightBarButtonItemAction:(id)sender{
    [self.navigationController firstLevel_push_fromViewController:self toVC:[YDSearchViewController new]];
}

#pragma private Methods - 
- (void)layoutFourMainViews{
    CGRect drframe = CGRectMake(0, 0, screen_width, kDrivingViewHeight);
    _drVC.view.frame = drframe;
    
    _liVC.view.sd_layout
    .topSpaceToView(_drVC.view,kMainViewMargin)
    .centerXEqualToView(_contentView)
    .widthIs(screen_width);
    
    _tkVC.view.sd_layout
    .topSpaceToView(_liVC.view,kMainViewMargin)
    .centerXEqualToView(_contentView)
    .widthIs(screen_width);
    
    _dyVC.view.sd_layout
    .topSpaceToView(_tkVC.view,kMainViewMargin)
    .centerXEqualToView(_contentView)
    .widthIs(screen_width);
}

#pragma mark Custom Delegate - 
- (void)listViewControllerWith:(NSString *)title{
    UIViewController *vc = nil;
    if (title) {
        vc = [YDPersonalDataController new];
        vc.title = title;
    }else{
        vc = [YDRankingViewController new];
    }
    
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

- (void)YDDynamicViewControllerPushToVC:(YDDynamicDetailController *)toVC index:(NSInteger )index{
    [self.navigationController firstLevel_push_fromViewController:self toVC:(id)toVC];
}

#pragma mark Getters -

- (YDTodayFirstLoginView *)TFLView{
    if (_TFLView == nil) {
        _TFLView = [[YDTodayFirstLoginView alloc] initWithFrame:CGRectMake(0, -50, screen_width, 50)];
        [_TFLView updateTFLView:[UIImage imageNamed:@"carIcon"] title:@"每日登录获得10积分"];
    }
    return _TFLView;
}

- (YDDrivingViewController *)drVC{
    if (!_drVC) {
        _drVC = [YDDrivingViewController new];
    }
    return _drVC;
}

- (YDListViewController *)liVC{
    if (!_liVC) {
        _liVC = [YDListViewController new];
        _liVC.delegate = self;
    }
    return _liVC;
}

- (TaskViewController *)tkVC{
    if (!_tkVC) {
        _tkVC = [TaskViewController new];
    }
    return _tkVC;
}

- (DynamicViewController *)dyVC{
    if (!_dyVC) {
        _dyVC = [DynamicViewController new];
        _dyVC.delegate = self;
    }
    return _dyVC;
}

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
        _contentView.backgroundColor = [UIColor colorWithString:@"#dcdcdc"];
        _contentView.delegate = self;
        _contentView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_contentView];
        _contentView.sd_layout
        .topSpaceToView(self.view,0)
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



@end

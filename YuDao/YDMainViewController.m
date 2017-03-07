//
//  MainViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMainViewController.h"
#import "YDTrafficInfoController.h"
#import "YDTaskController.h"
#import "YDDynamicController.h"
#import "YDRankingListController.h"
#import "CaptureViewController.h"
#import "YDSearchViewController.h"
#import "YDBindOBDController.h"
#import "JPUSHService.h"
#import "YDNavigationController.h"
#import "YDAllDynamicController.h"
@import Photos;

@interface YDMainViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView            *contentView;

@property (nonatomic, strong) YDTrafficInfoController *drVC;
@property (nonatomic, strong) YDTaskController    *liVC;
@property (nonatomic, strong) YDRankingListController      *tkVC;
@property (nonatomic, strong) YDDynamicController *dyVC;


@end

@implementation YDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //测试
    [YDConversationHelper shareInstance];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = ({
        //UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"扫一扫"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"扫一扫"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"扫一扫"] forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn sizeToFit];
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, kWidth(-25), 0, 0);
        backBtn.frame = CGRectMake(0, 0, 32, 32);
        [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    });
    self.navigationItem.rightBarButtonItem = ({
        //UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"搜索"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn sizeToFit];
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kWidth(-25));
        backBtn.frame = CGRectMake(0, 0, 32, 32);
        [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    });
    [self.navigationItem setTitle:@"遇道"];
    
    [self addFourRootViewController];
    
    
    [self getPermission];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self refreshFourChildView];
//    if ([YDCarHelper s   haredHelper].carArray.count != 0) {
//        YDCarDetailModel *car = [[YDCarHelper sharedHelper] defaultOrBindObdCar];
//        if (car) {
//            [[YDCarHelper sharedHelper] setCurrentCarid:car.ug_id];
//            [_titleBtn setTitle:car.ug_brand_name forState:0];
//            [_titleBtn setImage:[UIImage imageNamed:@"ranking_arrow_normal"] forState:0];
//            _titleBtn.enabled = YES;
//        }
//    }else{
//       [_titleBtn setTitle:@"遇道" forState:0];
//        _titleBtn.imageView.image = nil;
//    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

#pragma mark - Event Response

/**
 *  获取权限
 */
- (void)getPermission{
        //相机权限
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//            if (granted) {
//                //NSLog(@"Authorized");
//            }else{
//                //NSLog(@"Denied or Restricted");
//            }
        }];
    
}


#pragma mark - Events
- (void)leftBarButtonItemAction:(id)sender{

    [self.navigationController pushViewController:[YDBindOBDController new] animated:YES];
    
}

- (void)rightBarButtonItemAction:(id)sender{
    [self.navigationController pushViewController:[YDSearchViewController new] animated:YES];
}

#pragma private Methods - 
//MARK:添加四个子控制器及其视图
- (void)addFourRootViewController{
    
    NSArray<UIViewController *> *controllers = @[self.drVC,self.liVC,self.tkVC,self.dyVC];
    [controllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.contentView addSubview:obj.view];
        [self addChildViewController:obj];
        [obj didMoveToParentViewController:self];
    }];
}
//MARK:根据等级或是否登录来判定车辆信息是否显示
- (void)refreshFourChildView{
    if (!YDHadLogin || [YDUserDefault defaultUser].user.ub_auth_grade.integerValue < 5) {
        self.drVC.view.y = -255.f;
        self.drVC.view.hidden = YES;
        self.liVC.view.y = 0.f,
        self.tkVC.view.y = 200.f,
        self.dyVC.view.y = 425.f;
    }else{
        self.drVC.view.y = 0.f;
        self.drVC.view.hidden = NO;
        self.liVC.view.y = 255.f,
        self.tkVC.view.y = 455.f,
        self.dyVC.view.y = 680.f;
    }
    
    [_contentView setupAutoContentSizeWithBottomView:_dyVC.view bottomMargin:0];
}

#pragma mark Getters -
- (YDTrafficInfoController *)drVC{
    if (!_drVC) {
        _drVC = [YDTrafficInfoController new];
    }
    return _drVC;
}

- (YDTaskController *)liVC{
    if (!_liVC) {
        _liVC = [YDTaskController new];
    }
    return _liVC;
}

- (YDRankingListController *)tkVC{
    if (!_tkVC) {
        _tkVC = [YDRankingListController new];
    }
    return _tkVC;
}

- (YDDynamicController *)dyVC{
    if (!_dyVC) {
        _dyVC = [YDDynamicController new];
    }
    return _dyVC;
}

- (UIScrollView *)contentView{
    if (!_contentView) {
        _contentView = [UIScrollView new];
        _contentView.contentSize = CGSizeMake(screen_width, 6*screen_height);
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.delegate = self;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.frame = CGRectMake(0, 0, screen_width, screen_height-64);
        [self.view addSubview:_contentView];
        __weak YDDynamicController *weakDyVC = self.dyVC;
        
        MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [[BaiduMobStat defaultStat] logEvent:@"UserClick" eventLabel:@"首页上拉-进入逛一逛"];
            YDAllDynamicController *allVC = [YDAllDynamicController new];
            allVC.fromFlag = 1;
            YDNavigationController *naVC = [[YDNavigationController alloc] initWithRootViewController:allVC];
            
            [weakDyVC presentViewController:naVC animated:YES completion:nil];
            [_contentView.mj_footer endRefreshing];
            
        }];
        
        [refreshFooter setTitle:@"上拉去往所有动态" forState:MJRefreshStateIdle];
        [refreshFooter setTitle:@"释放到达所有动态" forState:MJRefreshStatePulling];
        [refreshFooter setTitle:@"释放到达所有动态" forState:MJRefreshStateRefreshing];
        [refreshFooter setTitle:@"释放到达所有动态" forState:MJRefreshStateWillRefresh];
        [refreshFooter setTitle:@"上拉去往所有动态" forState:MJRefreshStateNoMoreData];
        [refreshFooter.stateLabel setFont:[UIFont font_12]];
        [refreshFooter.stateLabel setTextColor:[UIColor colorWithString:@"#FF9B9B9B"]];
        refreshFooter.arrowView.image = [UIImage imageNamed:@"load_bottom_arrow"];
        _contentView.mj_footer = refreshFooter;
        
        YDWeakSelf(self);
        MJRefreshNormalHeader *refresghHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            NSLog(@"刷新首页所有数据!");
            [[BaiduMobStat defaultStat] logEvent:@"UserClick" eventLabel:@"首页下拉-刷新数据"];
            [weakself.drVC reloadTrafficInfomation];
            [weakself.drVC downloadWeatherAndTestData];
            NSNumber *selectedIndex = [[NSUserDefaults standardUserDefaults] valueForKey:@"rankListType"];
            [weakself.liVC downloadTaskData];
            [weakself.tkVC downloadRankingListData:selectedIndex.integerValue];
            [weakself.dyVC downloadDynamicData:1 refreshView:_contentView];
            [weakself.contentView.mj_header endRefreshing];
        }];
        [refresghHeader.stateLabel setFont:[UIFont font_12]];
        [refresghHeader.stateLabel setTextColor:[UIColor colorWithString:@"#FF9B9B9B"]];
        [refresghHeader.lastUpdatedTimeLabel setFont:[UIFont font_12]];
        [refresghHeader.lastUpdatedTimeLabel setTextColor:[UIColor colorWithString:@"#FF9B9B9B"]];
        refresghHeader.arrowView.image = [UIImage imageNamed:@"load_bottom_arrow"];
        refresghHeader.ignoredScrollViewContentInsetTop = 15.0f;
        _contentView.mj_header = refresghHeader;
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
#define ANGLE(angle) ((M_PI*angle)/180)
static CAShapeLayer * pullLayer;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > 0.0f) {
        return;
    }
    /*
    pullLayer.path = nil;
    [pullLayer removeFromSuperlayer];
    if (scrollView.mj_header.pullingPercent > 1.6f) {
        scrollView.mj_header.pullingPercent = 1.6f;
    }
    MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)scrollView.mj_header;
    if (scrollView.mj_header.pullingPercent == 1.f || header.state == MJRefreshStateRefreshing ) {
        return;
    }
    CGPoint centerPoint = header.arrowView.center;
    
    CGFloat radius = 15.0f;
    UIBezierPath *roundPath = [UIBezierPath bezierPath];
    [roundPath moveToPoint:CGPointMake(centerPoint.x+radius, centerPoint.y)];
    [roundPath addArcWithCenter:centerPoint radius:radius startAngle:0 endAngle:scrollView.mj_header.pullingPercent*M_PI clockwise:YES];
    [roundPath stroke];
    // 渲染
    pullLayer = [CAShapeLayer layer];
    pullLayer.path = roundPath.CGPath;
    pullLayer.strokeColor = [UIColor colorWithString:@"#B6C5DC"].CGColor;
    pullLayer.fillColor = [UIColor clearColor].CGColor;
    pullLayer.lineJoin = kCALineJoinRound;
    pullLayer.lineCap = kCALineCapRound;
    pullLayer.strokeStart = 0;
    pullLayer.strokeEnd = 1;
    pullLayer.lineWidth = 1.5;
    
    [header.layer addSublayer:pullLayer];
     */
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

@end

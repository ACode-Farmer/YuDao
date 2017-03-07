//
//  YDRankListViewController.m
//  YuDao
//
//  Created by 汪杰 on 2017/1/3.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import "YDRankListViewController.h"
#import "YDContainerController.h"
#import "YDSingleRankingController.h"
#import "YDSingleRankingBottomView.h"
#import "YDRankListFilterTableView.h"

@interface YDRankListViewController()<YDContainerControllerDelegate>

@property (nonatomic, strong) YDContainerController *containerVC;//容器视图控制器

@property (nonatomic, strong) YDSingleRankingController *oneVC;

@property (nonatomic, strong) YDSingleRankingController *twoVC;

@property (nonatomic, strong) YDSingleRankingController *threeVC;

@property (nonatomic, strong) YDSingleRankingController *fourVC;

@property (nonatomic, strong) YDSingleRankingController *fiveVC;

@property (nonatomic, strong) YDSingleRankingController *sixVC;

@property (nonatomic, strong) YDSingleRankingBottomView *bottomView;//底部浮动视图(用于显示个人当前排名数据)

@property (nonatomic, strong) YDRankListFilterTableView *filterTable;//弹出的筛选表格视图

@property (nonatomic, strong) YDSingleRankingController *currentRankingVC;//当前所展示的排行榜控制器

@property (nonatomic, strong) NSMutableArray *filters;            //存取所有表单的筛选条件索引

@property (nonatomic, assign) NSInteger     currentRankListIndex;//当前排行榜类型


@end

@implementation YDRankListViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"排行榜"];
    _currentRankListIndex = 0;
    _filters = [NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0,@0,nil];
    
    [self.view addSubview:self.containerVC.view];
    [self.view addSubview:self.bottomView];
    [self.view bringSubviewToFront:self.bottomView];
    
    [self.navigationItem setRightBarButtonItem:[UIBarButtonItem itemWithImage:@"dis_rank_filter_image" highImage:@"dis_rank_filter_image" target:self action:@selector(discover_rankingList_rightBarItemAction:)]];
    _currentRankingVC = self.oneVC;
}
//点击右边筛选按钮
- (void)discover_rankingList_rightBarItemAction:(UIBarButtonItem *)item{
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    effectView.frame = CGRectMake(0, 0, screen_width, screen_height);
    effectView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEffectViewAction:)];
    [effectView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:effectView];
    
    YDWeakSelf(self);
    YDWeakSelf(effectView);
    NSNumber *selectedIndex = [_filters objectAtIndex:_currentRankListIndex];
    self.filterTable = [[YDRankListFilterTableView alloc] initWithSelectedIndex:selectedIndex.integerValue];
    self.filterTable.frame = CGRectMake(screen_width-64, 64, 0, 0);
    self.filterTable.alpha = 0;
    //点击筛选视图的回调(1.执行关闭筛选视图动画  2.请求并刷新数据,如等于当前筛选项则不操作)
    [self.filterTable setSelectedIndexBlock:^(NSInteger selectedIndex) {
        NSNumber *newSelectedIndex = [weakself.filters objectAtIndex:weakself.currentRankListIndex];
        
        if (newSelectedIndex.integerValue != selectedIndex) {//所选项和当前不一样,请求数据
            if (!YDHadLogin && (selectedIndex == 2 || selectedIndex == 5)) {//未登录
                [YDMBPTool showBriefAlert:@"未登录" time:1.f];
            }else{
                NSString *access_token = [YDUserDefault defaultUser].user.access_token;
                NSString *filter = nil;
                switch (selectedIndex) {
                    case 0:
                        filter = @"不限";
                        break;
                    case 1:
                        filter = @"nearby";
                        break;
                    case 2:
                        filter = @"friend";
                        break;
                    case 3:
                        filter = @"sexb";
                        break;
                    case 4:
                        filter = @"sexg";
                        break;
                    case 5:
                        filter = @"line";
                        break;
                    default:
                        filter = @"";
                        break;
                }
                NSDictionary *paraters = @{@"access_token":access_token,@"type":filter};
                if (selectedIndex == 1) {
                    NSString *lon = [NSString stringWithFormat:@"%f",[YDCurrentLocation shareCurrentLocation].coordinate.longitude];
                    NSString *lat = [NSString stringWithFormat:@"%f",[YDCurrentLocation shareCurrentLocation].coordinate.latitude];
                    NSString *location = [lon stringByAppendingString:[NSString stringWithFormat:@",%@",lat]];
                    paraters = @{@"access_token":access_token?access_token:@"",
                                 @"type":filter?filter:@"",
                                 @"ud_location":location?location:@""};
                }
                [weakself.currentRankingVC downloadRankingListData:_currentRankingVC.dataType-1 parameters:paraters];
                [weakself.filters replaceObjectAtIndex:weakself.currentRankListIndex withObject:@(selectedIndex)];
            }
            
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            weakself.filterTable.transform = CGAffineTransformMakeScale(1.05, 1.05);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                weakself.filterTable.alpha = 0;

                weakself.filterTable.frame = CGRectMake(screen_width-64, 64, 0, 0);
            } completion:^(BOOL finished) {
                [weakself.filterTable removeFromSuperview];
                [weakeffectView removeFromSuperview];
            }];
        }];
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.filterTable];
    [UIView animateWithDuration:0.3 animations:^{
        weakself.filterTable.alpha = 1;
        
        CGRect newFrame = CGRectMake(18, 208, screen_width-36, 6*weakself.filterTable.rowHeight);
        weakself.filterTable.frame = newFrame;
        weakself.filterTable.center = CGPointMake(screen_width/2, screen_height/2);
        weakself.filterTable.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            weakself.filterTable.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            
        }];
    }];
}
//点击手势移除筛选视图
- (void)tapEffectViewAction:(UITapGestureRecognizer *)tap{
    [UIView animateWithDuration:0.25 animations:^{
        self.filterTable.alpha = 0;
        self.filterTable.frame = CGRectMake(screen_width-64, 64, 0, 0);
    } completion:^(BOOL finished) {
        [tap.view removeFromSuperview];
        [self.filterTable removeFromSuperview];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    YDNavigationController *navc = (YDNavigationController *)self.navigationController;
    [navc hiddenBottomImageView:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    YDNavigationController *navc = (YDNavigationController *)self.navigationController;
    [navc hiddenBottomImageView:NO];
}

#pragma mark -- YSLContainerViewControllerDelegate
//容器控制器代理，当前控制器更改
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller{
    _currentRankingVC = (YDSingleRankingController *)controller;
    _currentRankListIndex = index;
    //[currentVC viewWillAppear:YES];
    if (_currentRankingVC.allData.count == 0) {
        [_currentRankingVC downloadRankingListData:_currentRankingVC.dataType parameters:_currentRankingVC.parameters];
    }
    if (_currentRankingVC.myselfModel) { //修改底部视图数据
        self.bottomView.hidden = _currentRankingVC.isTopTen;
        self.bottomView.type = self.currentRankListIndex+1;
        [self.bottomView setModel:_currentRankingVC.myselfModel];
    }
    
}

- (YDContainerController *)containerVC{
    if (!_containerVC) {
        // SetUp ViewControllers
        float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        YDContainerController *containerVC = [[YDContainerController alloc] initWithControllers:@[self.oneVC,self.twoVC,self.threeVC,self.fourVC,self.fiveVC,self.sixVC] topBarHeight:statusHeight parentController:self];
        containerVC.delegate = self;
        containerVC.scrollMenuViewHeight = 31.f;
        containerVC.menuItemFont = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        containerVC.menuItemTitleColor = [UIColor whiteColor];
        containerVC.menuBackgroudColor = [UIColor colorWithString:@"#2B3552"];
        
        _containerVC = containerVC;
    }
    return _containerVC;
}

- (YDSingleRankingController *)oneVC{
    if (!_oneVC) {
        _oneVC = [[YDSingleRankingController alloc] initWithDataType:YDRankingListDataTypeSpeed];
        _oneVC.title = @"时速";
        [_oneVC downloadRankingListData:_oneVC.dataType parameters:_oneVC.parameters];
        YDWeakSelf(self);
        [_oneVC setDownloadDataCompletionBlock:^(NSArray *data) {
            if (weakself.oneVC.myselfModel) {
                weakself.bottomView.hidden = weakself.oneVC.isTopTen;
                weakself.bottomView.type = weakself.currentRankListIndex+1;
                [weakself.bottomView setModel:weakself.oneVC.myselfModel];
            }
        }];
    }
    return _oneVC;
}

- (YDSingleRankingController *)twoVC{
    if (!_twoVC) {
        _twoVC = [[YDSingleRankingController alloc] initWithDataType:YDRankingListDataMileage];
        _twoVC.title = @"里程";
        YDWeakSelf(self);
        [_twoVC setDownloadDataCompletionBlock:^(NSArray *data) {
            UIViewController *vc = weakself.containerVC.childControllers[weakself.containerVC.currentIndex];
            [weakself containerViewItemIndex:weakself.containerVC.currentIndex currentController:vc];
        }];
    }
    return _twoVC;
}
- (YDSingleRankingController *)threeVC{
    if (!_threeVC) {
        _threeVC = [[YDSingleRankingController alloc] initWithDataType:YDRankingListDataTypeOilwear];
        _threeVC.title = @"油耗";
        YDWeakSelf(self);
        [_threeVC setDownloadDataCompletionBlock:^(NSArray *data) {
            UIViewController *vc = weakself.containerVC.childControllers[weakself.containerVC.currentIndex];
            [weakself containerViewItemIndex:weakself.containerVC.currentIndex currentController:vc];
        }];
    }
    return _threeVC;
}
- (YDSingleRankingController *)fourVC{
    if (!_fourVC) {
        _fourVC = [[YDSingleRankingController alloc] initWithDataType:YDRankingListDataTypeStop];
        _fourVC.title = @"滞留";
        YDWeakSelf(self);
        [_fourVC setDownloadDataCompletionBlock:^(NSArray *data) {
            UIViewController *vc = weakself.containerVC.childControllers[weakself.containerVC.currentIndex];
            [weakself containerViewItemIndex:weakself.containerVC.currentIndex currentController:vc];
        }];
    }
    return _fourVC;
}
- (YDSingleRankingController *)fiveVC{
    if (!_fiveVC) {
        _fiveVC = [[YDSingleRankingController alloc] initWithDataType:YDRankingListDataTypeScore];
        _fiveVC.title = @"积分";
        YDWeakSelf(self);
        [_fiveVC setDownloadDataCompletionBlock:^(NSArray *data) {
            UIViewController *vc = weakself.containerVC.childControllers[weakself.containerVC.currentIndex];
            [weakself containerViewItemIndex:weakself.containerVC.currentIndex currentController:vc];
        }];
    }
    return _fiveVC;
}
- (YDSingleRankingController *)sixVC{
    if (!_sixVC) {
        _sixVC = [[YDSingleRankingController alloc] initWithDataType:YDRankingListDataTypeLike];
        _sixVC.title = @"喜欢";
        YDWeakSelf(self);
        [_sixVC setDownloadDataCompletionBlock:^(NSArray *data) {
            UIViewController *vc = weakself.containerVC.childControllers[weakself.containerVC.currentIndex];
            [weakself containerViewItemIndex:weakself.containerVC.currentIndex currentController:vc];
        }];
    }
    return _sixVC;
}

- (YDSingleRankingBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[YDSingleRankingBottomView alloc] initWithFrame:CGRectMake(0, screen_height-125, screen_width, 61)];
        if (!YDHadLogin) {
            _bottomView.hidden = YES;
        }
    }
    return _bottomView;
}

@end

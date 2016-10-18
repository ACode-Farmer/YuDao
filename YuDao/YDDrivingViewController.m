//
//  DrivingViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDrivingViewController.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
#import "DataView.h"
#import "DrivingModel.h"
#import "LocationView.h"
#import "YDMainTitleView.h"
#import "YDDataTypeView.h"
#import "YDMainViewConfigure.h"
#import "YDDrivingDetailViewController.h"

@interface YDDrivingViewController ()

@property (nonatomic, strong) YDMainTitleView *titleView;
@property (nonatomic, strong) LocationView *locationView;
@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) DataView *dataview;
@property (nonatomic, strong) YDDataTypeView *dataTypeView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation YDDrivingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSArray *subViews = @[self.titleView,self.locationView,self.backgroundView,self.dataview,self.dataTypeView];
//    [subViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UIView *view = (UIView *)obj;
//        view.backgroundColor = [UIColor whiteColor];
//        view.opaque = 1;
//    }];
    self.titleView.backgroundColor = [UIColor whiteColor];
    self.locationView.backgroundColor = [UIColor clearColor];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.dataview.backgroundColor = [UIColor clearColor];
    self.dataTypeView.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Events
- (void)tapDataViewAction:(UIGestureRecognizer *)tap{
    [self.navigationController firstLevel_push_fromViewController:self toVC:[YDDrivingDetailViewController new]];
}

#pragma mark lazy load -

- (YDMainTitleView *)titleView{
    if (!_titleView) {
        _titleView = [YDMainTitleView new];
        [_titleView setTitle:@"行车信息" leftBtnImage:@"driving_car" rightBtnImage:@"more"];
        [self.view addSubview:_titleView];
        
        _titleView.sd_layout
        .leftSpaceToView(self.view,0)
        .rightSpaceToView(self.view,0)
        .topSpaceToView(self.view,0)
        .heightIs(kTitleViewHeight);
    }
    return _titleView;
}

- (UIImageView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"行车数据背景图"]];
        _backgroundView.userInteractionEnabled = YES;
        [self.view addSubview:_backgroundView];
        
        _backgroundView.sd_layout
        .topSpaceToView(self.titleView,0)
        .leftSpaceToView(self.view,0)
        .rightSpaceToView(self.view,0)
        .heightIs(kBackgroundViewHeight);
    }
    return _backgroundView;
}

- (LocationView *)locationView{
    if (!_locationView) {
        _locationView = [[LocationView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 40)];
        [self.backgroundView addSubview:_locationView];
    }
    return _locationView;
}

- (DataView *)dataview{
    if (!_dataview) {
        _dataview = [DataView new];
        _dataview.frame = CGRectMake(105 *widthHeight_ratio, 77*widthHeight_ratio, 155*widthHeight_ratio, 171*widthHeight_ratio);
        _dataview.model = [self.dataSource firstObject];
        UITapGestureRecognizer *tapDataView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDataViewAction:)];
        [_dataview addGestureRecognizer:tapDataView];
        
        [self.backgroundView addSubview:_dataview];
    }
    return _dataview;
}

- (YDDataTypeView *)dataTypeView{
    if (!_dataTypeView) {
        _dataTypeView = [[YDDataTypeView alloc] initWithTitleArray:@[@"天气",@"时速",@"油耗",@"里程",@"检测"]];
        __weak YDDrivingViewController *weakSelf = self;
        [_dataTypeView setButtonActionBlock:^(NSUInteger index) {
            weakSelf.dataview.model = weakSelf.dataSource[index];
        }];
        [self.view addSubview:_dataTypeView];
        
        _dataTypeView.sd_layout
        .topSpaceToView(self.backgroundView,0)
        .leftEqualToView(self.backgroundView)
        .rightEqualToView(self.backgroundView)
        .heightIs(kDataTypeViewHeight);
    }
    return _dataTypeView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:5];
        DrivingModel *Model1 = [DrivingModel modelWithTitle:@"当前温度"
                                                       data:@"26 C"
                                                   subTitle:@"晴天"];
        DrivingModel *Model2 = [DrivingModel modelWithTitle:@"当前油耗"
                                                       data:@"10.0L"
                                                   subTitle:@"剩余里程:300KM"];
        DrivingModel *Model3 = [DrivingModel modelWithTitle:@"当前时速"
                                                       data:@"68KM/h"
                                                   subTitle:@"请小心驾驶"];
        DrivingModel *Model4 = [DrivingModel modelWithTitle:@"今日里程"
                                                       data:@"100KM"
                                                   subTitle:@"本月里程"];
        DrivingModel *Model5 = [DrivingModel modelWithTitle:@"健康指数"
                                                       data:@"99"
                                                   subTitle:@"状态良好"];
        [_dataSource addObject:Model1];
        [_dataSource addObject:Model2];
        [_dataSource addObject:Model3];
        [_dataSource addObject:Model4];
        [_dataSource addObject:Model5];
    }
    return _dataSource;
}



@end

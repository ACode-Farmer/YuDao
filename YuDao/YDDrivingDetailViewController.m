//
//  YDDrivingDetailViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/18.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDrivingDetailViewController.h"
#import <PNChart.h>

@interface YDDrivingDetailViewController ()<PNChartDelegate>

@property (nonatomic, strong) UILabel *oneLabel;
@property (nonatomic, strong) UILabel *twoLabel;
@property (nonatomic, strong) UILabel *rankLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) PNLineChart *lineChart;

@end

@implementation YDDrivingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"里程";
    [self.view addSubview:self.topView];
    [self.view addSubview:self.lineChart];
    [self.view addSubview:self.bottomView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self updateTopView:@[@"昨日新增里程:75KM",@"本月行驶里程:1500KM",@"排名:09",@"2016/10/01 - 2016/10/07"]];
}

#pragma mark - Events
- (void)updateTopView:(NSArray *)data{
    _oneLabel.text = data[0];
    _twoLabel.text = data[1];
    _rankLabel.text = data[2];
    _titleLabel.text = data[3];
}


#pragma mark - Getters
- (PNLineChart *)lineChart{
    if (!_lineChart) {
        _lineChart = [[PNLineChart alloc ] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame)+5, screen_width, 250.0)];
        _lineChart.yLabelFormat = @"%1.1f";
        _lineChart.backgroundColor = [UIColor clearColor];
        _lineChart.xLabels = @[@"9/1",@"9/2",@"9/3",@"9/4",@"9/5",@"9/6",@"9/7"];
        _lineChart.showCoordinateAxis = YES;
        _lineChart.userInteractionEnabled = NO;
        _lineChart.yFixedValueMax = 100.0;
        _lineChart.yFixedValueMin = 0.0;
        
        _lineChart.yLabels = @[
                               @"0 KM",
                               @"25 KM",
                               @"50 KM",
                               @"75 KM",
                               @"100 KM"
                               ];
        
        NSArray * data01Array = @[@25, @35, @45, @55, @65, @25, @100];
        PNLineChartData *data01 = [PNLineChartData new];
        data01.dataTitle = @"Alpha";
        data01.color = PNFreshGreen;
        data01.alpha = 1;
        data01.itemCount = data01Array.count;
        data01.inflexionPointColor = PNRed;
        data01.inflexionPointStyle = PNLineChartPointStyleCircle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        data01.showPointLabel = YES;
        data01.pointLabelColor = [UIColor blackColor];
        data01.pointLabelFont = [UIFont font_13];
        data01.pointLabelFormat = [data01.pointLabelFormat stringByAppendingString:@"KM"];
        //折线图数据
        _lineChart.chartData = @[data01];
        
        //开始画线
        [_lineChart strokeChart];
        _lineChart.delegate  = self;
        
        //测试属性
        _lineChart.xLabelFont = [UIFont font_14];
        _lineChart.yLabelFont = [UIFont font_16];
        _lineChart.showSmoothLines = YES;
        
    }
    return _lineChart;
}

#pragma mark - Getters
- (UIView *)topView{
    if (!_topView) {
        _topView = [UIView new];
        _topView.frame = CGRectMake(0, 64, screen_width, 75);
        _oneLabel = [UILabel new];
        _twoLabel = [UILabel new];
        _rankLabel = [UILabel new];
        _titleLabel = [UILabel new];
        NSArray *views = @[_oneLabel,_twoLabel,_rankLabel,_titleLabel];
        [_topView sd_addSubviews:views];
        [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *label = (UILabel *)obj;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont font_14];
            label.backgroundColor = [UIColor clearColor];
        }];
        
        _oneLabel.frame = CGRectMake(5, 5, screen_width/2, 21);
        _twoLabel.frame = CGRectMake(5, CGRectGetMaxY(_oneLabel.frame), screen_width/2, 21);
        _rankLabel.frame = CGRectMake(screen_width/2, _topView.height/2 - 11, screen_width/2-50, 22);
        _rankLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.frame = CGRectMake(screen_width/5, CGRectGetMaxY(_twoLabel.frame)+5, 3*screen_width/5, 21);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _topView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.lineChart.frame)+10, screen_width, 100);
        UILabel *oneLabel = [UILabel new];
        oneLabel.text = @"12KM";
        UILabel *twoLabel = [UILabel new];
        twoLabel.text = @"350KM";
        UILabel *threeLabel = [UILabel new];
        threeLabel.text = @"1500KM";
        
        NSArray *labels = @[oneLabel,twoLabel,threeLabel];
        [_bottomView sd_addSubviews:labels];
        [labels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *la = (UILabel *)obj;
            la.font = [UIFont font_17];
            la.textAlignment = NSTextAlignmentCenter;
        }];
        
        oneLabel.frame = CGRectMake(0, 0, screen_width/3-1, 100);
        twoLabel.frame = CGRectMake(screen_width/3, 0, screen_width/3, 100);
        threeLabel.frame = CGRectMake(2*screen_width/3+1, 0, screen_width/3-1, 100);
        
        UIView *topLine = [UIView new];
        topLine.backgroundColor = [UIColor colorGrayLine];
        topLine.frame = CGRectMake(0, 0, screen_width, 1);
        UIView *leftLine = [UIView new];
        leftLine.backgroundColor = [UIColor colorGrayLine];
        UIView *rightLine = [UIView new];
        rightLine.backgroundColor = [UIColor colorGrayLine];
        
        leftLine.frame = CGRectMake(screen_width/3-1, 0, 1, 100);
        rightLine.frame = CGRectMake(2*screen_width/3, 0, 1, 100);
        
        [_bottomView sd_addSubviews:@[topLine,leftLine,rightLine]];
    }
    return _bottomView;
}

@end

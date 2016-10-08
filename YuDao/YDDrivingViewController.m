//
//  DrivingViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDrivingViewController.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
#import "CornerButton.h"
#import "DataView.h"
#import "DrivingModel.h"
#import "LocationView.h"

@interface YDDrivingViewController ()

@property (nonatomic, strong) UIButton *titleBtn;

@property (nonatomic, strong) LocationView *locationView;

@property (nonatomic, strong) CornerButton *weatherBtn;
@property (nonatomic, strong) CornerButton *oilwearBtn;
@property (nonatomic, strong) CornerButton *speedBtn;
@property (nonatomic, strong) CornerButton *mileageBtn;
@property (nonatomic, strong) CornerButton *testBtn;
@property (nonatomic, strong) UILabel *speedLabel;
@property (nonatomic, strong) UILabel *mileageLabel;
@property (nonatomic, strong) UILabel *testLabel;

@property (nonatomic, strong) DataView *dataview;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIImageView *backgroundView;

@property (nonatomic, strong) NSMutableArray *bottomBtns;

@end

@implementation YDDrivingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.titleBtn;
    
    _backgroundView = [UIImageView new];
    _backgroundView.userInteractionEnabled = YES;
    _backgroundView.image = [UIImage imageNamed:@"010.jpg"];
    [self.view addSubview:_backgroundView];
    [_backgroundView addSubview:self.locationView];
    _backgroundView.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightRatioToView(self.view,1);
    
    _dataview = [DataView new];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDataView:)];
    [_dataview addGestureRecognizer:tap];
    [_backgroundView addSubview:_dataview];
   
    _dataview.sd_layout
    .centerXEqualToView(_backgroundView)
    .centerYEqualToView(_backgroundView)
    .widthRatioToView(_backgroundView,0.5)
    .heightEqualToWidth();
    
    _dataview.model = self.dataSource[0];
    
    //五个操作按钮
    _weatherBtn = [CornerButton circularButtonWithTitle:@"天气"
                                        backgroundColor:[UIColor orangeColor]];
    _oilwearBtn = [CornerButton circularButtonWithTitle:@"油耗"
                                        backgroundColor:[UIColor orangeColor]];
    _speedBtn = [CornerButton circularButtonWithImageName:@"carIcon"];
    _mileageBtn = [CornerButton circularButtonWithImageName:@"carIcon"];
    _testBtn = [CornerButton circularButtonWithImageName:@"carIcon"];
    NSArray *btns = @[_weatherBtn,_oilwearBtn,_speedBtn,_mileageBtn,_testBtn];
    [btns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CornerButton *btn = (CornerButton *)obj;
        btn.tag = 1000+idx;
        [btn addTarget:self action:@selector(operationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundView addSubview:btn];
    }];
   
    _weatherBtn.sd_layout
    .centerYEqualToView(_dataview)
    .leftSpaceToView(_backgroundView,20)
    .heightRatioToView(_dataview,0.3)
    .widthEqualToHeight();
    
    _oilwearBtn.sd_layout
    .centerYEqualToView(_dataview)
    .rightSpaceToView(_backgroundView,20)
    .heightRatioToView(_dataview,0.3)
    .widthEqualToHeight();
    
    _mileageBtn.sd_layout
    .centerXEqualToView(_backgroundView)
    .bottomSpaceToView(_backgroundView,40)
    .heightRatioToView(_dataview,0.3)
    .widthEqualToHeight();
    
    _speedBtn.sd_layout
    .leftSpaceToView(_backgroundView,40)
    .bottomEqualToView(_mileageBtn)
    .heightRatioToView(_dataview,0.3)
    .widthEqualToHeight();
    
    _testBtn.sd_layout
    .rightSpaceToView(_backgroundView,40)
    .bottomEqualToView(_mileageBtn)
    .heightRatioToView(_dataview,0.3)
    .widthEqualToHeight();
    
    //三个下标
    _speedLabel = [UILabel new];
    _speedLabel.text = @"时速";
    _mileageLabel = [UILabel new];
    _mileageLabel.text = @"里程";
    _testLabel = [UILabel new];
    _testLabel.text = @"检测";
    NSArray *labels = @[_speedLabel,_mileageLabel,_testLabel];
    for (UILabel *label in labels) {
        label.textAlignment = NSTextAlignmentCenter;
    }
    [_backgroundView sd_addSubviews:labels];
    
    _speedLabel.sd_layout
    .topSpaceToView(_speedBtn,5)
    .leftEqualToView(_speedBtn)
    .rightEqualToView(_speedBtn)
    .heightIs(21);
    
    _mileageLabel.sd_layout
    .topSpaceToView(_mileageBtn,5)
    .leftEqualToView(_mileageBtn)
    .rightEqualToView(_mileageBtn)
    .heightIs(21);
    
    _testLabel.sd_layout
    .topSpaceToView(_testBtn,5)
    .leftEqualToView(_testBtn)
    .rightEqualToView(_testBtn)
    .heightIs(21);
}

#pragma mark lazy load - 
- (UIButton *)titleBtn{
    if (!_titleBtn) {
        _titleBtn = [UIButton buttonWithType:0];
        _titleBtn.frame = CGRectMake(0, 0, 150, 40);
        [_titleBtn setTitle:@"BMW 6666" forState:0];
        [_titleBtn setTitleColor:[UIColor blackColor] forState:0];
        [_titleBtn setImage:[UIImage imageNamed:@"set"] forState:0];
        [_titleBtn setImage:[UIImage imageNamed:@"set"] forState:1];
        [_titleBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:3];
    }
    return _titleBtn;
}

- (LocationView *)locationView{
    if (!_locationView) {
        _locationView = [[LocationView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 40)];
    }
    return _locationView;
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

- (NSMutableArray *)bottomBtns{
    if (!_bottomBtns) {
        _bottomBtns = [NSMutableArray arrayWithObjects:_speedBtn,_mileageBtn,_testBtn, nil];
    }
    return _bottomBtns;
}

#pragma tapDataView action -
- (void)tapDataView:(UIGestureRecognizer *)tap{
    NSLog(@"点击了数据视图...");
}

#pragma buttons action - 
- (void)operationButtonAction:(UIButton *)sender{
    NSInteger index = sender.tag - 1000;
    DrivingModel *model = self.dataSource[index];
    _dataview.model = model;
    [self.bottomBtns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx !=0 ||idx != 1) {
            CornerButton *btn = (CornerButton *)obj;
            if (btn.tag == sender.tag) {
                btn.backgroundColor = [UIColor orangeColor];
            }else{
                btn.backgroundColor = [UIColor whiteColor];
            }
        }
    }];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"class = %@",NSStringFromClass([self class]));
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

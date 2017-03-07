//
//  YDTestViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/12/1.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTestViewController.h"

#import "YDGarageViewController.h"
#import "YDCircleProgressView.h"

#import "YDTestBaseCell.h"
#import "YDTestModel.h"
#import "YDTirePressureCell.h"
#import "YDPopTableView.h"

#import "DYTPopupManager.h"

@interface YDTestViewController ()<UITableViewDelegate,UITableViewDataSource,DYTPopupManagerDelegate>


@property (nonatomic, strong) YDTestModel   *model;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YDCircleProgressView *circleView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic,strong) YDPopTableView *popView;

@property (nonatomic, strong) DYTPopupManager   *popViewManager;



@end

@implementation YDTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self y_initUI];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)y_initUI{
    [self.navigationItem setTitle:@"测一测"];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"discover_test_set"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self.view addSubview:self.tableView];
    YDWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself downloadTestData];
    }];
    
    if (self.car) {//从首页过来
        
    }else{        //从发现过来
        self.car = [[YDCarHelper sharedHelper] defaultOrBindObdCar];
    }
    
    [self downloadTestData];
}

- (void)downloadTestData{
    if (self.car.ug_boundtype.integerValue != 1) {//没有绑定VE-BOX
        [self.tableView.mj_header endRefreshing];
        [self.circleView setHidePrompt:NO];
        return;
    }
    [self.circleView setHidePrompt:YES];
    YDWeakSelf(self);
    NSDictionary *parameters  = @{@"access_token":[YDUserDefault defaultUser].user.access_token,
                                    @"ug_id"  :self.car.ug_id?self.car.ug_id:@0};
    
    [YDNetworking getUrl:kTestDataURL parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dataDic = [responseObject mj_JSONObject];
        
        weakself.model = [YDTestModel mj_objectWithKeyValues:[dataDic objectForKey:@"data"]];
        
        [_circleView startAnimationWithPercent:weakself.model.ug_health.floatValue];
        YDTestDetailModel *model1 = [YDTestDetailModel modelWithTitle:@"胎压监测" subTitle:@"" backgImageString:@"discover_test_tirePressure" data:@"" oilMessage:@""];
        //**********  胎压数据  ************
        model1.lftt = YDNumberToString(weakself.model.lftt);
        model1.lftp = YDNumberToString(weakself.model.lftp);
        model1.rftt = YDNumberToString(weakself.model.rftt);
        model1.rftp = YDNumberToString(weakself.model.rftp);
        model1.lrtt = YDNumberToString(weakself.model.lrtt);
        model1.lrtp = YDNumberToString(weakself.model.lrtp);
        model1.rrtt = YDNumberToString(weakself.model.rrtt);
        model1.rrtp = YDNumberToString(weakself.model.rrtp);
        
        YDTestDetailModel *model2 = [YDTestDetailModel modelWithTitle:@"蓄电池" subTitle:@"当前电压" backgImageString:@"discover_test_battery" data:YDNumberToString(weakself.model.sample_8) oilMessage:@""];
//        YDTestDetailModel *model3 = [YDTestDetailModel modelWithTitle:@"油量" subTitle:@"剩余油量" backgImageString:@"discover_test_oil" data:YDNumberToString(weakself.model.oilmass) oilMessage:@""];
        YDTestDetailModel *model4 = [YDTestDetailModel modelWithTitle:@"冷却液" subTitle:@"冷却液温度" backgImageString:@"discover_test_coolant" data:YDNumberToString(weakself.model.sample_2) oilMessage:@""];
        YDTestDetailModel *model5 = [YDTestDetailModel modelWithTitle:@"车辆故障码" subTitle:@"正常" backgImageString:@"discover_test_faultCode" data:@"" oilMessage:@""];
        weakself.data = [NSMutableArray arrayWithArray:@[model2,model4,model5]];
        
        if (weakself.model.tirepressure.integerValue == 1) {
            [weakself.data insertObject:model1 atIndex:0];
        }
        [weakself.tableView reloadData];
        [weakself.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [weakself.tableView.mj_header endRefreshing];
        NSLog(@"error = %@",error);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data? self.data.count : 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDTestBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDTestBaseCell"];
    if (indexPath.row == 0 && self.model.tirepressure.integerValue == 1) {
        YDTirePressureCell *tirePreCell = [tableView dequeueReusableCellWithIdentifier:@"YDTirePressureCell"];
        tirePreCell.model = self.data[indexPath.row];
        return tirePreCell;
    }
    cell.model = self.data[indexPath.row];
    return cell;
}

#pragma mark - Events
- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender{
    NSArray *cars = [YDCarHelper sharedHelper].carArray;
    __block NSInteger index = 0;
    [cars enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YDCarDetailModel *car = obj;
        if ([car.ug_series_name isEqualToString:self.car.ug_series_name]) {
            index = idx;
            *stop = YES;
        }
    }];
    self.popView = [[YDPopTableView alloc] initWithDataSource:cars selectedIndex:index];
    CGRect newFrame = CGRectMake(0, 0, screen_width-20, cars.count*self.popView.rowHeight);
    self.popView.frame = newFrame;
    
    YDWeakSelf(self);
    [self.popView setSelectedCarBlock:^(YDCarDetailModel *model) {
        weakself.car = model;
        [weakself downloadTestData];
        [weakself.popViewManager hiddenPopupViewWithAnimation:YES];
    }];
    
    [self.popViewManager showPopupViewWithView:self.popView style:DYTPopupStyleNone maskStyle:DYTPopupMaskStyleGray position:DYTPopupPositionCenter animation:YES];
    
}



#pragma mark - Getters
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.frame = CGRectMake(0, 0, screen_width, screen_height-64);
        _tableView.rowHeight = 165.f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YDTestBaseCell class] forCellReuseIdentifier:@"YDTestBaseCell"];
        [_tableView registerClass:[YDTirePressureCell class] forCellReuseIdentifier:@"YDTirePressureCell"];
        
        _tableView.tableHeaderView = ({
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 340)];
            UIView *backgroudView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, screen_width-20, 340-20)];
            backgroudView.backgroundColor = [UIColor whiteColor];
            backgroudView.layer.cornerRadius = 8.0f;
            //backgroudView.layer.borderColor = [UIColor colorWithString:@"#2B3552"].CGColor;
           // backgroudView.layer.borderWidth = 1.0f;
            backgroudView.layer.shadowColor = [UIColor colorWithString:@"#2B3552"].CGColor;
            backgroudView.layer.shadowOffset = CGSizeMake(0, 0);
            backgroudView.layer.shadowRadius = 3.0f;
            backgroudView.layer.shadowOpacity = 1.0f;
            
            UILabel *titleLabel = [YDUIKit labelWithTextColor:[UIColor colorWithString:@"#2B3552"] text:@"车况评分" fontSize:22 textAlignment:NSTextAlignmentCenter];
            titleLabel.frame = CGRectMake((screen_width-100)/2, 21, 100, 30);
            _circleView = [[YDCircleProgressView alloc] initWithFrame:CGRectMake((screen_width-222)/2, 66, 222, 222)];
            
            _timeLabel = [YDUIKit labelTextColor:[UIColor colorWithString:@"#2B3552"] fontSize:12 textAlignment:NSTextAlignmentCenter];
            _timeLabel.frame = CGRectMake((screen_width-250)/2, 340-17-17, 250, 17);
            _timeLabel.text = [NSString stringWithFormat:@"%@%@",@"最后更新时间: ",[[NSDate date] dateToString_yyyy_MM_dd_HH_mm]];
            
            [headerView sd_addSubviews:@[backgroudView,titleLabel,_circleView,_timeLabel]];
            headerView;
        });
    }
    return _tableView;
}

- (DYTPopupManager *)popViewManager{
    if (!_popViewManager) {
        _popViewManager = [[DYTPopupManager alloc] init];
        _popViewManager.delegate = self;
    }
    return _popViewManager;
}


@end

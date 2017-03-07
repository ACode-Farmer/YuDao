//
//  YDWeatherController.m
//  YuDao
//
//  Created by 汪杰 on 16/12/15.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDWeatherController.h"
#import "YDNavigationController.h"

@interface YDWeatherController ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *titleView;

@end

@implementation YDWeatherController
{
    NSArray     *_icons;
    NSArray     *_titles;
    NSArray     *_subTitles;
    
    UIImageView *_navBarHairlineImageView;
    
    UILabel   *_cityLabel;
    
    UILabel    *_todayTem;//当前温度
    UIImageView *_todayWea;
    
    UILabel    *_temD;//今日气温
    UILabel    *_airD;//空气指数
    UILabel    *_airC;//空气质量
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.titleView;
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.rowHeight = 75;
    self.tableView.scrollEnabled = YES;
    [self.tableView setTableHeaderView:self.topView];
    [self.tableView registerClass:[YDWeatherCell class] forCellReuseIdentifier:@"YDWeatherCell"];
    
    
    _icons = @[@"weather_car",@"weather_clother",@"weather_exercise",@"weather_travel"];
    _titles = @[@"洗车指数",@"穿衣指数",@"运动指数",@"旅游指数"];
    
    _subTitles = @[self.model.car?self.model.car:@"暂无数据",
                   self.model.clothes?self.model.clothes:@"暂无数据",
                   self.model.sports?self.model.sports:@"暂无数据",
                   self.model.travel?self.model.travel:@"暂无数据"];
    for (NSString *ssss in _subTitles) {
        NSLog(@"ssss = %@",ssss);
    }
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDWeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDWeatherCell"];
    cell.iconV.image = [UIImage imageNamed:_icons[indexPath.row]];
    cell.titleLabel.text = _titles[indexPath.row];
    cell.subTitleLabel.text = _subTitles[indexPath.row];
    
    return cell;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    if (point.y < 0) {
        [self.tableView setContentOffset:CGPointZero];
    }
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor colorWithString:@"#7B90D2"];
        _topView.frame = CGRectMake(0,0,screen_width,screen_width*0.85);
        
        UIImageView *backgroundImageV = [[UIImageView alloc] initWithFrame:_topView.bounds];
        [_topView addSubview:backgroundImageV];
        
        UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, screen_width*0.85-10, screen_width, 10)];
        topLineView.backgroundColor= [UIColor whiteColor];
        [_topView addSubview:topLineView];
        UIImageView *verImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weather_verLine"]];
        [_topView addSubview:verImageV];
        verImageV.sd_layout
        .centerXEqualToView(_topView)
        .bottomSpaceToView(_topView,2)
        .heightIs(104)
        .widthIs(2);
        
        UIImageView *horImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weather_horLine"]];
        [_topView addSubview:horImageV];
        
        horImageV.sd_layout
        .leftEqualToView(_topView)
        .rightEqualToView(_topView)
        .bottomSpaceToView(verImageV,2)
        .heightIs(1);
        
        UILabel *temLabel = [YDUIKit labelWithTextColor:[UIColor whiteColor] text:@"今日气温" fontSize:14 textAlignment:0];
        UILabel *temD = [YDUIKit labelTextColor:[UIColor whiteColor] fontSize:30];
        UILabel *temC = [YDUIKit labelWithTextColor:[UIColor whiteColor] text:@"℃" fontSize:16 textAlignment:0];
        [_topView sd_addSubviews:@[temLabel,temD,temC]];
        temLabel.sd_layout
        .leftSpaceToView(_topView,17)
        .topSpaceToView(horImageV,15)
        .heightIs(20);
        [temLabel setSingleLineAutoResizeWithMaxWidth:150];
        
        temD.sd_layout
        .leftSpaceToView(temLabel,0)
        .topSpaceToView(temLabel,13)
        .heightIs(30);
        [temD setSingleLineAutoResizeWithMaxWidth:150];
        temD.text = @"~-~";
        
        temC.sd_layout
        .topEqualToView(temD)
        .leftSpaceToView(temD,1)
        .widthIs(30)
        .heightIs(18);
        
        UILabel *airLabel = [YDUIKit labelWithTextColor:[UIColor whiteColor] text:@"空气指数" fontSize:14 textAlignment:0];
        UILabel *airD = [YDUIKit labelTextColor:[UIColor whiteColor] fontSize:30];
        UILabel *airC = [YDUIKit labelTextColor:[UIColor whiteColor] fontSize:14];
        [_topView sd_addSubviews:@[airLabel,airC,airD]];
        airLabel.sd_layout
        .centerYEqualToView(temLabel)
        .leftSpaceToView(verImageV,17)
        .heightIs(20);
        [airLabel setSingleLineAutoResizeWithMaxWidth:150];
        
        airD.sd_layout
        .centerYEqualToView(temD)
        .leftSpaceToView(airLabel,0)
        .heightIs(30);
        [airD setSingleLineAutoResizeWithMaxWidth:150];
        airD.text = @"~";
        
        airC.sd_layout
        .topEqualToView(airD)
        .leftSpaceToView(airD,1)
        .widthIs(50)
        .heightIs(18);
        airC.text = @"~";
        
        temD.text = [NSString stringWithFormat:@"%@-%@",self.model.nightTem?self.model.nightTem:@"~",self.model.dayTem?self.model.dayTem:@"~"];
        _temD = temD;
        airD.text = [NSString stringWithFormat:@"%@",self.model.airNum?self.model.airNum:@"~"];
        _airD = airD;
        airC.text = self.model.airQuality?self.model.airQuality:@"~";
        _airC = airC;
        
        UILabel *todayTem = [YDUIKit labelTextColor:[UIColor whiteColor] fontSize:120];
        UILabel *todayC   = [YDUIKit labelWithTextColor:[UIColor whiteColor] text:@"℃" fontSize:30 textAlignment:0];
        
        
        NSString *weatherImageName = [self.model.weatherCode weatherImageNameByWeatherCode:self.model.weatherCode imageType:1];
        backgroundImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_bg",weatherImageName]];
        UIImageView *todayWea = [[UIImageView alloc] initWithImage:[UIImage imageNamed:weatherImageName]];
        [_topView sd_addSubviews:@[todayTem,todayC,todayWea]];
        
        todayTem.sd_layout
        .centerXEqualToView(_topView)
        .topSpaceToView(_topView,40)
        .heightIs(120);
        [todayTem setSingleLineAutoResizeWithMaxWidth:150];
        todayTem.text = @"~";
        
        todayC.sd_layout
        .bottomSpaceToView(todayTem,-50)
        .leftSpaceToView(todayTem,1)
        .heightIs(30)
        .widthIs(40);
        
        todayWea.sd_layout
        .topSpaceToView(todayTem,-45)
        .leftSpaceToView(todayTem,1)
        .heightIs(30)
        .widthIs(48);
        
        todayTem.text = self.model.temperature;
        _todayTem = todayTem;
        _todayWea = todayWea;
    }
    return _topView;
}

- (UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        _titleView.frame = CGRectMake((screen_width-250)/2, 0, 250, 30);
        
        UIImageView *locIamgeV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardriving_location" ]];
        UILabel *cityLabel = [YDUIKit labelTextColor:[UIColor whiteColor] fontSize:16];
        [_titleView sd_addSubviews:@[locIamgeV,cityLabel]];
        
        cityLabel.sd_layout
        .centerYEqualToView(_titleView)
        .centerXEqualToView(_titleView)
        .heightIs(21);
        [cityLabel setSingleLineAutoResizeWithMaxWidth:150];
        cityLabel.text = @"上海市";
        
        locIamgeV.sd_layout
        .centerYEqualToView(_titleView)
        .rightSpaceToView(cityLabel,3)
        .heightIs(17)
        .widthIs(10);
        
        _cityLabel = cityLabel;
    }
    return _titleView;
}

@end

//
//  YDCarDetailViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDCarDetailViewController.h"
#import "MCommonModel.h"
#import "IDCardViewController.h"

@interface YDCarDetailViewController ()

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) UIView *footView;

@end

@implementation YDCarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = self.footView;
    self.title = @"车辆资料";
}

#pragma mark - Events
- (void)identifierBtnAction:(UIButton *)sender{
    IDCardViewController *idVC = [IDCardViewController new];
    idVC.variableTitle = @"车辆认证";
    idVC.firstTitle = @"请拍照上传行驶证正本";
    idVC.secondTitle = @"请拍照上传行驶证副本";
    [self.navigationController secondLevel_push_fromViewController:self toVC:idVC];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data? self.data.count:0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"CarDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.detailTextLabel.font = [UIFont font_13];
    }
    MCommonModel *model = self.data[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.subTitle;
    return cell;
}

#pragma mark - Getters
- (UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 80)];
        UIButton *button = [UIButton new];
        button.backgroundColor = [UIColor orangeColor];
        [button setTitle:@"我要认证" forState:0];
        [button setTitleColor:[UIColor whiteColor] forState:0];
        [button addTarget:self action:@selector(identifierBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:button];
        button.sd_layout
        .topSpaceToView(_footView,10)
        .leftSpaceToView(_footView,20)
        .rightSpaceToView(_footView,20)
        .heightRatioToView(_footView,0.6);
    }
    return _footView;
}

- (NSMutableArray *)data{
    if (!_data) {
        
        MCommonModel *model0 = [MCommonModel normalModelWithTitle:@"品牌" subTitle:@"凯迪拉克"];
        MCommonModel *model1 = [MCommonModel normalModelWithTitle:@"车系" subTitle:@"超级至尊版"];
        MCommonModel *model2 = [MCommonModel normalModelWithTitle:@"车型" subTitle:@"2016款 超级至尊豪华版"];
        MCommonModel *model3 = [MCommonModel normalModelWithTitle:@"车牌号" subTitle:@"沪A 66666"];
        MCommonModel *model4 = [MCommonModel normalModelWithTitle:@"发动机号" subTitle:@"15963245"];
        MCommonModel *model5 = [MCommonModel normalModelWithTitle:@"车辆违章地" subTitle:@"上海"];
        MCommonModel *model6 = [MCommonModel normalModelWithTitle:@"车辆违章时间" subTitle:@"2016-10-01"];
        MCommonModel *model7 = [MCommonModel normalModelWithTitle:@"车辆认证" subTitle:@"已认证"];
        MCommonModel *model8 = [MCommonModel normalModelWithTitle:@"车检时间" subTitle:@"2016-10-10"];
        MCommonModel *model9 = [MCommonModel normalModelWithTitle:@"上次保养时间" subTitle:@"2016-10－15"];
        _data  = [NSMutableArray arrayWithObjects:model0,model1,model2,model3,model4,model5,model6,model7,model8,model9, nil];
    }
    return _data;
}

@end

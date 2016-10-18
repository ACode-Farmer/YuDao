//
//  YDGarageViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDGarageViewController.h"
#import "YDCarDetailViewController.h"
#import "YDIllegalViewController.h"
#import "YDGarageCell.h"
#import "YDGarageModel.h"

NSString *const kGarageCellId = @"YDGarageCell";

@interface YDGarageViewController ()<YDGarageCellDelegate>

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation YDGarageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的车库";
    
    self.tableView.rowHeight = 165*widthHeight_ratio;
    [self.tableView registerClass:[YDGarageCell class] forCellReuseIdentifier:kGarageCellId];
}

#pragma mark - Custom Delegate
- (void)garageCellWithTitle:(NSString *)title{
    if ([title isEqualToString:@"违章查询"]) {
        [self.navigationController secondLevel_push_fromViewController:self toVC:[YDIllegalViewController new]];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"未认证不可查询相关信息!"
                                                       delegate:nil
                                              cancelButtonTitle:@"YES" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data? self.data.count:0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDGarageCell *cell = [tableView dequeueReusableCellWithIdentifier:kGarageCellId];
    cell.model = self.data[indexPath.row];
    cell.delegate = self;
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController secondLevel_push_fromViewController:self toVC:[YDCarDetailViewController new]];
}

#pragma mark - Getters
- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray arrayWithCapacity:5];
        YDGarageModel *model1 = [YDGarageModel modelWithCarImageName:@"head0.jpg" carName:@"凯迪拉克" isIdentified:YES carModel:@"2016款 超级至尊豪华版" checkTitle:@"违章查询"];
        YDGarageModel *model2 = [YDGarageModel modelWithCarImageName:@"head0.jpg" carName:@"凯迪拉克" isIdentified:NO carModel:@"2016款 超级至尊豪华版" checkTitle:@"未认证不可查询违章信息"];
        [_data addObject:model1];
        [_data addObject:model2];
    }
    return _data;
}

@end

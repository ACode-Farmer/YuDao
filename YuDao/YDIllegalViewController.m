//
//  YDIllegalViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/18.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDIllegalViewController.h"

@interface YDIllegalViewController ()

@end

@implementation YDIllegalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"违章记录";
}


#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data ? self.data.count: 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *YDLCellID = @"YDLCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YDLCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:YDLCellID];
    }
    NSDictionary *dic = self.data[indexPath.row];
    cell.textLabel.text = [dic allKeys][0];
    cell.detailTextLabel.text = [dic valueForKey:cell.textLabel.text];
    return cell;
}


#pragma mark - Getters
- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray arrayWithObjects: @{@"时间":@"2016-10-10"},
                                                  @{@"车牌号":@"沪A 159456"},
                                                  @{@"地点":@"金沙江路"},
                                                  @{@"违规":@"闯红灯"},
                                                  @{@"罚款":@"400元"},
                                                  @{@"记分":@"2分"},
                                                  @{@"状态":@"未缴款"}, nil];
    }
    return _data;
}


@end

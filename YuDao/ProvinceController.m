//
//  ProvinceController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "ProvinceController.h"
#import "CityController.h"

@interface ProvinceController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ProvinceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地区";
    
}

#pragma mark - TableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource? self.dataSource.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"ProvinceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = 1;
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CityController *cvc = [CityController new];
    cvc.provinceTitle = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:cvc animated:YES];
}

#pragma mark - Getters
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil];
        NSArray *data = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *dic in data) {
            NSString *key = [[dic allKeys] firstObject];
            [_dataSource addObject:key];
        }
    }
    return _dataSource;
}

@end

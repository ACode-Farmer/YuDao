//
//  CityController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "CityController.h"
#import "DistrictController.h"
#import "MyInformationController.h"

@interface CityController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) UITableViewCellAccessoryType cellType;

@end

@implementation CityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.provinceTitle;
    
}

#pragma mark - TableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count ? self.dataSource.count: 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = self.cellType;
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellType == 0) {
        NSArray *controllers = self.navigationController.viewControllers;
        for (UIViewController *rootVC in controllers) {
            if ([rootVC isKindOfClass:[MyInformationController class]]) {
                [self.navigationController popToViewController:rootVC animated:YES];
            }
        }
        NSString *place = [self.title stringByAppendingString:self.dataSource[indexPath.row]];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:place forKey:@"常出没地点"];
        [defaults synchronize];
    }else{
        DistrictController *disVC = [DistrictController new];
        disVC.provinceTitle = self.provinceTitle;
        disVC.cityTitle = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:disVC animated:YES];
    }
}

#pragma mark - Getters
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil];
        NSArray *data = [NSArray arrayWithContentsOfFile:path];
        NSArray *bigCitys = @[@"北京市",@"天津市",@"上海市",@"重庆市"];
        if ([bigCitys containsObject:self.provinceTitle]) {
            for (NSDictionary *dic in data) {
                NSArray *array = [dic objectForKey:self.provinceTitle];
                for (NSDictionary *subDic in array) {
                    NSString *city = [[subDic allKeys] firstObject];
                    if ([city isEqualToString:self.provinceTitle]) {
                        NSArray *disArray = [subDic objectForKey:city];
                        _dataSource = [NSMutableArray arrayWithArray:disArray];
                    }
                }
            }
            self.cellType = 0;
        }else{
            _dataSource = [NSMutableArray array];
            for (NSDictionary *dic in data) {
                NSArray *array = [dic objectForKey:self.provinceTitle];
                for (NSDictionary *subDic in array) {
                    NSString *city = [[subDic allKeys] firstObject];
                    [_dataSource addObject:city];
                }
            }
            self.cellType = 1;
        }
    }
    return _dataSource;
}


@end

//
//  DistrictController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "DistrictController.h"
#import "MyInformationController.h"

@interface DistrictController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation DistrictController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.cityTitle;
    
}

#pragma mark - TableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource? self.dataSource.count: 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"DistrictCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
}

#pragma mark - Getters
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil];
        NSArray *data = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *dic in data) {
            NSArray *array = [dic objectForKey:self.provinceTitle];
            for (NSDictionary *subDic in array) {
                NSString *city = [[subDic allKeys] firstObject];
                if ([city isEqualToString:self.cityTitle]) {
                    NSArray *disArray = [subDic objectForKey:city];
                    _dataSource = [NSMutableArray arrayWithArray:disArray];
                }
            }
        }
    }
    return _dataSource;
}


@end

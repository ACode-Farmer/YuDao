//
//  BrandViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/28.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "BrandViewController.h"
#import "SortTableView.h"
#import "YDContactsModel.h"

@interface BrandViewController ()

@property (nonatomic, strong) SortTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation BrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"品牌";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Getters
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        YDContactsModel *model1 = [YDContactsModel modelWith:@"AAA"];
        YDContactsModel *model2 = [YDContactsModel modelWith:@"BBB"];
        YDContactsModel *model3 = [YDContactsModel modelWith:@"CCC"];
        YDContactsModel *model4 = [YDContactsModel modelWith:@"DDD"];
        YDContactsModel *model5 = [YDContactsModel modelWith:@"EEE"];
    
        _dataSource = [NSMutableArray arrayWithObjects:model1,model2,model3,model4,model5, nil];
    }
    return _dataSource;
}

- (SortTableView *)tableView{
    if (!_tableView) {
        _tableView = [[SortTableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-64) style:UITableViewStylePlain dataSource:self.dataSource];
    }
    return _tableView;
}


@end

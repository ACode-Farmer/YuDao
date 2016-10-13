//
//  BrandViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/28.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "BrandViewController.h"
#import "SortTableView.h"
#import "ContactsModel.h"

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
        ContactsModel *model1 = [ContactsModel modelWith:@"AAA"];
        ContactsModel *model2 = [ContactsModel modelWith:@"BBB"];
        ContactsModel *model3 = [ContactsModel modelWith:@"CCC"];
        ContactsModel *model4 = [ContactsModel modelWith:@"DDD"];
        ContactsModel *model5 = [ContactsModel modelWith:@"EEE"];
    
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

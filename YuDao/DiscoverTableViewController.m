//
//  DiscoverTableViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "DynamicTableViewController.h"
#import "YDRankingViewController.h"
#import "DiscoverModel.h"

@interface DiscoverTableViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation DiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 45.f;
    
}



#pragma mark - UITableViewDateSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataSource? self.dataSource.count : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource? [self.dataSource[section] count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"discoverCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    DiscoverModel *model = [self.dataSource objectAtIndex:indexPath.section][indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:[YDRankingViewController new] animated:YES];
            [self setHidesBottomBarWhenPushed:NO];
        }
            break;
        case 1:
            if (indexPath.row == 2) {
                [self.navigationController pushViewController:[DynamicTableViewController new] animated:YES];
            }
            break;
        case 2:
            
            break;
            
        default:
            break;
    }
}

#pragma mark - Getters
- (NSArray *)dataSource{
    if (!_dataSource) {
        DiscoverModel *model1 = [DiscoverModel modelWithImageName:@"" name:@"排行榜"];
        DiscoverModel *model2 = [DiscoverModel modelWithImageName:@"" name:@"哔哔"];
        DiscoverModel *model3 = [DiscoverModel modelWithImageName:@"" name:@"刷脸"];
        DiscoverModel *model4 = [DiscoverModel modelWithImageName:@"" name:@"逛一逛"];
        DiscoverModel *model5 = [DiscoverModel modelWithImageName:@"" name:@"测一测"];
        DiscoverModel *model6 = [DiscoverModel modelWithImageName:@"" name:@"驾驶成就"];
        DiscoverModel *model7 = [DiscoverModel modelWithImageName:@"" name:@"玩一把"];
        NSArray *section1 = @[model1];
        NSArray *section2 = @[model2,model3,model4];
        NSArray *section3 = @[model5,model6];
        NSArray *section4 = @[model7];
        _dataSource = @[section1,section2,section3,section4];
    }
    return _dataSource;
}


@end

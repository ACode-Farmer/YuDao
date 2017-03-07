//
//  YDCarSeriesController.m
//  YuDao
//
//  Created by 汪杰 on 16/11/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDCarSeriesController.h"
#import "YDSearchController.h"
#import "YDSearchResultsTableViewController.h"
#import "YDCarSeriesModel.h"
#import "YDCarModelController.h"

#define kCarSeriesURL @"http://www.ve-link.com/yulian/api/vseries"

@interface YDCarSeriesController ()<UISearchBarDelegate>

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) YDSearchController *searchController;
@property (nonatomic, strong) YDSearchResultsTableViewController *searchResultVC;

@end

@implementation YDCarSeriesController

- (id)init{
    if (self = [super init]) {
        self.carDic = [NSMutableDictionary new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"选择车系"];
    
    
    [self downCarSeriesData];
}

#pragma mark - Private Method
- (void)downCarSeriesData{
    UIView *containerView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, screen_width, 44)];
    containerView.backgroundColor = [UIColor whiteColor];
    self.searchController.searchBar.frame = CGRectMake(0, 0, screen_width, 44);
    [containerView addSubview:self.searchController.searchBar];
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.tableView setTableHeaderView:containerView];
    
    __weak YDCarSeriesController *weakSelf = self;
    [YDNetworking getUrl:kCarSeriesURL parameters:@{@"vaid":self.carBrandId} progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *originalDic = [responseObject mj_JSONObject];
        NSArray *dataArray = [originalDic objectForKey:@"data"];
        weakSelf.data = [YDCarSeriesModel mj_objectArrayWithKeyValuesArray:dataArray];
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data? self.data.count: 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *seriesCellID = @"seriesCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:seriesCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:seriesCellID];
    }
    YDCarSeriesModel *model = self.data[indexPath.row];
    cell.textLabel.text = model.vs_name;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YDCarSeriesModel *model = self.data[indexPath.row];
    YDCarModelController *carModelVC = [YDCarModelController new];
    carModelVC.carSeriesId = [NSString stringWithFormat:@"%@",model.vs_id];
    
    
    [carModelVC.carDic setObject:[self.carDic valueForKey:@"brand_name"] forKey:@"brand_name"];
    [carModelVC.carDic setObject:model.vs_name forKey:@"series_name"];
    
    [self.navigationController pushViewController:carModelVC animated:YES];
}

//MARK: -- Getter
- (YDSearchController *)searchController{
    if (!_searchController) {
        _searchController = [[YDSearchController alloc] initWithSearchResultsController:self.searchResultVC];
        _searchController.searchResultsUpdater = self.searchResultVC;
        _searchController.searchBar.delegate = self;
        _searchController.searchBar.placeholder = @"搜索";
    }
    return _searchController;
}

- (YDSearchResultsTableViewController *)searchResultVC{
    if (!_searchResultVC) {
        _searchResultVC = [YDSearchResultsTableViewController new];
    }
    return _searchResultVC;
}


@end

//
//  YDBrandController.m
//  YuDao
//
//  Created by 汪杰 on 16/11/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDBrandController.h"
#import "YDBrandModel.h"
#import "YDSearchController.h"
#import "YDSearchResultsTableViewController.h"

#import "YDCarSeriesController.h"

#define kBrandURL @"http://www.ve-link.com/yulian/api/vbrand"

@interface YDBrandController ()<UISearchBarDelegate>

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *indexArray;
@property (nonatomic, strong) YDSearchController *searchController;
@property (nonatomic, strong) YDSearchResultsTableViewController *searchResultVC;

@end

@implementation YDBrandController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"选择品牌"];
    
    [self downloadData];
}

#pragma mark - Private Methods
- (void)downloadData{
    UIView *containerView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, screen_width, 44)];
    containerView.backgroundColor = [UIColor whiteColor];
    self.searchController.searchBar.frame = CGRectMake(0, 0, screen_width, 44);
    [containerView addSubview:self.searchController.searchBar];
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.tableView setTableHeaderView:containerView];
    
    __weak YDBrandController *weakSelf = self;
    [YDNetworking getUrl:kBrandURL parameters:nil progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *originalDic = [responseObject mj_JSONObject];
        NSArray *dataArray = [originalDic objectForKey:@"data"];
        NSArray *brands = [YDBrandModel mj_objectArrayWithKeyValuesArray:dataArray];
        weakSelf.indexArray = [weakSelf getIndexArrayFromDataSource:brands];
        weakSelf.data = [weakSelf getDataArrayFromDataSource:brands];
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
//获取表格右侧索引数组
- (NSArray *)getIndexArrayFromDataSource:(NSArray *)dataSource{
    NSMutableArray *tempIndexArray = [NSMutableArray arrayWithCapacity:26];
    NSString *tempString;
    for (YDBrandModel *model in dataSource) {
        NSString *indexString = model.vb_firstletter;
        if (![tempString isEqualToString:indexString]) {
            [tempIndexArray addObject:indexString];
            tempString = indexString;
        }
    }
    return [tempIndexArray copy];
}
//获取排序后的素组
- (NSArray *)getDataArrayFromDataSource:(NSArray *)dataSource{
    NSMutableArray *tempDataArray = [NSMutableArray array];
    NSMutableArray *item = [NSMutableArray array];
    NSString *tempString;
    for (YDBrandModel *model in dataSource) {
        NSString *indexString = model.vb_firstletter;
        if (![tempString isEqualToString:indexString]) {//不同
            item = [NSMutableArray array];
            [item addObject:model];
            [tempDataArray addObject:item];
            //往下遍历
            tempString = indexString;
        }else{
            [item addObject:model];//相同
        }
    }
    return [tempDataArray copy];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data ? self.data.count: 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data ? [[self.data objectAtIndex:section] count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *brandCellID = @"brandCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:brandCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:brandCellID];
    }
    YDBrandModel *model = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = model.vb_name;
    return cell;
}

//组标题数据源
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}
//组眉
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.indexArray objectAtIndex:section];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YDBrandModel *model = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    
    YDCarSeriesController *carSerVC = [YDCarSeriesController new];
    carSerVC.carBrandId = [NSString stringWithFormat:@"%@",model.vb_id];
    [carSerVC.carDic setObject:model.vb_name forKey:@"brand_name"];
    [self.navigationController pushViewController:carSerVC animated:YES];
    
    
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

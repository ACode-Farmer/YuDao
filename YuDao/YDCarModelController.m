//
//  YDCarModelController.m
//  YuDao
//
//  Created by 汪杰 on 16/11/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDCarModelController.h"
#import "YDSearchController.h"
#import "YDSearchResultsTableViewController.h"
#import "YDCarMMoel.h"
//#import "YDChangeCarInfoController.h"

#import "YDAddCarViewController.h"

#define kCarModelURL @"http://www.ve-link.com/yulian/api/vmodel"

@interface YDCarModelController ()<UISearchBarDelegate>

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) YDSearchController *searchController;
@property (nonatomic, strong) YDSearchResultsTableViewController *searchResultVC;

@end

@implementation YDCarModelController

- (id)init{
    if (self = [super init]) {
        self.carDic = [NSMutableDictionary new];
    }
   return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"选择型号"];
    
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
    
    __weak YDCarModelController *weakSelf = self;
    [YDNetworking getUrl:kCarModelURL parameters:@{@"vsid":self.carSeriesId} progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *originalDic = [responseObject mj_JSONObject];
        NSLog(@"originalDic = %@",originalDic);
        NSArray *dataArray = [originalDic objectForKey:@"data"];
        weakSelf.data = [YDCarMMoel mj_objectArrayWithKeyValuesArray:dataArray];
        [weakSelf.tableView reloadData];
        if (weakSelf.data.count == 0) {
            [UIAlertView bk_showAlertViewWithTitle:@"暂无此车系数据" message:nil cancelButtonTitle:@"确认" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex == 0) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }];
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@",error);
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
    YDCarMMoel *model = self.data[indexPath.row];
    cell.textLabel.text = model.vm_name;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    YDCarMMoel *model = self.data[indexPath.row];
    YDAddCarViewController *addCarVC = [YDAddCarViewController new];
    YDCarDetailModel *carDetail = [YDCarDetailModel new];
    carDetail.vb_id = model.vb_id;
    carDetail.vs_id = model.vs_id;
    carDetail.vm_id = model.vm_id;
    carDetail.ug_brand_name = [self.carDic valueForKey:@"brand_name"];
    carDetail.ug_series_name = [self.carDic valueForKey:@"series_name"];
    carDetail.ug_model_name = model.vm_name;
    
    addCarVC.carDetail = carDetail;
    
    [self.navigationController pushViewController:addCarVC animated:YES];
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

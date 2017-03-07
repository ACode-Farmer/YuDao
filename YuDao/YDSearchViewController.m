//
//  YDSearchViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDSearchViewController.h"
#import "YDSearchController.h"


@interface YDSearchViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) YDSearchController *searchController;
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UILabel *label;


@end

@implementation YDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    self.definesPresentationContext = YES;
    NSArray *subViews = @[self.introduceLabel,self.label,self.searchController.searchBar
                          ];
    [self.view sd_addSubviews:subViews];
    
    
    [self y_layoutSubviews];
}

#pragma mark - Events

#pragma mark Private Methods
- (void)y_layoutSubviews{
    
    self.introduceLabel.sd_layout
    .topSpaceToView(self.view,64)
    .leftSpaceToView(self.view,14)
    .rightSpaceToView(self.view,10)
    .heightIs(21);
    
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    YDWeakSelf(self);
    [YDNetworking getUrl:kSearchUserURL parameters:@{@"nickname":searchBar.text} progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"response = %@",[responseObject mj_JSONObject]);
        NSArray *data = [[responseObject mj_JSONObject] objectForKey:@"data"];
        NSArray *tempArray = [YDSearchModel mj_objectArrayWithKeyValuesArray:data];
        [weakself.searchResultVC setData:tempArray];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark - Getters
- (UILabel *)introduceLabel{
    if (!_introduceLabel) {
        _introduceLabel = [YDUIKit labelWithTextColor:[UIColor colorWithString:@"#2B3552"] text:@"您可以搜索用户昵称" fontSize:kFontSize(14) textAlignment:0];
    }
    return _introduceLabel;
}

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

- (UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.font = [UIFont font_14];
        _label.text = @"他们都在搜:";
    }
    return _label;
}



@end

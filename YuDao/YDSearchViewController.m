//
//  YDSearchViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDSearchViewController.h"
#import "YDSearchController.h"
#import "InterestView.h"

@interface YDSearchViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) YDSearchController *searchController;
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) InterestView *inView;

@end

@implementation YDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    NSArray *subViews = @[self.introduceLabel,self.searchBar,self.label,self.inView,self.searchController.searchBar];
    [self.view sd_addSubviews:subViews];
    
    //searchController.searchBar的位置有问题，相当不好搞啊!
    //self.searchController.searchBar.frame = CGRectMake(0, 64, screen_width, height_navBar);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.view addGestureRecognizer:tap];
    
    [self y_layoutSubviews];
}

#pragma mark - Events
- (void)tapGestureAction:(id)tap{
    [self.searchBar resignFirstResponder];
}

#pragma mark Private Methods
- (void)y_layoutSubviews{
    UIView *view = self.view;
    self.introduceLabel.sd_layout
    .topSpaceToView(view,70)
    .leftSpaceToView(view,10)
    .heightIs(21);
    [self.introduceLabel setSingleLineAutoResizeWithMaxWidth:screen_width-10];
    
    self.searchBar.sd_layout
    .leftEqualToView(self.introduceLabel)
    .topSpaceToView(self.introduceLabel,10)
    .rightSpaceToView(view,10)
    .heightIs(40);
    
    self.label.sd_layout
    .topSpaceToView(self.searchBar,30)
    .leftEqualToView(self.introduceLabel)
    .widthIs(200)
    .heightIs(21);
    
    self.inView.sd_layout
    .topSpaceToView(self.label,10)
    .leftEqualToView(self.introduceLabel)
    .rightEqualToView(self.searchBar)
    .autoHeightRatio(0);
    
    [self.inView addSearchItems:@[@"车模",@"宝马5系",@"车友会",@"车展",@"概念车",@"同城出游"]];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"textDidChange");
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.tabBarController.tabBar setHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}
#pragma mark - Getters
- (UILabel *)introduceLabel{
    if (!_introduceLabel) {
        _introduceLabel = [UILabel new];
        _introduceLabel.font = [UIFont font_14];
        _introduceLabel.text = @"您可以搜索用户呢称或群组，也可以搜索活动";
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

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [UISearchBar new];
        _searchBar.placeholder = @"搜索";
        //_searchBar.delegate = self;
    
    }
    return _searchBar;
}

- (UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.font = [UIFont font_14];
        _label.text = @"他们都在搜:";
    }
    return _label;
}

- (InterestView *)inView{
    if (!_inView) {
        _inView = [InterestView new];
    }
    return _inView;
}

@end

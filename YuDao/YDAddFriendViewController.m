//
//  YDAddFriendViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/17.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDAddFriendViewController.h"
#import "YDSearchController.h"
#import "YDQRCodeController.h"
#import "YDPhoneContactsController.h"
#import "CaptureViewController.h"

@interface YDAddFriendViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) YDSearchController *searchController;

@property (nonatomic, strong) UIView           *tableHeaderView;

@end

@implementation YDAddFriendViewController
{
    NSArray *_images;
    NSArray *_titles;
    NSArray *_subTitles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加好友";
    
    _images = @[@"mine_contacts_scan",@"mine_contacts_iphone"];
    _titles = @[@"扫一扫",@"手机联系人"];
    _subTitles = @[@"扫描二维码名片",@"添加手机通讯录中的朋友"];
    
    self.definesPresentationContext = YES;
    
    [self.tableView setTableHeaderView:self.tableHeaderView];
    self.tableView.rowHeight = 53.f;
}

#pragma mark - Events
//点击我的二维码
- (void)tapMyCodeViewAction:(UITapGestureRecognizer *)tap{
    [self.navigationController pushViewController:[YDQRCodeController new] animated:YES];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _images.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *YDAddFCell = @"YDAddFCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YDAddFCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:YDAddFCell];
        cell.textLabel.textColor = [UIColor colorWithString:@"#2B3552"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        
        cell.detailTextLabel.textColor = [UIColor colorWithString:@"#999999"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.textLabel.text = _titles[indexPath.row];
    cell.detailTextLabel.text = _subTitles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:_images[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        CaptureViewController *capture = [CaptureViewController new];
        YDNavigationController *naviVC = [[YDNavigationController alloc] initWithRootViewController:capture];
        capture.CaptureSuccessBlock = ^(CaptureViewController *captureVC,NSString *s){
            NSLog(@"url = %@",s);
            [captureVC dismissViewControllerAnimated:YES completion:nil];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:s]];
        };
        capture.CaptureFailBlock = ^(CaptureViewController *captureVC){
            [captureVC dismissViewControllerAnimated:YES completion:nil];
        };
        capture.CaptureCancelBlock = ^(CaptureViewController *captureVC){
            [captureVC dismissViewControllerAnimated:YES completion:nil];
        };
        [self presentViewController:naviVC animated:YES completion:nil];

    }
    if (indexPath.row == 1) {
        [self.navigationController pushViewController:[YDPhoneContactsController new] animated:YES];
    }
    
}

#pragma mark - Events
- (YDSearchController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[YDSearchController alloc] initWithSearchResultsController:nil];
        [_searchController setSearchResultsUpdater:nil];
        [_searchController.searchBar setPlaceholder:@"搜索"];
        [_searchController.searchBar setDelegate:self];
    }
    return _searchController;
}

- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 133)];;
        [_tableHeaderView addSubview:self.searchController.searchBar];
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, screen_width, 89)];
        backgroundView.backgroundColor = [UIColor colorWithString:@"#EBEBEB"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMyCodeViewAction:)];
        [backgroundView addGestureRecognizer:tap];
        [_tableHeaderView addSubview:backgroundView];
        
        NSString *text = [NSString stringWithFormat:@"我的遇道ID: %@",[YDUserDefault defaultUser].user.ub_id];
        
        UILabel *label = [YDUIKit labelWithTextColor:[UIColor colorWithString:@"#2B3552"] text:text fontSize:14 textAlignment:NSTextAlignmentCenter];
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_contacts_code"]];
        [backgroundView sd_addSubviews:@[label,imageV]];
        
        label.sd_layout
        .topSpaceToView(backgroundView,10)
        .leftSpaceToView(backgroundView,150)
        .heightIs(21);
        [label setSingleLineAutoResizeWithMaxWidth:150];
        
        imageV.sd_layout
        .centerYEqualToView(label)
        .leftSpaceToView(label,10)
        .widthIs(17)
        .heightIs(17);
    }
    return _tableHeaderView;
}

@end

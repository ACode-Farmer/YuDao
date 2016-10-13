//
//  SetupTableViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/18.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "SetupTableViewController.h"
#import "UniversalViewController.h"
#import "AdviseController.h"
#import "AboutUsController.h"
#import "ProtocolViewController.h"

@interface SetupTableViewController ()

@property (nonatomic, strong) NSArray *dataSource;


@end

@implementation SetupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.tableFooterView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 60)];
        UIView *lineView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, screen_width, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:lineView];
        
        UIButton *btn = [UIButton new];
        [btn addTarget:self action:@selector(sinoutBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor colorWithString:@"#ff4646"];
        [btn setTitle:@"退出登录" forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        [view addSubview:btn];
        btn.sd_layout
        .centerXEqualToView(view)
        .centerYEqualToView(view)
        .widthRatioToView(view,0.8)
        .heightRatioToView(view,0.8);
        view;
    });
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


#pragma mark - Events
- (void)sinoutBtnAction:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认退出登录?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *changeUser = [UIAlertAction actionWithTitle:@"切换帐号" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sinOut = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:changeUser];
    [alert addAction:sinOut];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource? self.dataSource.count: 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"SetupCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *text = self.dataSource[indexPath.row];
    cell.textLabel.text = text;
    if ([text isEqualToString:@"版本更新"]) {
        cell.detailTextLabel.text = @"1.01";
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            UniversalViewController *vc = [[UniversalViewController alloc] initWithControllerType:indexPath.row title:self.dataSource[indexPath.row]];
            [self.navigationController pushViewController:vc animated:YES];
            break;}
        case 1:
        {
            UniversalViewController *vc = [[UniversalViewController alloc] initWithControllerType:indexPath.row title:self.dataSource[indexPath.row]];
            [self.navigationController pushViewController:vc animated:YES];
            break;}
        case 2:
        {
            UniversalViewController *vc = [[UniversalViewController alloc] initWithControllerType:indexPath.row title:self.dataSource[indexPath.row]];
            [self.navigationController pushViewController:vc animated:YES];
            break;}
        case 3:
        {
            [self.navigationController pushViewController:[AdviseController new] animated:YES];
            break;}
        case 4:
        {
            [self.navigationController pushViewController:[AboutUsController new] animated:YES];
            break;}
        case 5:
        {
            UIAlertController *alert = [UIAlertController  alertControllerWithTitle:@"遇道" message:@"发现新的版本1.11，是否立即更新？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancel];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            break;}
        case 6:
        {
            [self.navigationController pushViewController:[ProtocolViewController new] animated:YES];
            break;}
        default:
            break;
    }
}

#pragma mark - Getters
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[@"消息通知",@"隐私设置",@"功能设置",@"意见反馈",@"关于我们",@"版本更新",@"用户使用协议"];
    }
    return _dataSource;
}

@end

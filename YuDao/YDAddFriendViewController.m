//
//  YDAddFriendViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/17.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDAddFriendViewController.h"

@interface YDAddFriendViewController ()

@property (nonatomic, strong) UISearchBar *serachBar;

@end

@implementation YDAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.serachBar;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewHiddenKeyBoard:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - Events
- (void)tapViewHiddenKeyBoard:(UIGestureRecognizer *)tap{
    [self.serachBar resignFirstResponder];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *YDAddFCell = @"YDAddFCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YDAddFCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:YDAddFCell];
    }
    cell.textLabel.text = @"扫一扫";
    cell.detailTextLabel.text = @"扫描二维码也可以添加好友";
    cell.imageView.image = [UIImage imageNamed:@"二维码"];
    return cell;
}
#pragma mark - Events
- (UISearchBar *)serachBar{
    if (!_serachBar) {
        _serachBar = [UISearchBar new];
        _serachBar.frame = CGRectMake(0, 0, screen_width, 60);
        _serachBar.placeholder = @"请输入用户ID或手机号";
    }
    return _serachBar;
}

@end

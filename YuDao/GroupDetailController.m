//
//  GroupDetailController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "GroupDetailController.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>

@interface GroupDetailController ()

@property (nonatomic, strong) UIView *headerView;

@end

@implementation GroupDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群组详情";
    
    self.tableView.centerY -= 100;
    self.tableView.tableHeaderView = self.headerView;
    [self updateHeaderView:self.headerView];
    
}

#pragma mark - lazy load
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.frame = CGRectMake(0, 0, screen_width, 300);
        
        UIView *backView = [UIView new];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.4f;
        UIImageView *imageview = [UIImageView new];
        imageview.tag = 101;
        UILabel *label = [UILabel new];
        label.tag = 102;
        
        NSArray *views = @[backView,imageview,label];
        [_headerView sd_addSubviews:views];
        [self.view addSubview:_headerView];
        
        backView.sd_layout
        .leftSpaceToView(_headerView,0)
        .bottomSpaceToView(_headerView,0)
        .widthIs(screen_width)
        .heightIs(50);
        
        imageview.sd_layout
        .leftSpaceToView(_headerView,10)
        .bottomEqualToView(backView)
        .widthIs(80)
        .heightIs(80);
        imageview.sd_cornerRadius = @40;
        
        label.sd_layout
        .centerYEqualToView(backView)
        .leftSpaceToView(imageview,10)
        .rightEqualToView(backView)
        .heightIs(21);
        
    }
    return _headerView;
}

- (void)updateHeaderView:(UIView *)view{
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"test0.jpg"]];
    UIImageView *imageView = [view viewWithTag:101];
    UILabel *label = [view viewWithTag:102];
    
    imageView.image = [UIImage imageNamed:@"test8.jpg"];
    label.text = @"今晚猎个痛快";
    
}

#pragma tableview dataSource
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"GDCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = @"111";
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

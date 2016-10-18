//
//  LikedListController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/23.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "LikedListController.h"
#import "YDPersonalDataController.h"
#import "LIkedListCell.h"

NSString *const likedListCellID = @"LIkedListCell";

@interface LikedListController ()

@end

@implementation LikedListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 0.5)];
        view.backgroundColor = [UIColor lightGrayColor];
        view;
    });
    
    self.tableView.rowHeight = 78*widthHeight_ratio;
    [self.tableView registerClass:[LIkedListCell class] forCellReuseIdentifier:likedListCellID];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LIkedListCell *cell = [tableView dequeueReusableCellWithIdentifier:likedListCellID];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate) {
        [self.delegate likedListControllerPushTo:[YDPersonalDataController new]];
    }
}

@end

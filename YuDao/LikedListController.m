//
//  LikedListController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/23.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "LikedListController.h"
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
    
    self.tableView.rowHeight = 60.f;
    [self.tableView registerClass:[LIkedListCell class] forCellReuseIdentifier:likedListCellID];
    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LIkedListCell *cell = [tableView dequeueReusableCellWithIdentifier:likedListCellID];
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

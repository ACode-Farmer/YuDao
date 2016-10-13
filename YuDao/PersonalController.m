//
//  PersonalController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "PersonalController.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>

@interface PersonalController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableiview;

@end

@implementation PersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.alpha = 1.f;
    
    self.tableiview.tableHeaderView = ({
        UIView *view = [UIView new];
        UIImage *image = [UIImage imageNamed:@"head1.jpg"];
        view.backgroundColor = [UIColor colorWithPatternImage:image];
        view.frame = CGRectMake(0, 0, screen_width, 300);
        view;
    });
}

#pragma mark - UITableViewDataSource
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - Getters
- (UITableView *)tableiview{
    if (!_tableiview) {
        _tableiview = [UITableView new];
        _tableiview.dataSource = self;
        _tableiview.delegate = self;
        [self.view addSubview:_tableiview];
        _tableiview.sd_layout
        .topSpaceToView(self.view,-100)
        .leftSpaceToView(self.view,0)
        .bottomSpaceToView(self.view,0)
        .widthIs(screen_width);
    }
    return _tableiview;
}

@end

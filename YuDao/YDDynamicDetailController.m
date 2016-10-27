//
//  YDDynamicDetailController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDynamicDetailController.h"
#import "YDDynamicDetailController+Delegate.h"
#import "YDDDBottomView.h"

@interface YDDynamicDetailController ()

@property (nonatomic, strong) YDDDHeaderView *headerView;
@property (nonatomic, strong) YDDDBottomView *bottomView;

@end

@implementation YDDynamicDetailController
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.bottomView;
    
    [self.tableView registerClass:[YDDDContentCell class] forCellReuseIdentifier:YDDDContentCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:YDDNormalCellID];
}

#pragma mark Private Methods



#pragma mark - Getter
- (NSArray *)dataArray{
    if (_dataArray == nil) {

        YDDDContentModel *model = [YDDDContentModel new];
        model.imageArray = @[@"head0.jpg",@"head1.jpg"];
        model.location = @"不知道在哪里!";
        model.title = @"就是突然想发个动态!";
        model.content = @"就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!";
        
        YDDDNormalModel *model1 = [YDDDNormalModel new];
        model1.imageName = @"head1.jpg";
        model1.title = @"Simon";
        model1.subTitle = @"今天天气阔以哦!";
        
        _dataArray = [NSMutableArray arrayWithObjects:model,model1,model1,model1, nil];
    }
    return _dataArray;
}

- (YDDDHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [[YDDDHeaderView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 80)];
        [_headerView updateHeaderView:@"head0.jpg" userName:@"来啊来啊!" genderImage:@"head1.jpg" level:@"V5" time:@"一小时前"];
    }
    return _headerView;
}

- (YDDDBottomView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[YDDDBottomView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 60)];
    }
    return _bottomView;
}


@end

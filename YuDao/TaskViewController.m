//
//  TaskViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "TaskViewController.h"
#import "TaskContentView.h"
#import "YDMainTitleView.h"
#import "TaskModel.h"

@interface TaskViewController ()

@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, strong) TaskContentView *contentView;
@property (nonatomic, strong) YDMainTitleView *titleView;

@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleView];
    
    //头视图标题
    UILabel *headerLabel = [self.headerView viewWithTag:1001];
    headerLabel.text = @"快速注册，加入遇道之旅";
    
    TaskModel *textModel = [TaskModel modelWithTime:@"1天内" reward:@"1000积分" target:@"注册成为“遇道”用户，可使用遇道的社交功能，与其它遇道用户聊天交流，与其它遇道用户聊天交流，与其它遇道用户聊天交流，与其它遇道用户聊天交流，与其它遇道用户聊天交流" isComplete:YES];
    self.contentView.model = textModel;
    
}

#pragma mark lazy load -
- (UIImageView *)headerView{
    if (!_headerView) {
        _headerView = [UIImageView new];
        _headerView.image = [UIImage imageNamed:@"test0.jpg"];
        [self.view addSubview:_headerView];
        
        _headerView.sd_layout
        .topSpaceToView(self.titleView,0)
        .leftEqualToView(self.titleView)
        .rightEqualToView(self.titleView)
        .heightIs(0.18*(screen_height-64-48));
        
        UILabel *headerLabel = [UILabel new];
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.textColor = [UIColor blackColor];
        headerLabel.tag = 1001;
        
        UIView *backView = [UIView new];
        backView.backgroundColor = [UIColor whiteColor];
        backView.alpha = 0.5;
        [_headerView sd_addSubviews:@[backView,headerLabel]];
        
        backView.sd_layout
        .centerYEqualToView(_headerView)
        .leftEqualToView(_headerView)
        .rightEqualToView(_headerView)
        .heightRatioToView(_headerView,0.3);
        
        headerLabel.sd_layout
        .topEqualToView(backView)
        .leftEqualToView(backView)
        .rightEqualToView(backView)
        .heightRatioToView(_headerView,0.3);
    }
    return _headerView;
}

- (TaskContentView *)contentView{
    if (!_contentView) {
        _contentView = [TaskContentView new];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_contentView];
        _contentView.sd_layout
        .topSpaceToView(self.headerView,0)
        .leftEqualToView(self.headerView)
        .rightEqualToView(self.headerView)
        .heightIs(0.6*screen_height);
    }
    return _contentView;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (YDMainTitleView *)titleView{
    if (!_titleView) {
        _titleView = [YDMainTitleView new];
        [_titleView setTitle:@"任务" leftBtnImage:@"AppIcon" rightBtnImage:@"AppIcon"];
    }
    return _titleView;
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

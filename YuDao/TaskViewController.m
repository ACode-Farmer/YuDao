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
#import "YDMainViewConfigure.h"

#define kTaskHeaderImageViewHeight 112 * widthHeight_ratio

@interface TaskViewController ()<TaskContentViewDelegate>

@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, strong) TaskContentView *contentView;
@property (nonatomic, strong) YDMainTitleView *titleView;

@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleView];
    
    TaskModel *textModel = [TaskModel modelWithTime:@"1天内" reward:@"1000积分" target:@"注册成为“遇道”用户，可使用遇道的社交功能，与其它遇道用户聊天交流，与其它遇道用户聊天交流，与其它遇道用户聊天交流，与其它遇道用户聊天交流，与其它遇道用户聊天交流" isComplete:YES];
    self.contentView.model = textModel;
    
    [self.view setupAutoHeightWithBottomView:self.contentView bottomMargin:0];
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark lazy load -
- (UIImageView *)headerView{
    if (!_headerView) {
        _headerView = [UIImageView new];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.image = [UIImage imageNamed:@"task_header_speed"];
        [self.view addSubview:_headerView];
        
        _headerView.sd_layout
        .topSpaceToView(self.titleView,0)
        .leftEqualToView(self.titleView)
        .rightEqualToView(self.titleView)
        .heightIs(kTaskHeaderImageViewHeight);
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
        .rightEqualToView(self.headerView);
    }
    return _contentView;
}


- (YDMainTitleView *)titleView{
    if (!_titleView) {
        _titleView = [YDMainTitleView new];
        _titleView.frame = CGRectMake(0, 0, screen_width, kTitleViewHeight);
        [_titleView setTitle:@"任务" leftBtnImage:@"target_pen" rightBtnImage:@"more"];
    }
    return _titleView;
}

#pragma - mark TaskContentViewDelegate
- (void)taskContentViewGoCompliteTask:(NSString *)taskName{
    NSLog(@"taskName = %@",taskName);
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

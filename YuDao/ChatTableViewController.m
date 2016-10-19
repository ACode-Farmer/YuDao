//
//  ChatTableViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/11.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "ChatTableViewController.h"
#import "ChatCell.h"
#import "ChatModel.h"
#import "YDChatBar.h"

@interface ChatTableViewController ()<UITableViewDelegate,UITableViewDataSource,YDChatBarDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YDChatBar *chatbar;

@end

@implementation ChatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.variableTitle) {
        self.title = self.variableTitle;
    }else{
        self.title = @"聊天";
    }
    [self.tableView registerClass:[ChatCell class] forCellReuseIdentifier:@"ChatCell"];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.chatbar];
    [self y_layoutSubviews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    
}

- (void)y_layoutSubviews{
    self.chatbar.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .heightIs(49);
}

#pragma mark - YDChatBarDelegate
/**
 *  chatBar状态改变
 */
- (void)chatBar:(YDChatBar *)chatBar changeStatusFrom:(YDChatBarStatus)fromStatus to:(YDChatBarStatus)toStatus{}

/**
 *  输入框高度改变
 */
- (void)chatBar:(YDChatBar *)chatBar didChangeTextViewHeight:(CGFloat)height{}

/**
 *  发送文字
 */
- (void)chatBar:(YDChatBar *)chatBar sendText:(NSString *)text{}


// 录音控制
- (void)chatBarStartRecording:(YDChatBar *)chatBar{}

- (void)chatBarWillCancelRecording:(YDChatBar *)chatBar cancel:(BOOL)cancel{}

- (void)chatBarDidCancelRecording:(YDChatBar *)chatBar{}

- (void)chatBarFinishedRecoding:(YDChatBar *)chatBar{}

#pragma mark - TableViewDatasource
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatModel *model = self.dataSource[indexPath.row];
    return model.rowHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource? self.dataSource.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
    
    ChatModel *model = self.dataSource[indexPath.row];
    [cell updateCellWithModel:model];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - Getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = CGRectMake(0, 0, screen_width, screen_height);
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (YDChatBar *)chatbar{
    if (!_chatbar) {
        _chatbar = [YDChatBar new];
        _chatbar.delegate = self;
    }
    return _chatbar;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            ChatModel *model = [ChatModel modelWithImage:@"icon1.jpg" content:@"默默默默默默默默默默默默默默默默默默默" time:@"7:01" type:0];
            [_dataSource addObject:model];
        }
        for (int i = 0; i < 3; i++) {
            ChatModel *model = [ChatModel modelWithImage:@"icon2.jpg" content:@"我默默默默默默默默默默默默默默默默默默默默默默默默默默默默默" time:@"8:01" type:1];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

@end

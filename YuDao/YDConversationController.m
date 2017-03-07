//
//  YDConversationController.m
//  YuDao
//
//  Created by 汪杰 on 17/2/13.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import "YDConversationController.h"
#import "YDConversationController+Delegate.h"

@interface YDConversationController ()

@end

@implementation YDConversationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的消息";
    
    [self registerConversationCell];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self updateConversationData];
}

#pragma mark 刷新消息列表
- (void)updateConversationData{
    //刷新系统消息未读数量
    YDConversation *model = self.data.firstObject;
    model.unreadCount = [[YDSystemMessageHelper sharedSystemMessageHelper] unreadSystemMessageCount];
    //刷新聊天列表
    YDWeakSelf(self);
    [[YDConversationHelper shareInstance] getAllConversaionRecord:^(NSArray<YDConversation *> *data) {
        if (weakself.data.count > 1) {
            [weakself.data removeObjectsInRange:NSMakeRange(1, self.data.count-1)];
        }
        
        [weakself.data addObjectsFromArray:data];
        [weakself.tableView reloadData];
    }];
}

- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
        YDSystemMessage *sysMessage = [YDSystemMessageHelper sharedSystemMessageHelper].lastSysMessage;
        YDConversation *model = [[YDConversation alloc] init];
        model.fname = @"系统通知";
        model.fimageUrl = @"mine_systemMessage_image";
        model.content = sysMessage.content;
        if (!sysMessage || sysMessage.content.length == 0) {
            model.content = @"暂无系统消息";
        }
        model.unreadCount = [[YDSystemMessageHelper sharedSystemMessageHelper] unreadSystemMessageCount];
        model.date = sysMessage.date;
        [_data addObject:model];
    }
    return _data;
}

@end

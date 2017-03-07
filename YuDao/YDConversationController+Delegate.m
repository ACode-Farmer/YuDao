//
//  YDConversationController+Delegate.m
//  YuDao
//
//  Created by 汪杰 on 17/2/13.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import "YDConversationController+Delegate.h"
#import "YDConversationCell.h"
#import "YDSystemMessageController.h"

@implementation YDConversationController (Delegate)

- (void)registerConversationCell{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 67.f;
    [self.tableView registerClass:[YDConversationCell class] forCellReuseIdentifier:@"YDConversationCell"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data? self.data.count : 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDConversationCell"];
    cell.model = [self.data objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YDConversation *model = [self.data objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        if ([model.content isEqualToString:@"暂无系统消息"]) {
            [YDMBPTool showBriefAlert:@"暂无系统消息" time:1.f];
            return;
        }
        [self.navigationController pushViewController:[YDSystemMessageController new] animated:YES];
        [[YDSystemMessageHelper sharedSystemMessageHelper] updateReadSystemMessageByUserId:[YDUserDefault defaultUser].user.ub_id];
    }
    if (indexPath.row > 0) {
        YDChatViewController *chatVC = [YDChatViewController new];
        chatVC.name = model.fname;
        chatVC.headerUrl = model.fimageUrl;
        chatVC.chatToUserId = model.fid;
        chatVC.title = model.fname;
        
        [self.navigationController pushViewController:chatVC animated:YES];
        
        //更新数据库
        [[YDConversationHelper shareInstance] updateConversationByUid:[YDUserDefault defaultUser].user.ub_id fid:model.fid];
        //去掉红点
        [(YDConversationCell *)[tableView cellForRowAtIndexPath:indexPath] markAsRead];
    }
    
}

//左滑删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        YDConversation *conv = [self.data objectAtIndex:indexPath.row];
        //1.删除消息列表库对应的一条消息
        if ([[YDConversationHelper shareInstance] deleteConversationByUid:[YDUserDefault defaultUser].user.ub_id fid:conv.fid]) {
            //2.删除对应的聊天记录
            
            //3.删除当前数据源
            [self.data removeObjectAtIndex:indexPath.row];
            //4.删除单元格
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
    }
}

//修改删除按钮为中文
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
//是否运行编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return NO;
    }
    return YES;
}

@end

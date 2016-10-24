//
//  YDChatMessageDisplayView+Delegate.m
//  YuDao
//
//  Created by 汪杰 on 16/10/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDChatMessageDisplayView+Delegate.h"

@implementation YDChatMessageDisplayView (Delegate)

- (void)registerCellClassForTableView:(UITableView *)tableView
{
    [tableView registerClass:[YDTextMessageCell class] forCellReuseIdentifier:@"YDTextMessageCell"];
    [tableView registerClass:[YDImageMessageCell class] forCellReuseIdentifier:@"YDImageMessageCell"];
    [tableView registerClass:[YDExpressionMessageCell class] forCellReuseIdentifier:@"YDExpressionMessageCell"];
    //[tableView registerClass:[TLVoiceMessageCell class] forCellReuseIdentifier:@"TLVoiceMessageCell"];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"EmptyCell"];
}

#pragma mark - # Delegate
//MARK: UITableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YDMessage * message = self.data[indexPath.row];
    
    if (message.messageType == YDMessageTypeText) {
        YDTextMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDTextMessageCell"];
        
        [cell setMessage:message];
        
        [cell setDelegate:self];
        
        return cell;
    }
    
    else if (message.messageType == YDMessageTypeImage) {
        YDImageMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDImageMessageCell"];
        [cell setMessage:message];
        [cell setDelegate:self];
        return cell;
    }
    
    else if (message.messageType == YDMessageTypeExpression) {
        YDExpressionMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDExpressionMessageCell"];
        [cell setMessage:message];
        [cell setDelegate:self];
        return cell;
    }
    
    else if (message.messageType == YDMessageTypeVoice) {
//        TLVoiceMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLVoiceMessageCell"];
//        [cell setMessage:message];
//        [cell setDelegate:self];
//        return cell;
    }
    
    return [tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];
}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row >= self.data.count) {
        return 0.0f;
    }
    
    YDMessage * message = self.data[indexPath.row];
    return message.messageFrame.height;
    
}

//MARK: YDMessageCellDelegate
- (void)messageCellDidClickAvatarForUser:(YDUser *)user
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayView:didClickUserAvatar:)]) {
        [self.delegate chatMessageDisplayView:self didClickUserAvatar:user];
    }
}

- (void)messageCellTap:(YDMessage *)message
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayView:didClickMessage:)]) {
        [self.delegate chatMessageDisplayView:self didClickMessage:message];
    }
}

/**
 *  双击Message Cell
 */
- (void)messageCellDoubleClick:(YDMessage *)message
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayView:didDoubleClickMessage:)]) {
        [self.delegate chatMessageDisplayView:self didDoubleClickMessage:message];
    }
}

/**
 *  长按Message Cell
 */
- (void)messageCellLongPress:(YDMessage *)message rect:(CGRect)rect
{
//    NSInteger row = [self.data indexOfObject:message];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
//    if (self.disableLongPressMenu) {
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        return;
//    }
//    if ([[TLChatCellMenuView sharedMenuView] isShow]) {
//        return;
//    }
//    
//    CGRect cellRect = [self.tableView rectForRowAtIndexPath:indexPath];
//    rect.origin.y += cellRect.origin.y - self.tableView.contentOffset.y;
//    __weak typeof(self)weakSelf = self;
//    [[YDChatCellMenuView sharedMenuView] showInView:self withMessageType:message.messageType rect:rect actionBlock:^(TLChatMenuItemType type) {
//        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        if (type == TLChatMenuItemTypeCopy) {
//            NSString *str = [message messageCopy];
//            [[UIPasteboard generalPasteboard] setString:str];
//        }
//        else if (type == TLChatMenuItemTypeDelete) {
//            TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:@"是否删除该条消息" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles: nil];
//            actionSheet.tag = [self.data indexOfObject:message];
//            [actionSheet show];
//        }
//    }];
}

//MARK: UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayViewDidTouched:)]) {
        [self.delegate chatMessageDisplayViewDidTouched:self];
    }
}

//MARK: YDActionSheetDelegate


#pragma mark - # Private Methods
- (void)y_deleteMessage:(YDMessage *)message
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayView:deleteMessage:)]) {
        BOOL ok = [self.delegate chatMessageDisplayView:self deleteMessage:message];
        if (ok) {
            [self deleteMessage:message withAnimation:YES];
            //[MobClick event:EVENT_DELETE_MESSAGE];
        }
        else {
            //[UIAlertView bk_alertViewWithTitle:@"错误" message:@"从数据库中删除消息失败。"];
        }
    }
}

@end

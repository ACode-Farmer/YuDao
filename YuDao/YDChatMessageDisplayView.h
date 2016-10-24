//
//  YDChatMessageDisplayView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDChatMessageViewDelegate.h"

#import "YDMessage.h"
#import "YDTextMessage.h"
#import "YDExpressionMessage.h"

@interface YDChatMessageDisplayView : UIView

@property (nonatomic, assign) id<YDChatMessageViewDelegate>delegate;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong, readonly) UITableView *tableView;

/// 禁用下拉刷新
@property (nonatomic, assign) BOOL disablePullToRefresh;

/// 禁用长按菜单
@property (nonatomic, assign) BOOL disableLongPressMenu;


/**
 *  发送消息（在列表展示）
 */
- (void)addMessage:(YDMessage *)message;

/**
 *  删除消息
 */
- (void)deleteMessage:(YDMessage *)message;
- (void)deleteMessage:(YDMessage *)message withAnimation:(BOOL)animation;

/**
 *  更新消息状态
 */
- (void)updateMessage:(YDMessage *)message;
- (void)reloadData;

/**
 *  滚动到底部
 *
 *  @param animation 是否执行动画
 */
- (void)scrollToBottomWithAnimation:(BOOL)animation;

/**
 *  重新加载聊天信息
 */
- (void)resetMessageView;

@end

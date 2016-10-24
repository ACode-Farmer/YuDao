//
//  YDChatBaseViewController.h
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDChatBar.h"
#import "YDChatUserProtocol.h"
#import "YDTextMessage.h"
#import "YDImageMessage.h"
#import "YDUserHelper.h"
#import "YDChatMessageViewDelegate.h"
#import "YDChatMessageDisplayView.h"

@interface YDChatBaseViewController : UIViewController
{
    YDChatBarStatus lastStatus;
    YDChatBarStatus curStatus;
}

/// 用户信息
@property (nonatomic, strong) id<YDChatUserProtocol> user;

/// 聊天对象
@property (nonatomic, strong) id<YDChatUserProtocol> partner;

/// 消息展示页面
@property (nonatomic, strong) YDChatMessageDisplayView *messageDisplayView;

/// 聊天输入栏
@property (nonatomic, strong) YDChatBar *chatBar;

/// emoji展示view
//@property (nonatomic, strong) YDEmojiDisplayView *emojiDisplayView;

/// 图片表情展示view
//@property (nonatomic, strong) YDImageExpressionDisplayView *imageExpressionDisplayView;

/// 录音展示view
//@property (nonatomic, strong) YDRecorderIndicatorView *recorderIndicatorView;;

/**
 *  设置“更多”键盘元素
 */
- (void)setChatMoreKeyboardData:(NSMutableArray *)moreKeyboardData;

/**
 *  设置“表情”键盘元素
 */
- (void)setChatEmojiKeyboardData:(NSMutableArray *)emojiKeyboardData;

/**
 *  重置chatVC
 */
- (void)resetChatVC;

/**
 *  发送图片信息
 */
- (void)sendImageMessage:(UIImage *)image;

@end

//
//  YDChatBaseViewController+MessageDisplayView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDChatBaseViewController.h"
#import "YDChatMessageViewDelegate.h"
#define     MAX_SHOWTIME_MSG_COUNT      10
#define     MAX_SHOWTIME_MSG_SECOND     30

@interface YDChatBaseViewController (MessageDisplayView)<YDChatMessageViewDelegate>

/**
 *  添加展示消息（添加到chatVC）
 */
- (void)addToShowMessage:(YDMessage *)message;

/**
 *  重置chatVC
 */
- (void)resetChatTVC;

@end

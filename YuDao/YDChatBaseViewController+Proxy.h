//
//  YDChatBaseViewController+Proxy.h
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDChatBaseViewController.h"

@interface YDChatBaseViewController (Proxy)

/**
 *  发送消息
 */
- (void)sendMessage:(YDMessage *)message;


/**
 *  接收到消息
 *
 *  临时写法
 */
- (void)receivedMessage:(YDMessage *)message;

@end

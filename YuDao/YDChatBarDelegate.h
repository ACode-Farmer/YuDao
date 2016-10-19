//
//  YDChatBarDelegate.h
//  YuDao
//
//  Created by 汪杰 on 16/10/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDChatMacros.h"

@class YDChatBar;
@protocol YDChatBarDelegate <NSObject>


/**
 *  chatBar状态改变
 */
- (void)chatBar:(YDChatBar *)chatBar changeStatusFrom:(YDChatBarStatus)fromStatus to:(YDChatBarStatus)toStatus;

/**
 *  输入框高度改变
 */
- (void)chatBar:(YDChatBar *)chatBar didChangeTextViewHeight:(CGFloat)height;

/**
 *  发送文字
 */
- (void)chatBar:(YDChatBar *)chatBar sendText:(NSString *)text;


// 录音控制
- (void)chatBarStartRecording:(YDChatBar *)chatBar;

- (void)chatBarWillCancelRecording:(YDChatBar *)chatBar cancel:(BOOL)cancel;

- (void)chatBarDidCancelRecording:(YDChatBar *)chatBar;

- (void)chatBarFinishedRecoding:(YDChatBar *)chatBar;

@end

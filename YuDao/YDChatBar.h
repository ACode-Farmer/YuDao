//
//  YDChatBar.h
//  YuDao
//
//  Created by 汪杰 on 16/10/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDChatBarDelegate.h"

@interface YDChatBar : UIView

@property (nonatomic, weak) id<YDChatBarDelegate> delegate;

@property (nonatomic, assign) YDChatBarStatus status;

@property (nonatomic, strong, readonly) NSString *curText;

/// 是否激活状态（浏览个性表情时应该设置为NO）
@property (nonatomic, assign) BOOL activity;

/**
 *  添加Emoji表情String
 */
- (void)addEmojiString:(NSString *)emojiString;

/**
 *  发送文字消息
 */
- (void)sendCurrentText;

/**
 *  删除最后一个字符
 */
- (void)deleteLastCharacter;

@end

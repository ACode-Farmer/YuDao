//
//  YDChatMessageViewDelegate.h
//  YuDao
//
//  Created by 汪杰 on 16/10/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YDUser;
@class YDMessage;
@class YDChatMessageDisplayView;
@protocol YDChatMessageViewDelegate <NSObject>
/**
 *  聊天界面点击事件，用于收键盘
 */
- (void)chatMessageDisplayViewDidTouched:(YDChatMessageDisplayView *)chatTVC;

/**
 *  下拉刷新，获取某个时间段的聊天记录（异步）
 *
 *  @param chatTVC   chatTVC
 *  @param date      开始时间
 *  @param count     条数
 *  @param completed 结果Blcok
 */
- (void)chatMessageDisplayView:(YDChatMessageDisplayView *)chatTVC
            getRecordsFromDate:(NSDate *)date
                         count:(NSUInteger)count
                     completed:(void (^)(NSDate *, NSArray *, BOOL))completed;

@optional
/**
 *  消息长按删除
 *
 *  @return 删除是否成功
 */
- (BOOL)chatMessageDisplayView:(YDChatMessageDisplayView *)chatTVC
                 deleteMessage:(YDMessage *)message;

/**
 *  用户头像点击事件
 */
- (void)chatMessageDisplayView:(YDChatMessageDisplayView *)chatTVC
            didClickUserAvatar:(YDUser *)user;

/**
 *  Message点击事件
 */
- (void)chatMessageDisplayView:(YDChatMessageDisplayView *)chatTVC
               didClickMessage:(YDMessage *)message;

/**
 *  Message双击事件
 */
- (void)chatMessageDisplayView:(YDChatMessageDisplayView *)chatTVC
         didDoubleClickMessage:(YDMessage *)message;
@end

//
//  YDChatMacros.h
//  YuDao
//
//  Created by 汪杰 on 16/10/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#ifndef YDChatMacros_h
#define YDChatMacros_h

#import <UIKit/UIKit.h>

#define     HEIGHT_CHATBAR_TEXTVIEW         36.0f
#define     HEIGHT_MAX_CHATBAR_TEXTVIEW     111.5f
#define     HEIGHT_CHAT_KEYBOARD            215.0f

#define     MAX_MESSAGE_WIDTH               screen_width * 0.58
#define     MAX_MESSAGE_IMAGE_WIDTH         screen_width * 0.45
#define     MIN_MESSAGE_IMAGE_WIDTH         screen_width * 0.25
#define     MAX_MESSAGE_EXPRESSION_WIDTH    screen_width * 0.35
#define     MIN_MESSAGE_EXPRESSION_WIDTH    screen_width * 0.2

/**
 *  聊天表情
 */
typedef NS_ENUM(NSInteger, YDEmojiType) {

    YDEmojiTypeEmoji,

    YDEmojiTypeFavorite,

    YDEmojiTypeFace,
 
    YDEmojiTypeImage,

    YDEmojiTypeImageWithTitle,

    YDEmojiTypeOther,
};
/**
 *  聊天栏状态
 */
typedef NS_ENUM(NSInteger, YDChatBarStatus) {

    YDChatBarStatusInit,

    YDChatBarStatusVoice,

    YDChatBarStatusEmoji,

    YDChatBarStatusMore,

    YDChatBarStatusKeyboard,
};

#endif /* YDChatMacros_h */

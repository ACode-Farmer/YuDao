//
//  YDMacros.h
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#ifndef YDMacros_h
#define YDMacros_h

/********************  尺寸适配  ************************/
//屏幕宽
#define screen_width ([[UIScreen mainScreen] bounds].size.width)
//屏幕高
#define screen_height ([[UIScreen mainScreen] bounds].size.height)

#define kWidth(R)      (R)*(screen_width) /375.0f
#define kHeight(R)     (R)*(screen_height)/667.0f
#define kFontSize(R)   (R)*(screen_width) /375.0f
#define kFont(R)       [UIFont systemFontOfSize:kFontSize(R)]

//手机型号的宽高比
#define widthHeight_ratio screen_width/414

//判断设备类型
#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)



#define     BORDER_WIDTH_1PX            ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)

#define     height_statusBar            20.0f
#define     height_tabBar               49.0f
#define     height_navBar               44.0f

/********************  消息通知KEY  ************************/
#define kChangeMyselfBadgeNotification @"kChangeMyselfBadgeNotification"
#define kSystemMessageNotification     @"kSystemMessageNotification"
#define kFriendRequestNotification     @"kFriendRequestNotification"
#define kChatMessageNotification       @"kChatMessageNotification"

/********************  Methods  ************************/
#define     YDURL(urlString)        [NSURL URLWithString:urlString]
#define     YDNumberToString(string) [NSString stringWithFormat:@"%@",string]

#define     YDNoNilNumber(num)      (num ? num : @0)
#define     YDNoNilString(str)      (str ? str : @"")

#define     YDWeakSelf(type)    __weak typeof(type) weak##type = type;
#define     YDStrongSelf(type)  __strong typeof(type) strong##type = type;
#define     YDTimeStamp(date)   ([NSString stringWithFormat:@"%lf", [date timeIntervalSince1970]]) //时间转成时间戳

#define     YDColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define     YDNaviColor xx
#define     YDSeperatorColor [UIColor colorWithString:@"#C7C7CC"];

#define     YDGlobal_queue  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define     YDMain_queue dispatch_get_main_queue()

#define     kXMPP_MESSAGE_CHANGE  @"kXMPP_MESSAGE_CHANGE"

#define     kXMPP_INPUTING_MESSAGE      @"kXMPP_INPUTING_MESSAGE"     //对方正在输入
#define     kXMPP_RECEIVE_MESSAGE      @"kXMPP_RECEIVE_MESSAGE"      //收到消息
#define     kXMPP_SEND_MESSAGE_SUCCESS @"kXMPP_SEND_MESSAGE_SUCCESS"//发送消息成功
#define     kXMPP_SEND_MESSAGE_FAIL    @"kXMPP_SEND_MESSAGE_FAIL"   //发送消息失败

#define     HEIGHT_CHATBAR_TEXTVIEW         36.0f
#define     HEIGHT_MAX_CHATBAR_TEXTVIEW     111.5f
#define     HEIGHT_CHAT_KEYBOARD            215.0f
#define     HEIGHT_TABBAR                   49.0f

#endif /* YDMacros_h */

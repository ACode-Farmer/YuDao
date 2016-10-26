//
//  YDEnumerate.h
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#ifndef YDEnumerate_h
#define YDEnumerate_h

/**
 *  网络状态
 */
typedef NS_ENUM(NSInteger, YDReachabilityStatus) {
    /**
     *  未知网络状态
     */
    YDReachabilityStatusUnknown = 1,
    /**
     *  无网络
     */
    YDReachabilityStatusNotReachable,
    /**
     *  蜂窝数据网
     */
    YDReachabilityStatusWWAN,
    /**
     *  WiFi网络
     */
    YDReachabilityStatusWiFi,
};


/**
 *  群组详情类型
 */
typedef NS_ENUM(NSInteger, YDGroupDetailType) {
    YDGroupDetailTypeMine,          //我的群组
    YDGroupDetailTypeNew,           //新建的群(这里表示建群的最后一步)
    YDGroupDetailTypeJoined,        //已经加入的群组
    YDGroupDetailTypeNotJoin,       //未加入的群组(可能是搜索活着扫码得到的)
};

/**
 *  会话提示类型
 */
typedef NS_ENUM(NSInteger, YDClueType) {
    YDClueTypeNone,
    YDClueTypePoint,
    YDClueTypePointWithNumber,
};

/**
 *  会话类型
 */
typedef NS_ENUM(NSInteger, YDConversationType) {
    YDConversationTypePersonal,     // 个人
    YDConversationTypeGroup,        // 群聊
    YDConversationTypePublic,       // 公众号
    YDConversationTypeServerGroup,  // 服务组（订阅号、企业号）
};

typedef NS_ENUM(NSInteger, YDMessageRemindType) {
    YDMessageRemindTypeNormal,    // 正常接受
    YDMessageRemindTypeClosed,    // 不提示
    YDMessageRemindTypeNotLook,   // 不看
    YDMessageRemindTypeUnlike,    // 不喜欢
};

/**
 *  消息类型
 */
typedef NS_ENUM(NSInteger, YDMessageType) {
    YDMessageTypeUnknown,
    YDMessageTypeText,          // 文字
    YDMessageTypeImage,         // 图片
    YDMessageTypeExpression,    // 表情
    YDMessageTypeVoice,         // 语音
    YDMessageTypeVideo,         // 视频
    YDMessageTypeURL,           // 链接
    YDMessageTypePosition,      // 位置
    YDMessageTypeBusinessCard,  // 名片
    YDMessageTypeSystem,        // 系统
    YDMessageTypeOther,
};

typedef NS_ENUM(NSUInteger, YDMoreKeyboardItemType) {
    YDMoreKeyboardItemTypeImage,
    YDMoreKeyboardItemTypeCamera,
    YDMoreKeyboardItemTypeVideo,
    YDMoreKeyboardItemTypeVideoCall,
    YDMoreKeyboardItemTypeWallet,
    YDMoreKeyboardItemTypeTransfer,
    YDMoreKeyboardItemTypePosition,
    YDMoreKeyboardItemTypeFavorite,
    YDMoreKeyboardItemTypeBusinessCard,
    YDMoreKeyboardItemTypeVoice,
    YDMoreKeyboardItemTypeCards,
};

typedef NS_ENUM(NSUInteger, YDScannerType) {
    YDScannerTypeQR = 1,        // 扫一扫 - 二维码
    YDScannerTypeCover,         // 扫一扫 - 封面
    YDScannerTypeStreet,        // 扫一扫 - 街景
    YDScannerTypeTranslate,     // 扫一扫 - 翻译
};

typedef NS_ENUM(NSInteger, YDAddMneuType) {
    YDAddMneuTypeGroupChat = 0,
    YDAddMneuTypeAddFriend,
    YDAddMneuTypeScan,
    YDAddMneuTypeWallet,
};

#endif /* YDEnumerate_h */

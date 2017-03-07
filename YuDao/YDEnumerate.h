//
//  YDEnumerate.h
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#ifndef YDEnumerate_h
#define YDEnumerate_h

//认证状态
typedef NS_ENUM(NSInteger, YDAuthenticateStatus) {
    YDAuthenticateStatusNo = 0,    //未认证
    YDAuthenticateStatusSuccess,   //认证成功
    YDAuthenticateStatusAuthing,   //认证中
    YDAuthenticateStatusFail,      //认证失败
};

//选择地区类型
typedef NS_ENUM(NSInteger, YDPlaceType) {
    YDPlaceTypeUser = 0,    //用户常出没地
    YDPlaceTypeAddCar,      //添加车辆->违章地
    YDPlaceTypeChangeCar,   //修改车辆->违章地
};

//喜欢的人类型
typedef NS_ENUM(NSInteger, YDLikedPeopleType) {
    YDLikedPeopleTypeLikeMe = 1,    // 喜欢我的
    YDLikedPeopleTypeILike,    // 我喜欢的
    YDLikedPeopleTypeEachLike,   // 互相喜欢的
};

//当前排行榜数据类型
typedef NS_ENUM(NSInteger, YDRankingListDataType){
    YDRankingListDataTypeSpeed = 1,  //时速
    YDRankingListDataMileage,        //里程
    YDRankingListDataTypeOilwear,    //油耗
    YDRankingListDataTypeStop,       //滞留
    YDRankingListDataTypeScore,      //积分
    YDRankingListDataTypeLike,       //喜欢
};

/**
 *  动态类型
 */
typedef NS_ENUM(NSInteger, YDDynamicType) {
    /**
     *  图片
     */
    YDDynamicTypeImage = 1,
    /**
     *  纯文字
     */
    YDDynamicTypeText,
    /**
     *  链接
     */
    YDDynamicTypeLink,
    
};

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
 *  通知类型
 */
typedef NS_ENUM(NSInteger, YDNotificationType) {
    YDNotificationTypeSystem = 0,
    YDNotificationTypeMessage,
    YDNotificationTypeFriendRequest,
    
};

/**
 *  系统消息类型
 */
typedef NS_ENUM(NSInteger, YDSystemMessageType) {
    YDSystemMessageNotification = 0,
    YDSystemMessagePersonalMessage,
    YDSystemMessageGroupMessage,
    
};

/**
 *  消息读取状态
 */
typedef NS_ENUM(NSInteger, YDMessageReadState) {
    YDMessageUnRead = 0,        // 消息未读
    YDMessageReaded,            // 消息已读
};

/**
 *  消息类型
 */
typedef NS_ENUM(NSInteger, YDMessageType) {
    YDMessageTypeUnknown = 0,
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

typedef NS_ENUM(NSInteger, YDChatBarStatus) {
    YDChatBarStatusInit,
    YDChatBarStatusVoice,
    YDChatBarStatusEmoji,
    YDChatBarStatusKeyboard,
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

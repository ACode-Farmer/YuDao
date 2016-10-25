//
//  YDVoiceMessage.h
//  YuDao
//
//  Created by 汪杰 on 16/10/25.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMessage.h"

/**
 *  语音消息的状态
 */
typedef NS_ENUM(NSInteger, YDVoiceMessageStatus) {

    YDVoiceMessageStatusNormal,

    YDVoiceMessageStatusRecording,

    YDVoiceMessageStatusPlaying,
};

@interface YDVoiceMessage : YDMessage

@property (nonatomic, strong) NSString *recFileName;
@property (nonatomic, strong, readonly) NSString *path;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) CGFloat time;

@property (nonatomic, assign) YDVoiceMessageStatus msgStatus;

@end

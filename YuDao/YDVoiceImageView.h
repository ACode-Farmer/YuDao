//
//  YDVoiceImageView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/25.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDVoiceImageView : UIImageView

@property (nonatomic, assign) BOOL isFromMe;

/**
 *  开始播放语音消息动画
 */
- (void)startPlayingAnimation;

/**
 *  停止播放语音消息动画
 */
- (void)stopPlayingAnimation;

@end

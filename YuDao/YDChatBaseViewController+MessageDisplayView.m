//
//  YDChatBaseViewController+MessageDisplayView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDChatBaseViewController+MessageDisplayView.h"
#import "YDChatBaseViewController+ChatBar.h"
#import "YDTextDisplayView.h"
#import "YDChatMessageDisplayView.h"
#import "YDChatViewControllerProxy.h"

@implementation YDChatBaseViewController (MessageDisplayView)

#pragma mark - # Public Methods
- (void)addToShowMessage:(YDMessage *)message
{
    message.showTime = [self p_needShowTime:message.date];
    [self.messageDisplayView addMessage:message];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.messageDisplayView scrollToBottomWithAnimation:YES];
    });
}

- (void)addVoiceRecordingMessage:(YDMessage *)message
{
    message.date = [NSDate date];
}

- (void)resetChatTVC
{
    [self.messageDisplayView resetMessageView];
    lastDateInterval = 0;
    msgAccumulate = 0;
}

#pragma mark - # Delegate
//MARK: TLChatMessageDisplayViewDelegate
// chatView 点击事件
- (void)chatMessageDisplayViewDidTouched:(YDChatMessageDisplayView *)chatTVC
{
    [self dismissKeyboard];
}

// chatView 获取历史记录
- (void)chatMessageDisplayView:(YDChatMessageDisplayView *)chatTVC getRecordsFromDate:(NSDate *)date count:(NSUInteger)count completed:(void (^)(NSDate *, NSArray *, BOOL))completed
{
//    YDWeakSelf(self);
//    [[YDMessageManager sharedInstance] messageRecordForPartner:[self.partner chat_userID] fromDate:date count:count complete:^(NSArray *array, BOOL hasMore) {
//        if (array.count > 0) {
//            int count = 0;
//            NSTimeInterval tm = 0;
//            for (TLMessage *message in array) {
//                if (++count > MAX_SHOWTIME_MSG_COUNT || tm == 0 || message.date.timeIntervalSince1970 - tm > MAX_SHOWTIME_MSG_SECOND) {
//                    tm = message.date.timeIntervalSince1970;
//                    count = 0;
//                    message.showTime = YES;
//                }
//                if (message.ownerTyper == TLMessageOwnerTypeSelf) {
//                    message.fromUser = weakself.user;
//                }
//                else {
//                    if ([weakself.partner chat_userType] == TLChatUserTypeUser) {
//                        message.fromUser = weakself.partner;
//                    }
//                    else if ([weakself.partner chat_userType] == TLChatUserTypeGroup){
//                        if ([weakself.partner respondsToSelector:@selector(groupMemberByID:)]) {
//                            message.fromUser = [weakself.partner groupMemberByID:message.friendID];
//                        }
//                    }
//                }
//            }
//        }
//        completed(date, array, hasMore);
//    }];
}

- (BOOL)chatMessageDisplayView:(YDChatMessageDisplayView *)chatTVC deleteMessage:(YDMessage *)message
{
    //return [[YDMessageManager sharedInstance] deleteMessageByMsgID:message.messageID];
    return YES;
}

- (void)chatMessageDisplayView:(YDChatMessageDisplayView *)chatTVC didClickUserAvatar:(YDUser *)user
{
    if ([self respondsToSelector:@selector(didClickedUserAvatar:)]) {
        //[self didClickedUserAvatar:user];
    }
}

- (void)chatMessageDisplayView:(YDChatMessageDisplayView *)chatTVC didDoubleClickMessage:(YDMessage *)message
{
    NSLog(@"didDoubleClickMessage");
//    if (message.messageType == TLMessageTypeText) {
//        TLTextDisplayView *displayView = [[TLTextDisplayView alloc] init];
//        [displayView showInView:self.navigationController.view withAttrText:[(TLTextMessage *)message attrText] animation:YES];
//    }
}

- (void)chatMessageDisplayView:(YDChatMessageDisplayView *)chatTVC didClickMessage:(YDMessage *)message
{
    if (message.messageType == YDMessageTypeImage && [self respondsToSelector:@selector(didClickedImageMessages:atIndex:)]) {
        // 展示聊天图片
//        [[YDMessageManager sharedInstance] chatImagesAndVideosForPartnerID:[self.partner chat_userID] completed:^(NSArray *imagesData) {
//            NSInteger index = -1;
//            for (int i = 0; i < imagesData.count; i ++) {
//                if ([message.messageID isEqualToString:[imagesData[i] messageID]]) {
//                    index = i;
//                    break;
//                }
//            }
//            if (index >= 0) {
//                [self didClickedImageMessages:imagesData atIndex:index];
//            }
//        }];
    }
    else if (message.messageType == YDMessageTypeVoice) {
//        if ([(TLVoiceMessage *)message msgStatus] == TLVoiceMessageStatusNormal) {
//            // 播放语音消息
//            [(TLVoiceMessage *)message setMsgStatus:TLVoiceMessageStatusPlaying];
//            
//            [[TLAudioPlayer sharedAudioPlayer] playAudioAtPath:[(TLVoiceMessage *)message path] complete:^(BOOL finished) {
//                [(TLVoiceMessage *)message setMsgStatus:TLVoiceMessageStatusNormal];
//                [self.messageDisplayView updateMessage:message];
//            }];
//        }
//        else {
//            // 停止播放语音消息
//            [[TLAudioPlayer sharedAudioPlayer] stopPlayingAudio];
//        }
    }
}

#pragma mark - # Private Methods
static NSTimeInterval lastDateInterval = 0;
static NSInteger msgAccumulate = 0;
- (BOOL)p_needShowTime:(NSDate *)date
{
    if (++msgAccumulate > MAX_SHOWTIME_MSG_COUNT || lastDateInterval == 0 || date.timeIntervalSince1970 - lastDateInterval > MAX_SHOWTIME_MSG_SECOND) {
        lastDateInterval = date.timeIntervalSince1970;
        msgAccumulate = 0;
        return YES;
    }
    return NO;
}


@end
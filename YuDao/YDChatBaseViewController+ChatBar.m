//
//  YDChatBaseViewController+ChatBar.m
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDChatBaseViewController+ChatBar.h"
#import "YDMoreKeyboardItem.h"

@implementation YDChatBaseViewController (ChatBar)
#pragma mark - # Public Methods
- (void)loadKeyboard
{
    //[self.emojiKeyboard setKeyboardDelegate:self];
    //[self.emojiKeyboard setDelegate:self];
    [self.moreKeyboard setKeyboardDelegate:self];
    [self.moreKeyboard setDelegate:self];
    [self.moreKeyboard setChatMoreKeyboardData:[self p_initTestData]];
}
- (NSMutableArray *) p_initTestData
{
    NSMutableArray *moreKeyboardItems = [NSMutableArray arrayWithCapacity:20];
    YDMoreKeyboardItem *imageItem = [YDMoreKeyboardItem createByType:YDMoreKeyboardItemTypeImage
                                                               title:@"照片"
                                                           imagePath:@"moreKB_image"];
    YDMoreKeyboardItem *cameraItem = [YDMoreKeyboardItem createByType:YDMoreKeyboardItemTypeCamera
                                                                title:@"拍摄"
                                                            imagePath:@"moreKB_video"];
    YDMoreKeyboardItem *videoItem = [YDMoreKeyboardItem createByType:YDMoreKeyboardItemTypeVideo
                                                               title:@"小视频"
                                                           imagePath:@"moreKB_sight"];
    YDMoreKeyboardItem *videoCallItem = [YDMoreKeyboardItem createByType:YDMoreKeyboardItemTypeVideoCall
                                                                   title:@"视频聊天"
                                                               imagePath:@"moreKB_video_call"];
    YDMoreKeyboardItem *walletItem = [YDMoreKeyboardItem createByType:YDMoreKeyboardItemTypeWallet
                                                                title:@"红包"
                                                            imagePath:@"moreKB_wallet"];
    YDMoreKeyboardItem *transferItem = [YDMoreKeyboardItem createByType:YDMoreKeyboardItemTypeTransfer
                                                                  title:@"转账"
                                                              imagePath:@"moreKB_pay"];
    YDMoreKeyboardItem *positionItem = [YDMoreKeyboardItem createByType:YDMoreKeyboardItemTypePosition
                                                                  title:@"位置"
                                                              imagePath:@"moreKB_location"];
    YDMoreKeyboardItem *favoriteItem = [YDMoreKeyboardItem createByType:YDMoreKeyboardItemTypeFavorite
                                                                  title:@"收藏"
                                                              imagePath:@"moreKB_favorite"];
    YDMoreKeyboardItem *businessCardItem = [YDMoreKeyboardItem createByType:YDMoreKeyboardItemTypeBusinessCard
                                                                      title:@"个人名片"
                                                                  imagePath:@"moreKB_friendcard" ];
    YDMoreKeyboardItem *voiceItem = [YDMoreKeyboardItem createByType:YDMoreKeyboardItemTypeVoice
                                                               title:@"语音输入"
                                                           imagePath:@"moreKB_voice"];
    YDMoreKeyboardItem *cardsItem = [YDMoreKeyboardItem createByType:YDMoreKeyboardItemTypeCards
                                                               title:@"卡券"
                                                           imagePath:@"moreKB_wallet"];
    [moreKeyboardItems addObjectsFromArray:@[imageItem, cameraItem, videoItem, videoCallItem, walletItem, transferItem, positionItem, favoriteItem, businessCardItem, voiceItem, cardsItem]];
    return moreKeyboardItems;
}
- (void)dismissKeyboard
{
    if (curStatus == YDChatBarStatusMore) {
        [self.moreKeyboard dismissWithAnimation:YES];
        curStatus = YDChatBarStatusInit;
    }
    else if (curStatus == YDChatBarStatusEmoji) {
        //[self.emojiKeyboard dismissWithAnimation:YES];
        curStatus = YDChatBarStatusInit;
    }
    [self.chatBar resignFirstResponder];
}

//MARK: 系统键盘回调
- (void)keyboardWillShow:(NSNotification *)notification
{
    if (curStatus != YDChatBarStatusKeyboard) {
        return;
    }
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    if (curStatus != YDChatBarStatusKeyboard) {
        return;
    }
    if (lastStatus == YDChatBarStatusMore) {
        [self.moreKeyboard dismissWithAnimation:NO];
    }
    else if (lastStatus == YDChatBarStatusEmoji) {
        //[self.emojiKeyboard dismissWithAnimation:NO];
    }
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    if (curStatus != YDChatBarStatusKeyboard && lastStatus != YDChatBarStatusKeyboard) {
        return;
    }
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (lastStatus == YDChatBarStatusMore || lastStatus == YDChatBarStatusEmoji) {
        if (keyboardFrame.size.height <= HEIGHT_CHAT_KEYBOARD) {
            return;
        }
    }
    else if (curStatus == YDChatBarStatusEmoji || curStatus == YDChatBarStatusMore) {
        return;
    }
    self.chatBar.sd_layout.bottomSpaceToView(self.view,keyboardFrame.size.height);
//    [self.view setNeedsLayout];
//    [self.view layoutIfNeeded];
    [self.chatBar updateLayout];
    [self.messageDisplayView updateLayout];
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    
    if (curStatus != YDChatBarStatusKeyboard && lastStatus != YDChatBarStatusKeyboard) {
        return;
    }
    if (curStatus == YDChatBarStatusEmoji || curStatus == YDChatBarStatusMore) {
        return;
    }
    self.chatBar.sd_layout.bottomSpaceToView(self.view,0);
    [self.chatBar updateLayout];
    [self.messageDisplayView updateLayout];
}

#pragma mark - Delegate
//MARK: TLChatBarDelegate
// 发送文本消息
- (void)chatBar:(YDChatBar *)chatBar sendText:(NSString *)text
{
    YDTextMessage *message = [[YDTextMessage alloc] init];
    message.text = text;
    [self sendMessage:message];
    if ([self.partner chat_userType] == YDChatUserTypeUser) {
        YDTextMessage *message1 = [[YDTextMessage alloc] init];
        message1.fromUser = self.partner;
        message1.text = text;
        [self receivedMessage:message1];
    }
    else {
        for (id<YDChatUserProtocol> user in [self.partner groupMembers]) {
            YDTextMessage *message1 = [[YDTextMessage alloc] init];
            message1.friendID = [user chat_userID];
            message1.fromUser = user;
            message1.text = text;
            [self receivedMessage:message1];
        }
    }
}

////MARK: - 录音相关
//- (void)chatBarStartRecording:(YDChatBar *)chatBar
//{
//    // 先停止播放
//    if ([TLAudioPlayer sharedAudioPlayer].isPlaying) {
//        [[TLAudioPlayer sharedAudioPlayer] stopPlayingAudio];
//    }
//    
//    [self.recorderIndicatorView setStatus:TLRecorderStatusRecording];
//    [self.messageDisplayView addSubview:self.recorderIndicatorView];
//    [self.recorderIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(150, 150));
//    }];
//    
//    __block NSInteger time_count = 0;
//    TLVoiceMessage *message = [[TLVoiceMessage alloc] init];
//    message.ownerTyper = TLMessageOwnerTypeSelf;
//    message.userID = [TLUserHelper sharedHelper].userID;
//    message.fromUser = (id<TLChatUserProtocol>)[TLUserHelper sharedHelper].user;
//    message.msgStatus = TLVoiceMessageStatusRecording;
//    message.date = [NSDate date];
//    [[TLAudioRecorder sharedRecorder] startRecordingWithVolumeChangedBlock:^(CGFloat volume) {
//        time_count ++;
//        if (time_count == 2) {
//            [self addToShowMessage:message];
//        }
//        [self.recorderIndicatorView setVolume:volume];
//    } completeBlock:^(NSString *filePath, CGFloat time) {
//        if (time < 1.0) {
//            [self.recorderIndicatorView setStatus:TLRecorderStatusTooShort];
//            return;
//        }
//        [self.recorderIndicatorView removeFromSuperview];
//        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//            NSString *fileName = [NSString stringWithFormat:@"%.0lf.caf", [NSDate date].timeIntervalSince1970 * 1000];
//            NSString *path = [NSFileManager pathUserChatVoice:fileName];
//            NSError *error;
//            [[NSFileManager defaultManager] moveItemAtPath:filePath toPath:path error:&error];
//            if (error) {
//                DDLogError(@"录音文件出错: %@", error);
//                return;
//            }
//            
//            message.recFileName = fileName;
//            message.time = time;
//            message.msgStatus = TLVoiceMessageStatusNormal;
//            [message resetMessageFrame];
//            [self sendMessage:message];
//            if ([self.partner chat_userType] == TLChatUserTypeUser) {
//                TLVoiceMessage *message1 = [[TLVoiceMessage alloc] init];
//                message1.fromUser = self.partner;
//                message1.recFileName = fileName;
//                message1.time = time;
//                [self receivedMessage:message1];
//            }
//            else {
//                for (id<TLChatUserProtocol> user in [self.partner groupMembers]) {
//                    TLVoiceMessage *message1 = [[TLVoiceMessage alloc] init];
//                    message1.friendID = [user chat_userID];
//                    message1.fromUser = user;
//                    message1.recFileName = fileName;
//                    message1.time = time;
//                    [self receivedMessage:message1];
//                }
//            }
//        }
//    } cancelBlock:^{
//        [self.messageDisplayView deleteMessage:message];
//        [self.recorderIndicatorView removeFromSuperview];
//    }];
//}
//
//- (void)chatBarWillCancelRecording:(TLChatBar *)chatBar cancel:(BOOL)cancel
//{
//    [self.recorderIndicatorView setStatus:cancel ? TLRecorderStatusWillCancel : TLRecorderStatusRecording];
//}
//
//- (void)chatBarFinishedRecoding:(TLChatBar *)chatBar
//{
//    [[TLAudioRecorder sharedRecorder] stopRecording];
//}
//
//- (void)chatBarDidCancelRecording:(TLChatBar *)chatBar
//{
//    [[TLAudioRecorder sharedRecorder] cancelRecording];
//}

//MARK: - chatBar状态切换
- (void)chatBar:(YDChatBar *)chatBar changeStatusFrom:(YDChatBarStatus)fromStatus to:(YDChatBarStatus)toStatus
{
    
    if (curStatus == toStatus) {
        return;
    }
    lastStatus = fromStatus;
    curStatus = toStatus;
    if (toStatus == YDChatBarStatusInit) {
        if (fromStatus == YDChatBarStatusMore) {
            [self.moreKeyboard dismissWithAnimation:YES];
        }
        else if (fromStatus == YDChatBarStatusEmoji) {
            //[self.emojiKeyboard dismissWithAnimation:YES];
        }
    }
    else if (toStatus == YDChatBarStatusVoice) {
        if (fromStatus == YDChatBarStatusMore) {
            [self.moreKeyboard dismissWithAnimation:YES];
        }
        else if (fromStatus == YDChatBarStatusEmoji) {
            //[self.emojiKeyboard dismissWithAnimation:YES];
        }
    }
    else if (toStatus == YDChatBarStatusEmoji) {
        //[self.emojiKeyboard showInView:self.view withAnimation:YES];
    }
    else if (toStatus == YDChatBarStatusMore) {
        [self.moreKeyboard showInView:self.view withAnimation:YES];
    }
}

- (void)chatBar:(YDChatBar *)chatBar didChangeTextViewHeight:(CGFloat)height
{
    [self.messageDisplayView scrollToBottomWithAnimation:NO];
}

//MARK: YDKeyboardDelegate
- (void)chatKeyboardWillShow:(id)keyboard animated:(BOOL)animated
{
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)chatKeyboardDidShow:(id)keyboard animated:(BOOL)animated
{
    if (curStatus == YDChatBarStatusMore && lastStatus == YDChatBarStatusEmoji) {
        //[self.emojiKeyboard dismissWithAnimation:NO];
    }
    else if (curStatus == YDChatBarStatusEmoji && lastStatus == YDChatBarStatusMore) {
        [self.moreKeyboard dismissWithAnimation:NO];
    }
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)chatKeyboard:(id)keyboard didChangeHeight:(CGFloat)height
{
    
    self.chatBar.sd_layout.bottomSpaceToView(self.view,height);
    [self.chatBar updateLayout];
    [self.messageDisplayView updateLayout];
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

//MARK: YDKeyboardDelegate
- (void) moreKeyboard:(id)keyboard didSelectedFunctionItem:(YDMoreKeyboardItem *)funcItem{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"功能暂未实现!" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alert show];
}

//MARK: TLEmojiKeyboardDelegate
//- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB didSelectedEmojiItem:(YDEmoji *)emoji
//{
//    if (emoji.type == TLEmojiTypeEmoji || emoji.type == TLEmojiTypeFace) {
//        [self.chatBar addEmojiString:emoji.emojiName];
//    }
//    else {
//        TLExpressionMessage *message = [[TLExpressionMessage alloc] init];
//        message.emoji = emoji;
//        [self sendMessage:message];
//        if ([self.partner chat_userType] == TLChatUserTypeUser) {
//            TLExpressionMessage *message1 = [[TLExpressionMessage alloc] init];
//            message1.fromUser = self.partner;
//            message1.emoji = emoji;;
//            [self receivedMessage:message1];
//        }
//        else {
//            for (id<TLChatUserProtocol> user in [self.partner groupMembers]) {
//                TLExpressionMessage *message1 = [[TLExpressionMessage alloc] init];
//                message1.friendID = [user chat_userID];
//                message1.fromUser = user;
//                message1.emoji = emoji;
//                [self receivedMessage:message1];
//            }
//        }
//    }
//}

- (void)emojiKeyboardSendButtonDown
{
    [self.chatBar sendCurrentText];
}

- (void)emojiKeyboardDeleteButtonDown
{
    [self.chatBar deleteLastCharacter];
}

//- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB didTouchEmojiItem:(TLEmoji *)emoji atRect:(CGRect)rect
//{
//    if (emoji.type == TLEmojiTypeEmoji || emoji.type == TLEmojiTypeFace) {
//        if (self.emojiDisplayView.superview == nil) {
//            [self.emojiKeyboard addSubview:self.emojiDisplayView];
//        }
//        [self.emojiDisplayView displayEmoji:emoji atRect:rect];
//    }
//    else {
//        if (self.imageExpressionDisplayView.superview == nil) {
//            [self.emojiKeyboard addSubview:self.imageExpressionDisplayView];
//        }
//        [self.imageExpressionDisplayView displayEmoji:emoji atRect:rect];
//    }
//}
//
//- (void)emojiKeyboardCancelTouchEmojiItem:(TLEmojiKeyboard *)emojiKB
//{
//    if (self.emojiDisplayView.superview != nil) {
//        [self.emojiDisplayView removeFromSuperview];
//    }
//    else if (self.imageExpressionDisplayView.superview != nil) {
//        [self.imageExpressionDisplayView removeFromSuperview];
//    }
//}
//
//- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB selectedEmojiGroupType:(TLEmojiType)type
//{
//    if (type == TLEmojiTypeEmoji || type == TLEmojiTypeFace) {
//        [self.chatBar setActivity:YES];
//    }
//    else {
//        [self.chatBar setActivity:NO];
//    }
//}

- (BOOL)chatInputViewHasText
{
    return self.chatBar.curText.length == 0 ? NO : YES;
}

#pragma mark - # Getter
//- (TLEmojiKeyboard *)emojiKeyboard
//{
//    return [TLEmojiKeyboard keyboard];
//}

- (YDMoreKeyboard *)moreKeyboard
{
    return [YDMoreKeyboard keyboard];
}
@end

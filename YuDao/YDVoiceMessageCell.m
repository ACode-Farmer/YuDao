//
//  YDVoiceMessageCell.m
//  YuDao
//
//  Created by 汪杰 on 16/10/25.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDVoiceMessageCell.h"
#import "YDVoiceImageView.h"

@interface YDVoiceMessageCell()

@property (nonatomic, strong) UILabel *voiceTimeLabel;
@property (nonatomic, strong) YDVoiceImageView *voiceImageView;

@end

@implementation YDVoiceMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.voiceTimeLabel];
        [self.messageBackgroundView addSubview:self.voiceImageView];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMsgBGView)];
        [self.messageBackgroundView addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)setMessage:(YDVoiceMessage *)message{
    YDMessageOwnerType lastOwnType = self.message ? self.message.ownerTyper : -1;
    [super setMessage:message];
    
    [self.voiceTimeLabel setText:[NSString stringWithFormat:@"%.0lf\"\n", message.time]];
    
    if (lastOwnType != message.ownerTyper) {
        if (message.ownerTyper == YDMessageOwnerTypeSelf) {
            [self.voiceImageView setIsFromMe:YES];
            [self.messageBackgroundView setImage:[UIImage imageNamed:@"message_sender_bg"]];
            [self.messageBackgroundView setHighlightedImage:[UIImage imageNamed:@"message_sender_bgHL"]];
            
            self.voiceTimeLabel.sd_layout
            .rightSpaceToView(self.messageBackgroundView,0)
            .centerYEqualToView(self.avatarButton)
            .heightIs(20);
            [self.voiceTimeLabel setSingleLineAutoResizeWithMaxWidth:150];
            
            self.voiceImageView.sd_layout
            .rightSpaceToView(self.messageBackgroundView,10)
            .topSpaceToView(self.messageBackgroundView,11)
            .heightIs(20)
            .widthIs(20);
        }
        else if (message.ownerTyper == YDMessageOwnerTypeFriend){
            [self.voiceImageView setIsFromMe:NO];
            [self.messageBackgroundView setImage:[UIImage imageNamed:@"message_receiver_bg"]];
            [self.messageBackgroundView setHighlightedImage:[UIImage imageNamed:@"message_receiver_bgHL"]];

            self.voiceTimeLabel.sd_layout
            .leftSpaceToView(self.messageBackgroundView,0)
            .centerYEqualToView(self.avatarButton)
            .heightIs(20);
            [self.voiceTimeLabel setSingleLineAutoResizeWithMaxWidth:150];
            
            self.voiceImageView.sd_layout
            .leftSpaceToView(self.messageBackgroundView,5)
            .topSpaceToView(self.messageBackgroundView,11)
            .heightIs(20)
            .widthIs(20);
        }
    }
    
    self.messageBackgroundView.sd_layout
    .widthIs(message.messageFrame.contentSize.width)
    .heightIs(message.messageFrame.contentSize.height);
    if (message.msgStatus == YDVoiceMessageStatusRecording) {
        [self.voiceTimeLabel setHidden:YES];
        [self.voiceImageView setHidden:YES];
        [self y_startRecordingAnimation];
    }
    else {
        [self.voiceTimeLabel setHidden:NO];
        [self.voiceImageView setHidden:NO];
        [self y_stopRecordingAnimation];
        [self.messageBackgroundView setAlpha:1.0];
    }
    message.msgStatus == YDVoiceMessageStatusPlaying ? [self.voiceImageView startPlayingAnimation] : [self.voiceImageView stopPlayingAnimation];
}

- (void)updateMessage:(YDVoiceMessage *)message
{
    [super setMessage:message];
    
    [self.voiceTimeLabel setText:[NSString stringWithFormat:@"%.0lf\"\n", message.time]];
    if (message.msgStatus == YDVoiceMessageStatusRecording) {
        [self.voiceTimeLabel setHidden:YES];
        [self.voiceImageView setHidden:YES];
        [self y_startRecordingAnimation];
    }
    else {
        [self.voiceTimeLabel setHidden:NO];
        [self.voiceImageView setHidden:NO];
        [self y_stopRecordingAnimation];
    }
    message.msgStatus == YDVoiceMessageStatusPlaying ? [self.voiceImageView startPlayingAnimation] : [self.voiceImageView stopPlayingAnimation];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.messageBackgroundView.sd_layout
        .widthIs(message.messageFrame.contentSize.width)
        .heightIs(message.messageFrame.contentSize.height);
        [self.messageBackgroundView updateLayout];
    }];
}
#pragma mark - # Event Response
- (void)didTapMsgBGView
{
    [self.voiceImageView startPlayingAnimation];
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellTap:)]) {
        [self.delegate messageCellTap:self.message];
    }
}

#pragma mark - # Private Methods
static bool isStartAnimation = NO;
static float bgAlpha = 1.0;
- (void)y_startRecordingAnimation
{
    isStartAnimation = YES;
    bgAlpha = 0.4;
    [self y_repeatAnimation];
}

- (void)y_repeatAnimation
{
    [UIView animateWithDuration:1.0 animations:^{
        [self.messageBackgroundView setAlpha:bgAlpha];
    } completion:^(BOOL finished) {
        if (finished) {
            bgAlpha = bgAlpha > 0.9 ? 0.4 : 1.0;
            if (isStartAnimation) {
                [self y_repeatAnimation];
            }
            else {
                [self.messageBackgroundView setAlpha:1.0];
            }
        }
    }];
}

- (void)y_stopRecordingAnimation
{
    isStartAnimation = NO;
}


#pragma mark - # Getter
- (UILabel *)voiceTimeLabel
{
    if (_voiceTimeLabel == nil) {
        _voiceTimeLabel = [[UILabel alloc] init];
        [_voiceTimeLabel setTextColor:[UIColor grayColor]];
        [_voiceTimeLabel setFont:[UIFont systemFontOfSize:14.0f]];
        _voiceTimeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _voiceTimeLabel;
}

- (YDVoiceImageView *)voiceImageView
{
    if (_voiceImageView == nil) {
        _voiceImageView = [[YDVoiceImageView alloc] init];
    }
    return _voiceImageView;
}
@end

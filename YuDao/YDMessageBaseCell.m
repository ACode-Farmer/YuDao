//
//  YDMessageBaseCell.m
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMessageBaseCell.h"
#import "UIButton+WebCache.h"
#import "NSDate+YDChat.h"
#import "NSFileManager+YDChat.h"

#define     TIMELABEL_HEIGHT    20.0f
#define     TIMELABEL_SPACE_Y   10.0f

#define     NAMELABEL_HEIGHT    14.0f
#define     NAMELABEL_SPACE_X   12.0f
#define     NAMELABEL_SPACE_Y   1.0f

#define     AVATAR_WIDTH        40.0f
#define     AVATAR_SPACE_X      8.0f
#define     AVATAR_SPACE_Y      10.0f

#define     MSGBG_SPACE_X       5.0f
#define     MSGBG_SPACE_Y       1.0f

@interface YDMessageBaseCell()

@end

@implementation YDMessageBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        NSArray *subviews = @[self.timeLabel,self.avatarButton,self.usernameLabel,self.messageBackgroundView];
        [self.contentView sd_addSubviews:subviews];
        
        [self y_addMasonry];
    }
    return self;
}

- (void)setMessage:(YDMessage *)message{
    if (_message && [_message.messageID isEqualToString:message.messageID]) {
        return;
    }
    [self.timeLabel setText:[NSString stringWithFormat:@"  %@  ", message.date.chatTimeInfo]];
    [self.usernameLabel setText:[message.fromUser chat_username]];
    if ([message.fromUser chat_avatarPath].length > 0) {
        NSString *path = [NSFileManager pathUserAvatar:[message.fromUser chat_avatarPath]];
        [self.avatarButton setImage:[UIImage imageNamed:path] forState:UIControlStateNormal];
    }
    else {
        [self.avatarButton sd_setImageWithURL:YDURL([message.fromUser chat_avatarURL]) forState:UIControlStateNormal];
    }
    
    // 时间
    if (!_message || _message.showTime != message.showTime) {
        self.timeLabel.sd_layout
        .heightIs(message.showTime?TIMELABEL_HEIGHT:0);
    }
    
    if (!message || _message.ownerTyper != message.ownerTyper) {
        // 头像
        if (message.ownerTyper == YDMessageOwnerTypeSelf) {
            self.avatarButton.sd_layout.rightSpaceToView(self.contentView,AVATAR_SPACE_X);
        }else{
            self.avatarButton.sd_layout.leftSpaceToView(self.contentView,AVATAR_SPACE_X);
        }
        
        if (message.ownerTyper == YDMessageOwnerTypeSelf) {
            self.usernameLabel.sd_layout.rightSpaceToView(self.avatarButton,NAMELABEL_SPACE_X);
        }else{
            self.usernameLabel.sd_layout.leftSpaceToView(self.avatarButton,-NAMELABEL_SPACE_X);
        }
        // 背景
        if (message.ownerTyper == YDMessageOwnerTypeSelf) {
            self.messageBackgroundView.sd_layout
            .rightSpaceToView(self.avatarButton,MSGBG_SPACE_X);
        }else{
            self.messageBackgroundView.sd_layout
            .leftSpaceToView(self.avatarButton,MSGBG_SPACE_X);
        }
    }
    
    [self.usernameLabel setHidden:!message.showName];
    self.usernameLabel.sd_layout.heightIs(message.showName? NAMELABEL_HEIGHT:0);
    _message = message;
}

- (void)updateMessage:(YDMessage *)message{
    [self setMessage:message];
}

#pragma mark - Private Methods -
- (void)y_addMasonry
{
    UIView *view = self.contentView;
    self.timeLabel.sd_layout
    .topSpaceToView(view,TIMELABEL_SPACE_Y)
    .centerXEqualToView(view)
    .widthRatioToView(view,0.8);
    
    self.usernameLabel.sd_layout
    .topEqualToView(self.avatarButton)
    .leftSpaceToView(self.avatarButton,NAMELABEL_SPACE_X);
    
    // Default - self
    self.avatarButton.sd_layout
    .rightSpaceToView(view,AVATAR_SPACE_X)
    .widthIs(AVATAR_WIDTH)
    .heightEqualToWidth()
    .topSpaceToView(self.timeLabel,AVATAR_SPACE_Y);
    
    self.messageBackgroundView.sd_layout
    .rightSpaceToView(self.avatarButton,MSGBG_SPACE_X)
    .topSpaceToView(self.usernameLabel,0);
}

#pragma mark - Event Response -
- (void)avatarButtonDown:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(messageCellDidClickAvatarForUser:)]) {
        [_delegate messageCellDidClickAvatarForUser:self.message.fromUser];
    }
}

- (void)longPressMsgBGView
{
    [self.messageBackgroundView setHighlighted:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(messageCellLongPress:rect:)]) {
        CGRect rect = self.messageBackgroundView.frame;
        rect.size.height -= 10;     // 北京图片底部空白区域
        [_delegate messageCellLongPress:self.message rect:rect];
    }
}

- (void)doubleTabpMsgBGView
{
    if (_delegate && [_delegate respondsToSelector:@selector(messageCellDoubleClick:)]) {
        [_delegate messageCellDoubleClick:self.message];
    }
}

#pragma mark - Getter -
- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_timeLabel setTextColor:[UIColor blackColor]];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
//        [_timeLabel setBackgroundColor:[UIColor grayColor]];
//        [_timeLabel setAlpha:0.7f];
//        [_timeLabel.layer setMasksToBounds:YES];
//        [_timeLabel.layer setCornerRadius:5.0f];
    }
    return _timeLabel;
}

- (UIButton *)avatarButton
{
    if (_avatarButton == nil) {
        _avatarButton = [[UIButton alloc] init];
        [_avatarButton.layer setMasksToBounds:YES];
        [_avatarButton.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_avatarButton.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
        [_avatarButton addTarget:self action:@selector(avatarButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _avatarButton;
}

- (UILabel *)usernameLabel
{
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc] init];
        [_usernameLabel setTextColor:[UIColor grayColor]];
        [_usernameLabel setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _usernameLabel;
}

- (UIImageView *)messageBackgroundView
{
    if (_messageBackgroundView == nil) {
        _messageBackgroundView = [[UIImageView alloc] init];
        [_messageBackgroundView setUserInteractionEnabled:YES];
        _messageBackgroundView.contentMode = UIViewContentModeScaleToFill;
        
        UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMsgBGView)];
        [_messageBackgroundView addGestureRecognizer:longPressGR];
        
        UITapGestureRecognizer *doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTabpMsgBGView)];
        [doubleTapGR setNumberOfTapsRequired:2];
        [_messageBackgroundView addGestureRecognizer:doubleTapGR];
    }
    return _messageBackgroundView;
}

@end

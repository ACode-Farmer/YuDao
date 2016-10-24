//
//  YDImageMessageCell.m
//  YuDao
//
//  Created by 汪杰 on 16/10/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDImageMessageCell.h"
#import "YDMessageImageView.h"
#import "NSFileManager+YDChat.h"

#define     MSG_SPACE_TOP       2

@interface YDImageMessageCell ()

@property (nonatomic, strong) YDMessageImageView *msgImageView;

@end@implementation YDImageMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgImageView];
    }
    return self;
}

- (void)setMessage:(YDImageMessage *)message
{
    [self.msgImageView setAlpha:1.0];       // 取消长按效果
    if (self.message && [self.message.messageID isEqualToString:message.messageID]) {
        return;
    }
    YDMessageOwnerType lastOwnType = self.message ? self.message.ownerTyper : -1;
    [super setMessage:message];
    
    if ([message imagePath]) {
        NSString *imagePath = [NSFileManager pathUserChatImage:[message imagePath]];
        [self.msgImageView setThumbnailPath:imagePath highDefinitionImageURL:[message imagePath]];
    }
    else {
        [self.msgImageView setThumbnailPath:nil highDefinitionImageURL:[message imagePath]];
    }
    
    if (lastOwnType != message.ownerTyper) {
        if (message.ownerTyper == YDMessageOwnerTypeSelf) {
            [self.msgImageView setBackgroundImage:[UIImage imageNamed:@"message_sender_bg"]];
            
            self.msgImageView.sd_layout
            .topEqualToView(self.messageBackgroundView)
            .rightEqualToView(self.messageBackgroundView);
        }
        else if (message.ownerTyper == YDMessageOwnerTypeFriend){
            [self.msgImageView setBackgroundImage:[UIImage imageNamed:@"message_receiver_bg"]];
            
            self.msgImageView.sd_layout
            .topEqualToView(self.messageBackgroundView)
            .leftEqualToView(self.messageBackgroundView);
        }
    }
    
    self.msgImageView.sd_layout.widthIs(message.messageFrame.contentSize.width)
    .heightIs(message.messageFrame.contentSize.height);
}

#pragma mark - Event Response -
- (void)tapMessageView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellTap:)]) {
        [self.delegate messageCellTap:self.message];
    }
}

- (void)longPressMsgBGView
{
    [self.msgImageView setAlpha:0.7];   // 比较low的选中效果
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellLongPress:rect:)]) {
        CGRect rect = self.msgImageView.frame;
        rect.size.height -= 10;     // 北京图片底部空白区域
        [self.delegate messageCellLongPress:self.message rect:rect];
    }
}

- (void)doubleTabpMsgBGView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellDoubleClick:)]) {
        [self.delegate messageCellDoubleClick:self.message];
    }
}

#pragma mark - Getter -
- (YDMessageImageView *)msgImageView
{
    if (_msgImageView == nil) {
        _msgImageView = [[YDMessageImageView alloc] init];
        [_msgImageView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMessageView)];
        [_msgImageView addGestureRecognizer:tapGR];
        
        UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMsgBGView)];
        [_msgImageView addGestureRecognizer:longPressGR];
        
        UITapGestureRecognizer *doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTabpMsgBGView)];
        [doubleTapGR setNumberOfTapsRequired:2];
        [_msgImageView addGestureRecognizer:doubleTapGR];
    }
    return _msgImageView;
}

@end

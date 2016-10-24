//
//  YDTextMessageCell.m
//  YuDao
//
//  Created by 汪杰 on 16/10/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTextMessageCell.h"

#define     MSG_SPACE_TOP       14
#define     MSG_SPACE_BTM       20
#define     MSG_SPACE_LEFT      19
#define     MSG_SPACE_RIGHT     22

@interface YDTextMessageCell ()

@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation YDTextMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.messageBackgroundView addSubview:self.messageLabel];
    }
    return self;
}

- (void)setMessage:(YDTextMessage *)message
{
    if (self.message && [self.message.messageID isEqualToString:message.messageID]) {
        return;
    }
    YDMessageOwnerType lastOwnType = self.message ? self.message.ownerTyper : -1;
    [super setMessage:message];
    self.messageLabel.text = message.text;
    [self.messageLabel setContentCompressionResistancePriority:500 forAxis:UILayoutConstraintAxisHorizontal];
    [self.messageBackgroundView setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
    CGSize size = message.messageFrame.contentSize;
    if (lastOwnType != message.ownerTyper) {
        if (message.ownerTyper == YDMessageOwnerTypeSelf) {
            [self.messageBackgroundView setImage:[UIImage imageNamed:@"message_sender_bg"]];
            [self.messageBackgroundView setHighlightedImage:[UIImage imageNamed:@"message_sender_bgHL"]];
            
            self.messageBackgroundView.sd_layout
            .widthIs(size.width+2*MSG_SPACE_RIGHT)
            .heightIs(message.messageFrame.height);
            
            self.messageLabel.sd_layout
            .rightSpaceToView(self.messageBackgroundView,MSG_SPACE_RIGHT)
            .topSpaceToView(self.messageBackgroundView,MSG_SPACE_TOP)
            .leftSpaceToView(self.messageBackgroundView,MSG_SPACE_RIGHT)
            .bottomSpaceToView(self.messageBackgroundView,1.5*MSG_SPACE_TOP);
            
        }
        else if (message.ownerTyper == YDMessageOwnerTypeFriend){
            [self.messageBackgroundView setImage:[UIImage imageNamed:@"message_receiver_bg"]];
            [self.messageBackgroundView setHighlightedImage:[UIImage imageNamed:@"message_receiver_bgHL"]];
            
            self.messageBackgroundView.sd_layout
            .widthRatioToView(self.contentView,0.7)
            .heightIs(60);
            self.messageLabel.sd_layout
            .leftSpaceToView(self.messageBackgroundView,MSG_SPACE_LEFT)
            .topSpaceToView(self.messageBackgroundView,MSG_SPACE_TOP);
        }
    }
    
}

#pragma mark - Getter -
- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        [_messageLabel setFont:[UIFont fontTextMessageText]];
        [_messageLabel setNumberOfLines:0];
    }
    return _messageLabel;
}

@end

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
    if (message.showTime) {
        self.avatarButton.sd_layout.topSpaceToView(self.timeLabel,10);
    }else{
        self.avatarButton.sd_layout.topSpaceToView(self.timeLabel,0);
    }
    YDMessageOwnerType lastOwnType = self.message ? self.message.ownerTyper : -1;
    [super setMessage:message];
    self.messageLabel.text = message.text;
    [self.messageLabel setContentCompressionResistancePriority:500 forAxis:UILayoutConstraintAxisHorizontal];
    [self.messageBackgroundView setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
    if (lastOwnType != message.ownerTyper) {
        if (message.ownerTyper == YDMessageOwnerTypeSelf) {
            
            self.messageLabel.sd_layout
            .rightSpaceToView(self.messageBackgroundView,MSG_SPACE_RIGHT)
            .topSpaceToView(self.messageBackgroundView,MSG_SPACE_TOP);
            
        }
        else if (message.ownerTyper == YDMessageOwnerTypeFriend){
            
            
            self.messageLabel.sd_layout
            .leftSpaceToView(self.messageBackgroundView,MSG_SPACE_RIGHT)
            .topSpaceToView(self.messageBackgroundView,MSG_SPACE_TOP);
        }
    }
    CGSize contentSize = message.messageFrame.contentSize;
    self.messageLabel.sd_layout
    .widthIs(contentSize.width)
    .heightIs(contentSize.height);
    self.messageBackgroundView.sd_layout
    .widthIs(contentSize.width+MSG_SPACE_LEFT+MSG_SPACE_RIGHT)
    .heightIs(contentSize.height+MSG_SPACE_TOP+MSG_SPACE_BTM);
    
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

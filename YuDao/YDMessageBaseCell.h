//
//  YDMessageBaseCell.h
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDChatMacros.h"
#import "YDMessageCellDelegate.h"
#import "YDMessage.h"

@interface YDMessageBaseCell : UITableViewCell

@property (nonatomic, weak) id<YDMessageCellDelegate> delegate;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *avatarButton;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UIImageView *messageBackgroundView;
@property (nonatomic, strong) YDMessage *message;

/**
 *  更新消息，如果子类不重写，默认调用setMessage方法
 */
- (void)updateMessage:(YDMessage *)message;

@end

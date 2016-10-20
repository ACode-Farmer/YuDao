//
//  YDMessageCellDelegate.h
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YDChatUserProtocol;
@class YDMessage;

@protocol YDMessageCellDelegate <NSObject>

- (void)messageCellDidClickAvatarForUser:(id<YDChatUserProtocol>)user;

- (void)messageCellTap:(YDMessage *)message;

- (void)messageCellLongPress:(YDMessage *)message rect:(CGRect)rect;

- (void)messageCellDoubleClick:(YDMessage *)message;

@end

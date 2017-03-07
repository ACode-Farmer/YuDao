//
//  YDConversationCell.h
//  YuDao
//
//  Created by 汪杰 on 17/2/13.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDConversation.h"

@interface YDConversationCell : UITableViewCell

@property (nonatomic, strong) YDConversation *model;

/**
 *  标记为已读
 */
- (void) markAsRead;

@end

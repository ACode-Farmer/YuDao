//
//  YDChatMessageDisplayView+Delegate.h
//  YuDao
//
//  Created by 汪杰 on 16/10/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDChatMessageDisplayView.h"
#import "YDTextMessageCell.h"
#import "YDImageMessageCell.h"
#import "YDExpressionMessageCell.h"
#import "YDVoiceMessageCell.h"
#import "YDMessageCellDelegate.h"

@interface YDChatMessageDisplayView (Delegate)<UITableViewDelegate, UITableViewDataSource, YDMessageCellDelegate>

- (void)registerCellClassForTableView:(UITableView *)tableView;

@end

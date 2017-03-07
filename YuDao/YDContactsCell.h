//
//  YDContactsCell.h
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDFriendModel.h"

@interface YDContactsCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel    *usernameLabel;

@property (nonatomic, strong) UIView *redPointView;

@property (nonatomic, strong) UILabel *remindLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) YDFriendModel *model;

/**
 *  标记为未读
 */
- (void) markAsUnreadCount:(NSInteger )count;


@end

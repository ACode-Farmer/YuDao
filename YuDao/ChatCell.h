//
//  ChatCell.h
//  YuDao
//
//  Created by 汪杰 on 16/9/11.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChatModel;
@interface ChatCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIButton *messageBtn;
@property (nonatomic, strong) UILabel *timeLabel;

- (void)updateCellWithModel:(ChatModel *)model;

@end

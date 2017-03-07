//
//  YDDDCommentCell.h
//  YuDao
//
//  Created by 汪杰 on 16/10/28.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDDynamicDetailModel.h"

@interface YDDDCommentCell : UITableViewCell

@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) YDDynamicCommentModel *model;

@end

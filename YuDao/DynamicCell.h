//
//  DynamicCell.h
//  YuDao
//
//  Created by 汪杰 on 16/9/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DynamicCellDelegate <NSObject>

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell;
- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell;

@end

@class DynamicCellModel;
@interface DynamicCell : UITableViewCell

@property (nonatomic, weak) id<DynamicCellDelegate> delegate;
@property (nonatomic, strong) DynamicCellModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);

@end

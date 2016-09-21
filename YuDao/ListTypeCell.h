//
//  ListTypeCell.h
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListTypeCell;
@protocol ListTypeCellDelegate <NSObject>

- (void)arrowBtnAction:(ListTypeCell *)cell button:(UIButton *)sender;

- (void)typeBtnAction:(ListTypeCell *)cell button:(UIButton *)sender;

@end

@interface ListTypeCell : UITableViewCell

@property (nonatomic, weak) id<ListTypeCellDelegate> delegate;

@property (nonatomic, strong) UIButton *arrowBtn;

@end

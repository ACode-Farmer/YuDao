//
//  MenuCell.h
//  YuDao
//
//  Created by 汪杰 on 16/9/13.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuModel,MenuCell;

@protocol MenuCellDelegate <NSObject>

- (void)sameDidselectedCellAction:(MenuCell *)cell btn:(UIButton *)sender;

@end

@interface MenuCell : UITableViewCell

@property (nonatomic, strong) UIButton *arrowBtn;
@property (nonatomic, strong) MenuModel *model;

@property (nonatomic, weak) id<MenuCellDelegate> delegate;

@end

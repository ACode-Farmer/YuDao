//
//  MenuCell.h
//  YuDao
//
//  Created by 汪杰 on 16/9/13.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuModel;

@interface MenuCell : UITableViewCell

@property (nonatomic, strong) UIButton *arrowBtn;
@property (nonatomic, strong) MenuModel *model;

@end

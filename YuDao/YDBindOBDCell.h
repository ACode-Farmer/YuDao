//
//  YDBindOBDCell.h
//  YuDao
//
//  Created by 汪杰 on 16/11/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDBindOBDModel.h"

@class YDBindOBDCell;
@protocol YDBindOBDCellDelegate <NSObject>

- (void)bindOBDCell:(YDBindOBDCell *)cell didTouchChooseButton:(UIButton *)btn;

@end

@interface YDBindOBDCell : UITableViewCell<UITextFieldDelegate>



@property (nonatomic, weak  ) id<YDBindOBDCellDelegate> delegate;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextField *textF;

@property (nonatomic, strong) UIButton *chooseBtn;

@property (nonatomic, strong) UIView   *lineView;

@property (nonatomic, strong) YDBindOBDModel *model;

@end

//
//  YDMainTitleView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/8.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

#define iconWidthHeight 30 * widthHeight_ratio

@interface YDMainTitleView : UIView

@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *leftBtn;

- (void)setTitle:(NSString *)title leftBtnImage:(NSString *)leftImageName rightBtnImage:(NSString *)rightImageName;

@end

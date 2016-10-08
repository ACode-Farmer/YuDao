//
//  YDMainTitleView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/8.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

#define titleViewHeight 0.18 * (screen_height-112)

#define iconWidthHeight 20 * widthHeight_ratio

@interface YDMainTitleView : UIView

@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *leftBtn;

@end

//
//  YDMainTitleView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/8.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMainTitleView.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>

@implementation YDMainTitleView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self superview].backgroundColor = [UIColor whiteColor];
    NSArray *subViews = @[self.leftBtn,self.titleLabel,self.rightBtn];
    [self sd_addSubviews:subViews];
    
    _leftBtn.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self,18)
    .widthIs(iconWidthHeight)
    .heightEqualToWidth();
    
    _rightBtn.sd_layout
    .centerYEqualToView(self)
    .rightSpaceToView(self,18)
    .widthIs(iconWidthHeight)
    .heightEqualToWidth();
    
    _titleLabel.sd_layout
    .centerYEqualToView(self)
    .centerXEqualToView(self)
    .heightRatioToView(self,0.8)
    .widthRatioToView(self,0.5);
}

- (void)setTitle:(NSString *)title leftBtnImage:(NSString *)leftImageName rightBtnImage:(NSString *)rightImageName{
    _titleLabel.text = title;
    
    [_leftBtn setImage:[UIImage imageNamed:leftImageName] forState:0];
    [_rightBtn setImage:[UIImage imageNamed:rightImageName] forState:0];
}

- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [UIButton new];
        _leftBtn.backgroundColor = [UIColor clearColor];
    }
    return _leftBtn;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton new];
        _rightBtn.backgroundColor = [UIColor clearColor];
    }
    return _rightBtn;
}

@end

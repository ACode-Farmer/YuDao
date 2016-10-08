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
        
    }
    return self;
}

- (void)setupSubviews{
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
    }
    return _titleLabel;
}

- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton new];
        _rightBtn = [UIColor clearColor];
    }
    return _rightBtn;
}

@end

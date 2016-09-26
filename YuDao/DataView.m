//
//  DataView.m
//  YuDao
//
//  Created by 汪杰 on 16/9/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "DataView.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
#import "DrivingModel.h"

@implementation DataView
{
    UILabel *_titleLabel;
    UILabel *_dataLabel;
    UILabel *_subTitleLabel;
}
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.sd_cornerRadiusFromWidthRatio = @0.5;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    _titleLabel = [UILabel new];
    _dataLabel = [UILabel new];
    _subTitleLabel = [UILabel new];
    
    NSArray *subviews = @[_titleLabel,_dataLabel,_subTitleLabel];
    for (UILabel *label in subviews) {
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
    }
    [self sd_addSubviews:subviews];
    
    _dataLabel.sd_layout
    .centerXEqualToView(self)
    .centerYEqualToView(self)
    .heightRatioToView(self,0.3)
    .widthRatioToView(self,0.7);
    
    _titleLabel.sd_layout
    .centerXEqualToView(self)
    .bottomSpaceToView(_dataLabel,3)
    .heightRatioToView(self,0.2)
    .widthRatioToView(self,0.5);
    
    _subTitleLabel.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(_dataLabel,3)
    .heightRatioToView(self,0.2)
    .widthRatioToView(self,0.5);
    
}

- (void)setModel:(DrivingModel *)model{
    _model = model;
    _titleLabel.text = model.title;
    _dataLabel.text = model.data;
    _subTitleLabel.text = model.subTitle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  YDTodayFirstLoginView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTodayFirstLoginView.h"

#define imageViewW_H 100

@implementation YDTodayFirstLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        [self sd_addSubviews:@[self.imageView,self.label]];
        [self y_layoutSubviews];
    }
    return self;
}

#pragma mark - Private Methods
- (void)y_layoutSubviews{
    self.imageView.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self,10)
    .heightRatioToView(self,0.8)
    .widthEqualToHeight();
    
    self.label.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self.imageView,10)
    .heightIs(21);
    [self.label setSingleLineAutoResizeWithMaxWidth:200];
}

- (void)updateTFLView:(UIImage *)image title:(NSString *)title{
    self.imageView.image = image;
    self.label.text = title;
}

#pragma mark - Getter
- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

- (UILabel *)label{
    if (_label == nil) {
        _label = [UILabel new];
    }
    return _label;
}

@end

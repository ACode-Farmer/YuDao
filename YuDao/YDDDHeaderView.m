//
//  YDDDHeaderView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDDHeaderView.h"

@implementation YDDDHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self sd_addSubviews:@[self.userImageView,self.userNameLabel,self.genderImageView,self.levelLabel,self.timeLabel]];
        [self y_latoutSubviews];
    }
    return self;
}

- (void)updateHeaderView:(NSString *)userImage userName:(NSString *)name genderImage:(NSString *)genderImage level:(NSString *)level time:(NSString *)time{
    self.userImageView.image = [UIImage imageNamed:userImage];
    self.userNameLabel.text = name;
    self.genderImageView.image = [UIImage imageNamed:genderImage];
    self.levelLabel.text = level;
    self.timeLabel.text = time;
}

- (void)y_latoutSubviews{
    self.userImageView.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self,5)
    .heightRatioToView(self,0.8)
    .widthEqualToHeight();
    self.userImageView.sd_cornerRadius = @5;
    
    self.userNameLabel.sd_layout
    .centerYEqualToView(self.userImageView)
    .leftSpaceToView(self.userImageView,5)
    .heightIs(21);
    [self.userNameLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.genderImageView.sd_layout
    .centerYEqualToView(self.userNameLabel)
    .leftSpaceToView(self.userNameLabel,5)
    .heightRatioToView(self.userNameLabel,1)
    .widthEqualToHeight();
    
    self.levelLabel.sd_layout
    .centerYEqualToView(self.userNameLabel)
    .leftSpaceToView(self.genderImageView,5)
    .heightIs(21);
    [self.levelLabel setSingleLineAutoResizeWithMaxWidth:50];
    
    self.timeLabel.sd_layout
    .centerYEqualToView(self)
    .rightSpaceToView(self,5)
    .heightIs(21);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:100];
}

#pragma mark Getter
- (UIImageView *)userImageView{
    if (_userImageView == nil) {
        _userImageView = [UIImageView new];
    }
    return _userImageView;
}

- (UILabel *)userNameLabel{
    if (_userNameLabel == nil) {
        _userNameLabel = [UILabel new];
    }
    return _userNameLabel;
}

- (UIImageView *)genderImageView{
    if (_genderImageView == nil) {
        _genderImageView = [UIImageView new];
    }
    return _genderImageView;
}

- (UILabel *)levelLabel{
    if (_levelLabel == nil) {
        _levelLabel = [UILabel new];
        _levelLabel.textColor = [UIColor orangeColor];
    }
    return _levelLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel new];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont font_14];
    }
    return _timeLabel;
}

@end

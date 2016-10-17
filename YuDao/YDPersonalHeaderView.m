//
//  YDPersonalHeaderView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/17.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDPersonalHeaderView.h"

@implementation YDPersonalHeaderView


- (instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.backImageView];
        NSArray *subviews = @[self.headerImageView,self.genderImageView,self.animalLabel,self.likeBtn,self.levelBtn];
        [self.backImageView sd_addSubviews:subviews];
        [self y_layoutSubviews];
    }
    return self;
}

- (void)y_layoutSubviews{
    self.headerImageView.image = [UIImage imageNamed:@"head4.jpg"];
    self.genderImageView.image = [UIImage imageNamed:@"mine_girl"];
    self.animalLabel.text = @"羊";
    [self.likeBtn setImage:[UIImage imageNamed:@"list_placing"] forState:0];
    [self.likeBtn setTitle:@"66666人喜欢" forState:0];
    [self.likeBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.levelBtn setImage:[UIImage imageNamed:@"list_placing"] forState:0];
    [self.levelBtn setTitle:@"认证等级V9" forState:0];
    [self.levelBtn setTitleColor:[UIColor whiteColor] forState:0];
    
    self.backImageView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
    self.headerImageView.sd_layout
    .leftSpaceToView(self.backImageView,10)
    .bottomSpaceToView(self.backImageView,5)
    .heightRatioToView(self.backImageView,0.4)
    .widthEqualToHeight();
    
    self.genderImageView.sd_layout
    .leftSpaceToView(self.headerImageView,10)
    .bottomSpaceToView(self.backImageView,10)
    .heightRatioToView(self.headerImageView,0.5)
    .widthEqualToHeight();
    
    self.animalLabel.sd_layout
    .leftSpaceToView(self.genderImageView,5)
    .bottomEqualToView(self.genderImageView)
    .heightRatioToView(self.headerImageView,0.5)
    .widthEqualToHeight();
    
    self.levelBtn.sd_layout
    .rightSpaceToView(self.backImageView,0)
    .bottomEqualToView(self.animalLabel)
    .topEqualToView(self.animalLabel)
    .leftSpaceToView(self.animalLabel,20);
    
    self.likeBtn.sd_layout
    .leftEqualToView(self.levelBtn)
    .rightEqualToView(self.levelBtn)
    .bottomSpaceToView(self.levelBtn,2)
    .heightRatioToView(self.levelBtn,1);
}

#pragma mark Getters
- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        _backImageView.image = [UIImage imageNamed:@"mine_header_back"];
    }
    return _backImageView;
}
- (UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [UIImageView new];
        _headerImageView.sd_cornerRadiusFromWidthRatio = @0.5;
    }
    return _headerImageView;
}

- (UIImageView *)genderImageView{
    if (!_genderImageView) {
        _genderImageView = [UIImageView new];
    }
    return _genderImageView;
}

- (UILabel *)animalLabel{
    if (!_animalLabel) {
        _animalLabel = [UILabel new];
        _animalLabel.textAlignment = NSTextAlignmentCenter;
        _animalLabel.font = [UIFont font_16];
    }
    return _animalLabel;
}

- (UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = [UIButton new];
        _likeBtn.backgroundColor = [UIColor redColor];
    }
    return _likeBtn;
}

- (UIButton *)levelBtn{
    if (!_levelBtn) {
        _levelBtn = [UIButton new];
        _levelBtn.backgroundColor = [UIColor orangeColor];
    }
    return _levelBtn;
}




@end

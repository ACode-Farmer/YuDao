//
//  YDDDCommentCell.m
//  YuDao
//
//  Created by 汪杰 on 16/10/28.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDDCommentCell.h"

@implementation YDDDCommentCell
{
    UIView *_lineView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView sd_addSubviews:@[self.userImageView,self.titleLabel,self.subTitleLabel]];
        [self y_layoutSubviews];
    }
    return self;
}

- (void)setModel:(YDDynamicCommentModel *)model{
    _model = model;
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:model.ud_face] placeholderImage:[UIImage imageNamed:@"mine_user_placeholder"]];
    self.titleLabel.text = model.ub_nickname;
    self.subTitleLabel.text = model.cd_details;
    
    if (model.cd_details.length == 0 || model.ub_nickname.length == 0) {
        _lineView.sd_layout
        .leftSpaceToView(self.contentView,19)
        .rightSpaceToView(self.contentView,19)
        .heightIs(1)
        .topSpaceToView(self.userImageView,10);
    }
    
    [self setupAutoHeightWithBottomViewsArray:@[self.userImageView,self.titleLabel,self.subTitleLabel,_lineView] bottomMargin:2];
}


- (void)y_layoutSubviews{
    UIView *view = self.contentView;
    //CGFloat kUserImage_left_space = screen_width*0.15/2;
    self.userImageView.sd_layout
    .topSpaceToView(view,10)
    .leftSpaceToView(view,19)
    .heightIs(40)
    .widthIs(40);
    
    self.titleLabel.sd_layout
    .topEqualToView(self.userImageView)
    .leftSpaceToView(self.userImageView,5)
    .heightIs(21);
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.subTitleLabel.sd_layout
    .topSpaceToView(self.titleLabel,0)
    .leftEqualToView(self.titleLabel)
    .rightSpaceToView(view,20)
    .autoHeightRatio(0);

    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor colorWithString:@"#B6C5DC"];
    lineView.alpha = 0.7;
    [self.contentView addSubview:lineView];
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,19)
    .rightSpaceToView(self.contentView,19)
    .heightIs(1)
    .topSpaceToView(self.subTitleLabel,10);
    _lineView = lineView;
    
}

#pragma mark - Getter
- (UIImageView *)userImageView{
    if (_userImageView == nil) {
        _userImageView = [UIImageView new];
        _userImageView.sd_cornerRadiusFromWidthRatio = @0.5;
    }
    return _userImageView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont font_12];
        _titleLabel.textColor = [UIColor colorTextGray];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel{
    if (_subTitleLabel == nil) {
        _subTitleLabel = [UILabel new];
        _subTitleLabel.font = [UIFont font_14];
        _subTitleLabel.numberOfLines = 0;
    }
    return _subTitleLabel;
}

@end

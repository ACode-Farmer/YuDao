//
//  YDDDCommentCell.m
//  YuDao
//
//  Created by 汪杰 on 16/10/28.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDDCommentCell.h"
#import "YDDDContentModel.h"

@implementation YDDDCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView sd_addSubviews:@[self.userImageView,self.titleLabel,self.subTitleLabel]];
        [self y_layoutSubviews];
    }
    return self;
}

- (void)setModel:(YDDDNormalModel *)model{
    _model = model;
    self.userImageView.image = [UIImage imageNamed:model.imageName];
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.subTitle;
    
    [self setupAutoHeightWithBottomViewsArray:@[self.userImageView,self.titleLabel,self.subTitleLabel] bottomMargin:5];
}


- (void)y_layoutSubviews{
    UIView *view = self.contentView;
    CGFloat kUserImage_left_space = screen_width*0.15/2;
    self.userImageView.sd_layout
    .topSpaceToView(view,5)
    .leftSpaceToView(view,kUserImage_left_space)
    .heightIs(40)
    .widthIs(40);
    self.userImageView.sd_cornerRadius = @5;
    
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

}

#pragma mark - Getter
- (UIImageView *)userImageView{
    if (_userImageView == nil) {
        _userImageView = [UIImageView new];
    }
    return _userImageView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont font_14];
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

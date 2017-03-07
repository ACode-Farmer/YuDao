//
//  YDContactsCell.m
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDContactsCell.h"

@interface  YDContactsCell()



@end

@implementation YDContactsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.headerImageView];
        [self.contentView addSubview:self.usernameLabel];
        [self.contentView addSubview:self.redPointView];
        [self.redPointView addSubview:self.remindLabel];
        
        [self y_layoutSubviews];
    }
    return self;
}

#pragma mark - Public Methods
- (void)setModel:(YDFriendModel *)model{
    _model = model;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.friendImage] placeholderImage:[UIImage imageNamed:@"mine_user_placeholder"]];
    self.usernameLabel.text = model.friendName;
    
}

#pragma mark - Prvate Methods 
- (void)y_layoutSubviews{
    UIView *view = self.contentView;
    self.headerImageView.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(view,12)
    .heightIs(36)
    .widthEqualToHeight();
    
    self.usernameLabel.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(self.headerImageView,14)
    .heightIs(21);
    [self.usernameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _redPointView.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView,45)
    .heightIs(20)
    .widthIs(20);
    
    _remindLabel.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
//    _lineView = [UIView new];
//    _lineView.backgroundColor = [UIColor colorWithString:@"#B6C5DC"];
//    _lineView.alpha = 0.5f;
//    [self.contentView addSubview:_lineView];
    
//    _lineView.sd_layout
//    .leftSpaceToView(self.contentView,16)
//    .rightSpaceToView(self.contentView,15)
//    .bottomEqualToView(self.contentView)
//    .heightIs(1);
}

- (void)tapHeaderImageViewAction:(UIGestureRecognizer *)tap{
    
}

/**
 *  标记为未读
 */
- (void) markAsUnreadCount:(NSInteger )count{
    if (_model) {
        _remindLabel.text = [NSString stringWithFormat:@"%ld",count];
        if (count > 0) {
            _redPointView.hidden = NO;
        }else{
            _redPointView.hidden = YES;
        }
    }
}

#pragma mark - Getter
- (UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.userInteractionEnabled = YES;
        _headerImageView.sd_cornerRadiusFromWidthRatio = @0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(tapHeaderImageViewAction:)];
        [_headerImageView addGestureRecognizer:tap];
    }
    return _headerImageView;
}

- (UILabel *)usernameLabel{
    if (!_usernameLabel) {
        _usernameLabel = [YDUIKit labelTextColor:[UIColor colorWithString:@"#2B3552"] fontSize:16];
    }
    return _usernameLabel;
}

- (UIView *)redPointView
{
    if (!_redPointView) {
        _redPointView = [[UIView alloc] init];
        [_redPointView setBackgroundColor:[UIColor redColor]];
        
        [_redPointView.layer setMasksToBounds:YES];
        [_redPointView.layer setCornerRadius:20 / 2.0];
        [_redPointView setHidden:YES];
    }
    return _redPointView;
}

- (UILabel *)remindLabel{
    if (!_remindLabel) {
        _remindLabel = [YDUIKit labelTextColor:[UIColor whiteColor] fontSize:12];
        _remindLabel.text = @"";
        _remindLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _remindLabel;
}

@end

//
//  RankingListCell.m
//  YuDao
//
//  Created by 汪杰 on 16/9/13.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "RankingListCell.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
#import "RankingListModel.h"

@implementation RankingListCell
{
    UILabel *_rankingLabel;
    UIImageView *_userImage;
    UILabel *_userName;
    UILabel *_dataLabel;
    UIButton *_likeBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{
    _rankingLabel = [UILabel new];
    _rankingLabel.textAlignment = NSTextAlignmentCenter;
    _rankingLabel.adjustsFontSizeToFitWidth = YES;
    _rankingLabel.backgroundColor = [UIColor orangeColor];
    
    _userImage = [UIImageView new];
    _userImage.backgroundColor = [UIColor orangeColor];
    
    _userName = [UILabel new];
    _userName.textAlignment = NSTextAlignmentCenter;
    _userName.adjustsFontSizeToFitWidth = YES;
    _userName.backgroundColor = [UIColor orangeColor];
    
    _dataLabel = [UILabel new];
    _dataLabel.textAlignment = NSTextAlignmentCenter;
    _dataLabel.adjustsFontSizeToFitWidth = YES;
    _dataLabel.backgroundColor = [UIColor orangeColor];
    
    _likeBtn = [UIButton new];
    _likeBtn.backgroundColor = [UIColor orangeColor];
    
    UIView *contentView = self.contentView;
    NSArray *views = @[_rankingLabel,_userName,_userImage,_dataLabel,_likeBtn];
    [contentView sd_addSubviews:views];
    CGFloat space = 20.0f;
    
    _rankingLabel.sd_layout
    .centerYEqualToView(contentView)
    .leftSpaceToView(contentView,space)
    .widthRatioToView(contentView,0.15)
    .heightIs(21);
    
    _userImage.sd_layout
    .centerYEqualToView(contentView)
    .leftSpaceToView(_rankingLabel,space)
    .widthRatioToView(contentView,0.15)
    .heightEqualToWidth();
    _userImage.sd_cornerRadiusFromWidthRatio = @0.5;

    _userName.sd_layout
    .centerYEqualToView(contentView)
    .leftSpaceToView(_userImage,space)
    .widthRatioToView(contentView,0.15)
    .heightIs(21);
    
    _dataLabel.sd_layout
    .centerYEqualToView(contentView)
    .leftSpaceToView(_userName,space)
    .widthRatioToView(contentView,0.15)
    .heightIs(21);
    
    _likeBtn.sd_layout
    .centerYEqualToView(contentView)
    .leftSpaceToView(_dataLabel,space)
    .rightSpaceToView(contentView,5)
    .heightIs(21);
    
    [self setupAutoHeightWithBottomViewsArray:views bottomMargin:2];
}

- (void)setModel:(RankingListModel *)model{
    _model = model;
    _rankingLabel.text = model.ranking;
    _userImage.image = [UIImage imageNamed:model.imageName];
    _userName.text = model.name;
    _dataLabel.text = model.data;
    _likeBtn.selected = model.isLike;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  YDAllListCell.m
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDAllListCell.h"

#define kAttentionBtnWidth          17 * widthHeight_ratio
#define kAttentionBtnHeight         23 * widthHeight_ratio
#define kAttentionBtnRightMargin    30 * widthHeight_ratio

@interface YDAllListCell()

//名次
@property (nonatomic, strong) UILabel *placingLabel;
//头像
@property (nonatomic, strong) UIImageView *headerImageView;
//呢称
@property (nonatomic, strong) UILabel *nameLabel;
//数据（在排行榜中会使用到)
@property (nonatomic, strong) UILabel *dataLabel;
//关注按钮
@property (nonatomic, strong) UIButton *attentionBtn;

@end

@implementation YDAllListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *subviews = @[self.placingLabel,self.headerImageView,self.nameLabel,self.dataLabel,self.attentionBtn];
        [self.contentView sd_addSubviews:subviews];
        
        [self y_addAutoLayout];
    }
    return self;
}

- (void)setAllListItem:(YDAllListItem *)allListItem{
    _allListItem = allListItem;
    self.placingLabel.text = allListItem.placing;
    self.headerImageView.image = [UIImage imageNamed:allListItem.imageName];
    self.nameLabel.text = allListItem.name;
    self.dataLabel.text = allListItem.data;
    _attentionBtn.selected = allListItem.isLiked;
}

#pragma mark - Private Methods
- (void)y_addAutoLayout{
    UIView *view = self.contentView;
    
    self.placingLabel.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(view,0)
    .widthIs(68*widthHeight_ratio)
    .heightRatioToView(view,0.5);
    
    self.headerImageView.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(self.placingLabel,22*widthHeight_ratio)
    .widthIs(31*widthHeight_ratio)
    .heightEqualToWidth();
    
    self.nameLabel.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(self.headerImageView,24*widthHeight_ratio)
    .heightRatioToView(view,0.8)
    .widthIs(100*widthHeight_ratio);
    
    self.attentionBtn.sd_layout
    .centerYEqualToView(view)
    .rightSpaceToView(view,kAttentionBtnRightMargin)
    .widthIs(kAttentionBtnWidth)
    .heightEqualToWidth();
    
    self.dataLabel.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(self.nameLabel,14*widthHeight_ratio)
    .rightSpaceToView(self.attentionBtn,5*widthHeight_ratio)
    .heightRatioToView(view,0.8);
    
    [self.attentionBtn addTarget:self action:@selector(attentionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)attentionBtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
}

#pragma mark - Getter
- (UILabel *)placingLabel{
    if (!_placingLabel) {
        _placingLabel = [UILabel new];
        _placingLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _placingLabel;
}

- (UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [UIImageView new];
        _headerImageView.sd_cornerRadiusFromWidthRatio = @0.5;
    }
    return _headerImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UILabel *)dataLabel{
    if (!_dataLabel) {
        _dataLabel = [UILabel new];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dataLabel;
}

- (UIButton *)attentionBtn{
    if (!_attentionBtn) {
        _attentionBtn = [UIButton new];
        [_attentionBtn setImage:[UIImage imageNamed:@"空心"] forState:0];
        [_attentionBtn setImage:[UIImage imageNamed:@"满心"] forState:UIControlStateSelected];
        [_attentionBtn setTitleColor:[UIColor blackColor] forState:0];
    }
    return _attentionBtn;
}

@end

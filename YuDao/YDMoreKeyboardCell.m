//
//  TLMoreKeyboardCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/18.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "YDMoreKeyboardCell.h"
#import "UIImage+Color.h"

@interface YDMoreKeyboardCell()

@property (nonatomic, strong) UIButton *iconButton;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YDMoreKeyboardCell

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.iconButton];
        [self.contentView addSubview:self.titleLabel];
        [self p_addMasonry];
    }
    return self;
}

- (void)setItem:(YDMoreKeyboardItem *)item
{
    _item = item;
    if (item == nil) {
        [self.titleLabel setHidden:YES];
        [self.iconButton setHidden:YES];
        [self setUserInteractionEnabled:NO];
        return;
    }
    [self setUserInteractionEnabled:YES];
    [self.titleLabel setHidden:NO];
    [self.iconButton setHidden:NO];
    [self.titleLabel setText:item.title];
    [self.iconButton setImage:[UIImage imageNamed:item.imagePath] forState:UIControlStateNormal];
}

#pragma mark - Event Response -
- (void)iconButtonDown:(UIButton *)sender
{
    self.clickBlock(self.item);
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    UIView *view = self.contentView;
    self.iconButton.sd_layout
    .topSpaceToView(view,0)
    .centerXEqualToView(view)
    .widthRatioToView(view,1)
    .heightEqualToWidth();
    
    self.titleLabel.sd_layout
    .centerXEqualToView(view)
    .bottomSpaceToView(view,0)
    .topSpaceToView(self.iconButton,0)
    .widthRatioToView(view,1);
}

#pragma mark - Getter -
- (UIButton *)iconButton
{
    if (_iconButton == nil) {
        _iconButton = [[UIButton alloc] init];
        [_iconButton.layer setMasksToBounds:YES];
        [_iconButton.layer setCornerRadius:5.0f];
        [_iconButton.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_iconButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [_iconButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorGrayLine]] forState:UIControlStateHighlighted];
        [_iconButton addTarget:self action:@selector(iconButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconButton;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_titleLabel setTextColor:[UIColor grayColor]];
    }
    return _titleLabel;
}

@end

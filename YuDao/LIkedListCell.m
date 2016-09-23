//
//  LIkedListCell.m
//  YuDao
//
//  Created by 汪杰 on 16/9/23.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "LIkedListCell.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>

@implementation LIkedListCell
{
    UIImageView *_headImageView;
    UILabel     *_nameLabel;
    UILabel     *_gradeLebel;
    UIButton    *_talkBtn;
    UIButton    *_addBtn;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _headImageView = [UIImageView new];
        _nameLabel = [UILabel new];
        _gradeLebel = [UILabel new];
        _gradeLebel.textColor = [UIColor orangeColor];
        _talkBtn = [UIButton new];
        [_talkBtn setImage:[UIImage imageNamed:@"talk"] forState:0];
        _addBtn = [UIButton new];
        [_addBtn setImage:[UIImage imageNamed:@"add"] forState:0];
        [self.contentView sd_addSubviews:@[_headImageView,_nameLabel,_gradeLebel,_talkBtn,_addBtn]];
        
        _headImageView.image = [UIImage imageNamed:@"head0.jpg"];
        _nameLabel.text = @"这些全是喜欢我的";
        _gradeLebel.text = @"V5";
        
        [self setupSubviewsLayout];
    }
    return self;
}

- (void)setupSubviewsLayout{
    UIView *view = self.contentView;
    _headImageView.sd_layout
    .topSpaceToView(view,2)
    .leftSpaceToView(view,5)
    .bottomSpaceToView(view,2)
    .widthEqualToHeight();
    _headImageView.sd_cornerRadius = @10;
    
    _nameLabel.sd_layout
    .topEqualToView(_headImageView)
    .leftSpaceToView(_headImageView,5)
    .bottomEqualToView(_headImageView);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _gradeLebel.sd_layout
    .topEqualToView(_headImageView)
    .leftSpaceToView(_nameLabel,5)
    .bottomEqualToView(_headImageView);
    [_gradeLebel setSingleLineAutoResizeWithMaxWidth:100];
    
    _addBtn.sd_layout
    .centerYEqualToView(view)
    .rightSpaceToView(view,10)
    .widthIs(30)
    .heightEqualToWidth();
    
    _talkBtn.sd_layout
    .centerYEqualToView(view)
    .rightSpaceToView(_addBtn,5)
    .widthIs(30)
    .heightEqualToWidth();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

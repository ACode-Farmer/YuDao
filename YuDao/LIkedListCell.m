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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _headImageView = [UIImageView new];
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont font_16];
        
        _gradeLebel = [UILabel new];
        _gradeLebel.textColor = [UIColor orangeColor];
        _gradeLebel.font = [UIFont font_13];
        
        _talkBtn = [UIButton new];
        _talkBtn.tag = 1000;
        [_talkBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_talkBtn setImage:[UIImage imageNamed:@"mine_chat"] forState:0];
        _addBtn = [UIButton new];
        _addBtn.tag = 10001;
        [_addBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_addBtn setImage:[UIImage imageNamed:@"add"] forState:0];
        [self.contentView sd_addSubviews:@[_headImageView,_nameLabel,_gradeLebel,_talkBtn,_addBtn]];
        
        _headImageView.image = [UIImage imageNamed:@"head0.jpg"];
        _nameLabel.text = @"都是我的";
        _gradeLebel.text = @"V5";
        
        [self setupSubviewsLayout];
    }
    return self;
}

- (void)setupSubviewsLayout{
    UIView *view = self.contentView;
    _headImageView.sd_layout
    .topSpaceToView(view,5)
    .leftSpaceToView(view,10)
    .bottomSpaceToView(view,5)
    .widthEqualToHeight();
    _headImageView.sd_cornerRadiusFromWidthRatio = @0.5;
    
    _nameLabel.sd_layout
    .topEqualToView(_headImageView)
    .leftSpaceToView(_headImageView,10)
    .bottomEqualToView(_headImageView);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _gradeLebel.sd_layout
    .topEqualToView(_headImageView)
    .leftSpaceToView(_nameLabel,10)
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

- (void)buttonAction:(UIButton *)sender{
    NSString *title = nil;
    if (sender.tag == 1000) {
        title = @"非好友，暂时不可会话!";
    }else{
        title = @"好友请求已发送，等待对方回复!";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:title
                                                   delegate:nil
                                          cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
}

@end

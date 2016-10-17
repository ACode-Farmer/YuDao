//
//  YDPTimeAxisCell.m
//  YuDao
//
//  Created by 汪杰 on 16/10/17.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDPTimeAxisCell.h"

@implementation YDPTimeAxisCell
{
    UILabel *_timeLabel;
    UIView *_lineView;
    UILabel *_nameLabel;
    UILabel *_contentLabel;
    SDWeiXinPhotoContainerView *_picContainerView;
    UIButton *_likeBtn;
    UIButton *_commentBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _timeLabel = [UILabel new];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.adjustsFontSizeToFitWidth = YES;
        
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorGrayBG];
        
        _nameLabel = [UILabel new];
        
        _contentLabel = [UILabel new];
        _contentLabel.numberOfLines = 0;
        
        _picContainerView = [SDWeiXinPhotoContainerView new];
        
        _likeBtn = [UIButton new];
        [_likeBtn setTitleColor:[UIColor blackColor] forState:0];
        [_likeBtn setImage:[UIImage imageNamed:@"add"] forState:0];
        
        _commentBtn = [UIButton new];
        [_commentBtn setTitleColor:[UIColor blackColor] forState:0];
        [_commentBtn setImage:[UIImage imageNamed:@"add"] forState:0];
        
        [self y_layoutSubviews];
        
    }
    return self;
}

- (void)y_layoutSubviews{
    UIView *view = self.contentView;
    [view sd_addSubviews:@[_timeLabel,_lineView,_nameLabel,_contentLabel,_picContainerView,_likeBtn,_commentBtn]];
    CGFloat margin = 10;
    
    _lineView.sd_layout
    .topSpaceToView(view,0)
    .leftSpaceToView(view,70*widthHeight_ratio)
    .bottomSpaceToView(view,0)
    .widthIs(1);
    
    _nameLabel.sd_layout
    .topSpaceToView(view,margin)
    .leftSpaceToView(_lineView,margin)
    .rightSpaceToView(view,margin)
    .heightIs(21);
    
    _contentLabel.sd_layout
    .topSpaceToView(_nameLabel,margin)
    .leftEqualToView(_nameLabel)
    .rightEqualToView(_nameLabel)
    .autoHeightRatio(0);
    
    _picContainerView.sd_layout.leftEqualToView(_contentLabel);
    
    UIView *dotView = [UIView new];
    dotView.backgroundColor = [UIColor blackColor];
    [view addSubview:dotView];
    dotView.sd_layout
    .centerYEqualToView(_contentLabel)
    .centerXEqualToView(_lineView)
    .widthIs(5)
    .heightEqualToWidth();
    dotView.sd_cornerRadiusFromHeightRatio = @0.5;
    
    _timeLabel.sd_layout
    .rightSpaceToView(dotView,2)
    .centerYEqualToView(dotView)
    .leftSpaceToView(view,0)
    .heightIs(21);
    
    _commentBtn.sd_layout
    .topSpaceToView(_picContainerView,margin)
    .rightSpaceToView(view,5)
    .widthIs(60)
    .heightIs(40);
    
    _likeBtn.sd_layout
    .topEqualToView(_commentBtn)
    .rightSpaceToView(_commentBtn,margin)
    .widthIs(60)
    .heightIs(40);
}

- (void)setModel:(YDPTimeAxisModel *)model{
    _model = model;
    _timeLabel.text = model.time;
    _nameLabel.text = model.name;
    _contentLabel.text = model.content;
    _picContainerView.picPathStringsArray = model.picArray;
    [_likeBtn setTitle:model.likeBtnTitle forState:0];
    [_commentBtn setTitle:model.commentBtnTitle forState:0];
    
    CGFloat picContainerTopMargin = 0;
    if (model.picArray.count) {
        picContainerTopMargin = 10;
    }
    _picContainerView.sd_layout.topSpaceToView(_contentLabel,picContainerTopMargin);
    
    [self setupAutoHeightWithBottomView:_commentBtn bottomMargin:10];
}

@end

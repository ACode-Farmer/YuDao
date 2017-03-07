//
//  YDBindOBDCell.m
//  YuDao
//
//  Created by 汪杰 on 16/11/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDBindOBDCell.h"

@implementation YDBindOBDCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        
        [self y_layoutSubviews];
    }
    return self;
}

- (void)setModel:(YDBindOBDModel *)model{
    _model = model;
    _titleLabel.text = model.title;
    _textF.placeholder = model.placeholder;
    if (model.imageString.length > 0) {
        [_chooseBtn setImage:[UIImage imageNamed:model.imageString] imageHL:[UIImage imageNamed:model.imageString]];
        _chooseBtn.enabled = YES;
    }
    //如果是第一行，textField不可操作
    if ([model.title isEqualToString:@"选择车辆"]) {
        _textF.enabled = NO;
        if ([model.placeholder isEqualToString:@"请选择已有车辆或绑定新车辆"]) {
            _textF.placeholder = model.placeholder;
        }else{
            _textF.text = model.placeholder;
        }
    }
    
}

- (void)y_layoutSubviews{
    UIView *view = self.contentView;
    [view sd_addSubviews:@[self.titleLabel,self.textF,self.chooseBtn,self.lineView]];
    _titleLabel.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(view,12)
    .heightRatioToView(view,1)
    .widthIs(80);
    
    _chooseBtn.sd_layout
    .centerYEqualToView(view)
    .rightSpaceToView(view,27)
    .heightIs(25)
    .widthIs(25);
    
    _textF.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(_titleLabel,50)
    .rightSpaceToView(_chooseBtn,16)
    .heightRatioToView(view,0.8);
    
    _lineView.sd_layout
    .bottomEqualToView(view)
    .heightIs(1);
}

- (void)bindCellChooseBtnAction:(UIButton *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(bindOBDCell:didTouchChooseButton:)]) {
        [self.delegate bindOBDCell:self didTouchChooseButton:sender];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder]; //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [YDUIKit labelTextColor:[UIColor colorWithString:@"#999999"] fontSize:14];
    }
    return _titleLabel;
}

- (UITextField *)textF{
    if (!_textF) {
        _textF = [UITextField new];
        _textF.textAlignment = NSTextAlignmentCenter;
        _textF.font = [UIFont fontWithName:@"Arial" size:14.0f];
        _textF.delegate = self;
        _textF.returnKeyType = UIReturnKeyDone;
    }
    return _textF;
}

- (UIButton *)chooseBtn{
    if (!_chooseBtn) {
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chooseBtn addTarget:self action:@selector(bindCellChooseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseBtn;
}


- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithString:@"#B6C5DC"];
    }
    return _lineView;
}

@end

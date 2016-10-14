//
//  YDGarageCell.m
//  YuDao
//
//  Created by 汪杰 on 16/10/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDGarageCell.h"
#import "YDGarageModel.h"

@implementation YDGarageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorGrayBG];
        [self.contentView sd_addSubviews:@[self.carImageView,self.carName,self.identifierBtn,self.carModel,self.checkBtn]];
        [self y_layoutSubviews];
    }
    return self;
}


- (void)y_layoutSubviews{
    UIView *view = self.contentView;
    self.carImageView.sd_layout
    .topSpaceToView(view,25*widthHeight_ratio)
    .leftSpaceToView(view,30*widthHeight_ratio)
    .heightRatioToView(view,0.5)
    .widthEqualToHeight();
    self.carImageView.sd_cornerRadius = @5;
    
    self.carName.sd_layout
    .topEqualToView(self.carImageView)
    .leftSpaceToView(self.carImageView,11*widthHeight_ratio)
    .heightRatioToView(self.carImageView,0.5);
    [self.carName setSingleLineAutoResizeWithMaxWidth:150];
    
    self.identifierBtn.sd_layout
    .topEqualToView(self.carName)
    .leftSpaceToView(self.carName,5)
    .heightRatioToView(self.carName,1)
    .widthIs(100);
    
    self.carModel.sd_layout
    .bottomEqualToView(self.carImageView)
    .leftEqualToView(self.carName)
    .heightRatioToView(self.carImageView,0.5)
    .rightSpaceToView(view,2);
    
    self.checkBtn.sd_layout
    .topSpaceToView(self.carImageView,20)
    .centerXEqualToView(view)
    .heightIs(38*widthHeight_ratio)
    .widthRatioToView(view,1);
}

#pragma mark - Events
- (void)identifierBtnOrCheckBtnAction:(UIButton *)sender{
    NSLog(@"title = %@",sender.titleLabel.text);
    if (self.delegate && [self.delegate respondsToSelector:@selector(garageCellWithTitle:)]) {
        [self.delegate garageCellWithTitle:sender.titleLabel.text];
    }
}

#pragma mark - Setter
- (void)setModel:(YDGarageModel *)model{
    _model = model;
    self.carImageView.image = [UIImage imageNamed:model.carImageName];
    self.carName.text = model.carname;
    if (model.isIdentified) {
        [self.identifierBtn setTitle:@"已认证" forState:0];
        [self.identifierBtn setTitleColor:[UIColor orangeColor] forState:0];
    }else{
        [self.identifierBtn setTitle:@"未认证" forState:0];
        [self.identifierBtn setTitleColor:[UIColor redColor] forState:0];
    }
    self.carModel.text = model.carModel;
    [self.checkBtn setTitle:model.checkTitle forState:0];
}

#pragma mark - Getters
- (UIImageView *)carImageView{
    if (!_carImageView) {
        _carImageView = [UIImageView new];
    }
    return _carImageView;
}

- (UILabel *)carName{
    if (!_carName) {
        _carName = [UILabel new];
    }
    return _carName;
}

- (UIButton *)identifierBtn{
    if (!_identifierBtn) {
        _identifierBtn = [UIButton new];
        [_identifierBtn setTitleColor:[UIColor orangeColor] forState:0];
        [_identifierBtn addTarget:self action:@selector(identifierBtnOrCheckBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_identifierBtn.titleLabel setFont:[UIFont font_13]];
        [_identifierBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _identifierBtn;
}

- (UILabel *)carModel{
    if (!_carModel) {
        _carModel = [UILabel new];
        [_carModel setFont:[UIFont font_13]];
    }
    return _carModel;
}

- (UIButton *)checkBtn{
    if (!_checkBtn) {
        _checkBtn = [UIButton new];
        [_checkBtn setTitleColor:[UIColor blackColor] forState:0];
        _checkBtn.backgroundColor = [UIColor whiteColor];
        [_checkBtn addTarget:self action:@selector(identifierBtnOrCheckBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBtn;
}

@end

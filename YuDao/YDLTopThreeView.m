//
//  YDLTopThreeVIew.m
//  YuDao
//
//  Created by 汪杰 on 16/10/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDLTopThreeView.h"
#import "ListViewModel.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>

//大视图宽高
#define kCenterViewWidth  160 * widthHeight_ratio
#define kCenterViewHeight 188 * widthHeight_ratio
#define kSideViewWidth    113 * widthHeight_ratio
#define kSideViewHeight   180 * widthHeight_ratio


//小视图宽高
#define kImageViewWidth      78 * widthHeight_ratio
#define kImageViewHeight     90 * widthHeight_ratio
#define kSmallBtnWidth       32 * widthHeight_ratio
#define kSmallBtnHeight      22 * widthHeight_ratio
#define kAttentionBtnWidth   98 * widthHeight_ratio
#define kAttentionBtnHeight  26 * widthHeight_ratio

//间隔
#define kTopThreeViewMargin 8 * widthHeight_ratio

@implementation YDLTopThreeView
{
    NSArray *_modelArray;
    UIView  *_leftView;
    UIView  *_centerView;
    UIView  *_rightView;
}
- (instancetype)initWithModelArray:(NSArray *)array{
    if (self = [super init]) {
        _modelArray = [array copy];
        [self addCommonView];
    }
    return self;
}

- (void)addCommonView{
    NSMutableArray *views = [NSMutableArray arrayWithCapacity:_modelArray.count];
    [_modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ListViewModel *model = (ListViewModel *)obj;
        UIView *view = [self commonViewWithModel:model];
        [self addSubview:view];
        [views addObject:view];
        view.sd_cornerRadius = @5;
    }];
    
    _leftView = views[0];
    _centerView = views[1];
    _rightView = views[2];
    
    _centerView.sd_layout
    .centerXEqualToView(self)
    .centerYEqualToView(self)
    .widthIs(kCenterViewWidth)
    .heightIs(kCenterViewHeight);
    
    _leftView.sd_layout
    .centerYEqualToView(self)
    .rightSpaceToView(_centerView,kTopThreeViewMargin)
    .widthIs(kSideViewWidth)
    .heightIs(kSideViewHeight);
    
    _rightView.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(_centerView,kTopThreeViewMargin)
    .widthIs(kSideViewWidth)
    .heightIs(kSideViewHeight);
}

- (UIView *)commonViewWithModel:(ListViewModel *)model{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:model.imageName]];
    [view addSubview:imageView];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = model.name;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:nameLabel];
    
    UILabel *gradeLabel = [UILabel new];
    gradeLabel.text = model.grade;
    
    UILabel *signLabel = [UILabel new];
    signLabel.text = model.sign;
    
    UILabel *typeLabel = [UILabel new];
    typeLabel.text = model.type;
    
    UIButton *attentionBtn = [UIButton new];
    [attentionBtn setTitleColor:[UIColor blackColor] forState:0];
    attentionBtn.backgroundColor = [UIColor yellowColor];
    [attentionBtn.layer setCornerRadius:5];
    attentionBtn.layer.masksToBounds = YES;
    attentionBtn.layer.borderWidth = 1.0f;
    attentionBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [attentionBtn addTarget:self action:@selector(attentionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    if (model.isAttention) {
        [attentionBtn setTitle:@"已关注" forState:0];
    }else{
        [attentionBtn setTitle:@"关注" forState:0];
    }
    [view addSubview:attentionBtn];
    
    NSArray *btns = @[gradeLabel,signLabel,typeLabel];
    [btns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = (UILabel *)obj;
        label.backgroundColor = [UIColor yellowColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [label.layer setCornerRadius:5];
        label.layer.masksToBounds = YES;
        label.layer.borderWidth = 1.0f;
        label.layer.borderColor = [UIColor blackColor].CGColor;
        [view addSubview:label];
    }];
    
    imageView.sd_layout
    .centerXEqualToView(view)
    .topSpaceToView(view,2)
    .heightIs(kImageViewWidth)
    .widthIs(kImageViewHeight);
    
    nameLabel.sd_layout
    .centerXEqualToView(view)
    .topSpaceToView(imageView,8*widthHeight_ratio)
    .heightIs(21)
    .widthRatioToView(view,0.8);
    
    signLabel.sd_layout
    .centerXEqualToView(view)
    .topSpaceToView(nameLabel,6*widthHeight_ratio)
    .widthIs(kSmallBtnWidth)
    .heightIs(kSmallBtnHeight);
    
    gradeLabel.sd_layout
    .topEqualToView(signLabel)
    .rightSpaceToView(signLabel,4*widthHeight_ratio)
    .widthIs(kSmallBtnWidth)
    .heightIs(kSmallBtnHeight);
    
    typeLabel.sd_layout
    .topEqualToView(signLabel)
    .leftSpaceToView(signLabel,4*widthHeight_ratio)
    .widthIs(kSmallBtnWidth)
    .heightIs(kSmallBtnHeight);
    
    attentionBtn.sd_layout
    .centerXEqualToView(view)
    .topSpaceToView(signLabel,6*widthHeight_ratio)
    .widthRatioToView(view,0.8)
    .heightIs(kAttentionBtnHeight);
    
    
    return view;
}

- (void)attentionBtnAction:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"关注"]) {
        [sender setTitle:@"已关注" forState:0];
    }else{
        [sender setTitle:@"关注" forState:0];
    }
}

@end

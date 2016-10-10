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
    
    UIButton *gradeBtn = [UIButton new];
    [gradeBtn setTitle:model.grade forState:0];
    
    UIButton *signBtn = [UIButton new];
    signBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [signBtn setTitle:model.sign forState:0];
    
    UIButton *typeBtn = [UIButton new];
    [typeBtn setTitle:model.type forState:0];
    
    UIButton *attentionBtn = [UIButton new];
    [attentionBtn addTarget:self action:@selector(attentionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    if (model.isAttention) {
        [attentionBtn setTitle:@"已关注" forState:0];
    }else{
        [attentionBtn setTitle:@"关注" forState:0];
    }
    
    NSArray *btns = @[gradeBtn,signBtn,typeBtn,attentionBtn];
    [btns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)obj;
        [btn setTitleColor:[UIColor blackColor] forState:0];
        btn.backgroundColor = [UIColor yellowColor];
        [btn.layer setCornerRadius:5];
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 1.0f;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        [view addSubview:btn];
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
    
    signBtn.sd_layout
    .centerXEqualToView(view)
    .topSpaceToView(nameLabel,6*widthHeight_ratio)
    .widthIs(kSmallBtnWidth)
    .heightIs(kSmallBtnHeight);
    
    gradeBtn.sd_layout
    .topEqualToView(signBtn)
    .rightSpaceToView(signBtn,4*widthHeight_ratio)
    .widthIs(kSmallBtnWidth)
    .heightIs(kSmallBtnHeight);
    
    typeBtn.sd_layout
    .topEqualToView(signBtn)
    .leftSpaceToView(signBtn,4*widthHeight_ratio)
    .widthIs(kSmallBtnWidth)
    .heightIs(kSmallBtnHeight);
    
    attentionBtn.sd_layout
    .centerXEqualToView(view)
    .topSpaceToView(signBtn,6*widthHeight_ratio)
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

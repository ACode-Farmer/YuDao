//
//  YDLTopThreeVIew.m
//  YuDao
//
//  Created by 汪杰 on 16/10/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDLTopThreeVIew.h"
#import "ListViewModel.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>

//空间宽高
#define kImageViewWidth  78 * widthHeight_ratio
#define kImageViewHeight 90 * widthHeight_ratio
#define kSmallBtnWidth   32 * widthHeight_ratio
#define kSmallBtnHeight  22 * widthHeight_ratio
#define kAttentionBtnWidth   98 * widthHeight_ratio
#define kAttentionBtnHeight  26 * widthHeight_ratio


@implementation YDLTopThreeVIew
{
    NSArray *_modelArray;
}
- (instancetype)initWithModelArray:(NSArray *)array{
    if (self = [super init]) {
        _modelArray = [array copy];
        [_modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
        }];
    }
    return self;
}

- (UIView *)commonViewWithModel:(ListViewModel *)model{
    UIView *view = [UIView new];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:model.imageName]];
    [view addSubview:imageView];
    
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = model.name;
    [view addSubview:nameLabel];
    
    UIButton *gradeBtn = [UIButton new];
    [gradeBtn setTitle:model.grade forState:0];
    
    UIButton *signBtn = [UIButton new];
    [signBtn setTitle:model.sign forState:0];
    
    UIButton *typeBtn = [UIButton new];
    [typeBtn setTitle:model.type forState:0];
    
    UIButton *attentionBtn = [UIButton new];
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

@end

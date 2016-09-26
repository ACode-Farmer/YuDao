//
//  LocationView.m
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "LocationView.h"
#import "UIButton+ImageTitleSpacing.h"
@implementation LocationView
{
    UIButton *_userLocatioinBtn;
    UIButton *_distanceBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews:frame];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setupSubViews:(CGRect )frame{
    CGSize size = frame.size;
    CGFloat space = 5.0f;
    _userLocatioinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _userLocatioinBtn.frame = CGRectMake(screen_width/5, 2, 110, size.height - 4);
    [_userLocatioinBtn setTitle:@"金沙江路" forState:0];
    
    _distanceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _distanceBtn.frame = CGRectMake(3*screen_width/5, 2, 110, size.height - 4);
    [_distanceBtn setTitle:@"10m" forState:UIControlStateNormal];
    
    NSArray *subViews = @[_userLocatioinBtn,_distanceBtn];
    for (UIButton *btn in subViews) {
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setImage:[UIImage imageNamed:@"set"] forState:0];
        [btn setImage:[UIImage imageNamed:@"set"] forState:1];
        [self addSubview:btn];
    }
    [_userLocatioinBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:space];
    [_distanceBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:space];
}

- (void)setModel:(LocationModel *)model{
    _model = model;
}

@end

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
    [_userLocatioinBtn.titleLabel setFont:[UIFont font_15]];
    [_userLocatioinBtn setImage:[UIImage imageNamed:@"homepage-image-location-normal"] forState:0];
    [_userLocatioinBtn setImage:[UIImage imageNamed:@"homepage-image-location-normal"] forState:1];
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(_userLocatioinBtn.frame.origin.x+3, CGRectGetMaxY(_userLocatioinBtn.frame)-5, _userLocatioinBtn.bounds.size.width, 1)];
    lineView.image = [UIImage imageNamed:@"homepage-botton-location-normal"];
    [self addSubview:lineView];
    
    _distanceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _distanceBtn.frame = CGRectMake(CGRectGetMaxX(_userLocatioinBtn.frame)+30, 2, 110, size.height - 4);
    [_distanceBtn setTitle:@"车距我：1KM" forState:UIControlStateNormal];
    [_distanceBtn.titleLabel setFont:[UIFont font_15]];
    
    NSArray *subViews = @[_userLocatioinBtn,_distanceBtn];
    for (UIButton *btn in subViews) {
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:[UIColor colorWithString:@"#7147a0"] forState:0];
        [self addSubview:btn];
    }
    [_userLocatioinBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:space];
    [_distanceBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:space];
}

- (void)setModel:(LocationModel *)model{
    _model = model;
}

@end

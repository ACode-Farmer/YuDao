//
//  LocationView.m
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "LocationView.h"
#import "LocationButton.h"
@implementation LocationView
{
    LocationButton *_userLocatioinBtn;
    UIButton *_carNumberBtn;
    UIButton *_distanceBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews:frame];
    }
    return self;
}

- (void)setupSubViews:(CGRect )frame{
    CGSize size = frame.size;
    _userLocatioinBtn = [LocationButton buttonWithFrame:CGRectMake(5, 2, 80, size.height - 4)];
    //_userLocatioinBtn.frame = CGRectMake(5, 2, 80, size.height - 4);
    
    _carNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _carNumberBtn.frame = CGRectMake(size.width/2 - 40, 2, 80, size.height - 4);
    
    _distanceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _distanceBtn.frame = CGRectMake(size.width - 85, 2, 80, size.height - 4);
    
    NSArray *subViews = @[_userLocatioinBtn,_carNumberBtn,_distanceBtn];
    for (UIButton *btn in subViews) {
        btn.backgroundColor = [UIColor whiteColor];
        [self addSubview:btn];
    }
}

- (void)setModel:(LocationModel *)model{
    _model = model;
}

@end

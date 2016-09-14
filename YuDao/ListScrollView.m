//
//  ListScrollView.m
//  YuDao
//
//  Created by 汪杰 on 16/9/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "ListScrollView.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>

@implementation ListScrollView
{
    UIView *_view1;
    UIView *_view2;
    UIView *_view3;
    UIView *_view4;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentSize = CGSizeMake(4*screen_width, 300);
        self.backgroundColor = [UIColor whiteColor];
        self.directionalLockEnabled = YES;
        self.pagingEnabled = YES;
        //self.showsHorizontalScrollIndicator = NO;
        //self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)setupSubviews{
    _view1 = [UIView new];
    _view1.backgroundColor = [UIColor orangeColor];
    _view2 = [UIView new];
    _view2.backgroundColor = [UIColor blueColor];
    _view3 = [UIView new];
    _view3.backgroundColor = [UIColor blackColor];
    _view4 = [UIView new];
    _view4.backgroundColor = [UIColor whiteColor];
    _view1.frame = CGRectMake(0, 0, screen_width, 300);
    _view2.frame = CGRectMake(screen_width, 0, screen_width, 300);
    _view3.frame = CGRectMake(2*screen_width, 0, screen_width, 300);
    _view4.frame = CGRectMake(3*screen_width, 0, screen_width, 300);
    
    //NSArray *subviews = @[_view1,_view2,_view3,_view4];
    [self addSubview:_view2];
//    CGRect frame = self.frame;
//    for (NSInteger i = 0; i < subviews.count; i++) {
//        CGRect subFrame = CGRectMake(i * screen_width, 0, screen_width, 300);
//        UIView *view = subviews[i];
//        view.frame = subFrame;
//        [self addSubview:view];
//    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  SignInView.m
//  JiaPlus
//
//  Created by 汪杰 on 16/8/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "SignInView.h"

@implementation SignInView
{
    UIImageView *_imageView;
    UILabel *_label;
    
}

- (instancetype)initWithFrame:(CGRect)frame backColor:(UIColor *)color images:(NSMutableArray *)images animationDuration:(NSTimeInterval )animationDuration labelString:(NSString *)string{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        self.alpha = 0;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        CALayer *grayLayer = [[CALayer alloc] init];
        grayLayer.backgroundColor = [color colorWithAlphaComponent:0.2].CGColor;
        [self.layer addSublayer:grayLayer];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 55) / 2, 30, 50, 50)];
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.animationImages = images;
        _imageView.animationDuration = animationDuration;
        [_imageView startAnimating];
        
        [self addSubview:_imageView];
        self.transform = CGAffineTransformScale(self.transform, 0.1, 0.1);
        
        _label = [[UILabel alloc] init];
        _label.frame = CGRectMake(0, 0, 120, 40);
        _label.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.width-50);
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor clearColor];
        _label.text = @"已签到15天";
        
        [self addSubview:_label];
    }
    return self;
}

- (void)startanimation{
    [UIView animateWithDuration:0.5 animations:^{
        self.transform =  CGAffineTransformIdentity;
        self.alpha = 1;
    } completion:^(BOOL finished) {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
           [UIView animateWithDuration:0.5 animations:^{
              self.transform = CGAffineTransformScale(self.transform, 0.1, 0.1);
               self.alpha = 0;
           } completion:^(BOOL finished) {
               [self removeFromSuperview];
           }];
        });
//        [UIView animateWithDuration:1 animations:^{
//            self.transform = CGAffineTransformScale(self.transform, 0.0, 0.0);
//            //self.alpha = 0;
//        } completion:^(BOOL finished) {
//            [self removeFromSuperview];
//        }];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

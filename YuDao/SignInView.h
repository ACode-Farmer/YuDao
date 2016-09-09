//
//  SignInView.h
//  JiaPlus
//
//  Created by 汪杰 on 16/8/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInView : UIView

- (instancetype)initWithFrame:(CGRect)frame backColor:(UIColor *)color images:(NSMutableArray *)images animationDuration:(NSTimeInterval )animationDuration labelString:(NSString *)string;

- (void)startanimation;

@end

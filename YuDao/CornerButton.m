//
//  CornerButton.m
//  YuDao
//
//  Created by 汪杰 on 16/9/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "CornerButton.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>


@implementation CornerButton

+ (instancetype)circularButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)color cornerRadius:(CGFloat) cornerRadius{
    CornerButton *btn = [self buttonWithType:0];
    
    [btn setTitle:title forState:0];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    [btn setTitleColor:[UIColor blackColor] forState:1];
    [btn setBackgroundColor:color];
    btn.layer.cornerRadius = cornerRadius;
    btn.layer.masksToBounds = YES;
    
    return btn;
}

+ (instancetype)circularButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)color{
    CornerButton *btn = [self buttonWithType:0];
    
    [btn setTitle:title forState:0];
    [btn setTitleColor:[UIColor colorWithString:@"#784ea4"] forState:0];
    [btn setTitleColor:[UIColor colorWithString:@"#784ea4"] forState:1];
    [btn setBackgroundColor:color];
    btn.layer.cornerRadius = btn.bounds.size.width/2;
    
    return btn;
}

+ (instancetype)circularButtonWithImageName:(NSString *)imageName{
    CornerButton *btn = [self buttonWithType:0];
    
    [btn setImage:[UIImage imageNamed:imageName] forState:0];
    [btn setImage:[UIImage imageNamed:imageName] forState:1];
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.sd_cornerRadiusFromWidthRatio = @0.5;
    btn.layer.masksToBounds = YES;
    
    return btn;
}

+ (instancetype)circularButtonWithImageName:(NSString *)imageName borderWidth:(CGFloat )borderWidth{
    CornerButton *btn = [self buttonWithType:0];
    
    [btn setImage:[UIImage imageNamed:imageName] forState:0];
    [btn setImage:[UIImage imageNamed:imageName] forState:1];
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.sd_cornerRadiusFromWidthRatio = @0.5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.layer.borderWidth = borderWidth;
    
    return btn;
}

+ (instancetype)normalButtonWithTitle:(NSString *)title
                            imageName:(NSString *)imageName
                MKButtonEdgeInsetsStyle:(MKButtonEdgeInsetsStyle )style{
    CornerButton *btn = [self buttonWithType:0];
    
    [btn setTitle:title forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [btn setImage:[UIImage imageNamed:imageName] forState:0];
    [btn setImage:[UIImage imageNamed:imageName] forState:1];
    [btn setBackgroundColor:[UIColor orangeColor]];
    btn.imageView.backgroundColor = [UIColor whiteColor];
    
    [btn layoutButtonWithEdgeInsetsStyle:style imageTitleSpace:2.f];
    
    return btn;
}


@end

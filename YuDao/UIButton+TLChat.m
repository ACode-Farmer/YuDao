//
//  UIButton+TLChat.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "UIButton+TLChat.h"

@implementation UIButton (TLChat)

- (void) setImage:(UIImage *)image imageHL:(UIImage *)imageHL
{
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:imageHL forState:UIControlStateHighlighted];
}

- (void) setImage:(UIImage *)image imageSelected:(UIImage *)imageSelected{
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:imageSelected forState:UIControlStateSelected];
}

- (void) setBackgorudImage:(UIImage *)image imageSelected:(UIImage *)imageSelected{
    
    [self setBackgroundImage:image forState:UIControlStateNormal];
    [self setBackgroundImage:imageSelected forState:UIControlStateSelected];
}
@end

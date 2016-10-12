//
//  UIView+Gesture.m
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "UIView+Gesture.h"

NSMutableArray *textFs = nil;

@implementation UIView (Gesture)

- (void)addTapGestureToTextField:(UITextField *)textF{
    if (textFs == nil) {
        NSLog(@"123");
        textFs = [NSMutableArray arrayWithCapacity:5];
    }
    [textFs addObject:textF];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard:)];
    [self addGestureRecognizer:tap];
}

- (void)hiddenKeyboard:(UIGestureRecognizer *)tap{
    [textFs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITextField *textField = (UITextField *)obj;
        [textField resignFirstResponder];
    }];
}

@end

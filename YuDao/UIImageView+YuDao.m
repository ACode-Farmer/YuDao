//
//  UIImageView+YuDao.m
//  YuDao
//
//  Created by 汪杰 on 16/10/13.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "UIImageView+YuDao.h"

@implementation UIImageView (YuDao)

- (void)setCircularImageView{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.bounds.size.width/2] addClip];
    [self drawRect:self.bounds];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束
    UIGraphicsEndImageContext();
}

@end

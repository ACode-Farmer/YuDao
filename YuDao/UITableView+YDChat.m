//
//  UITableView+YDChat.m
//  YuDao
//
//  Created by 汪杰 on 16/10/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "UITableView+YDChat.h"

@implementation UITableView (YDChat)

- (void)scrollToBottomWithAnimation:(BOOL)animation
{
    CGFloat offsetY = self.contentSize.height > self.height ? self.contentSize.height - self.height : -(44 + 20);
    [self setContentOffset:CGPointMake(0, offsetY) animated:animation];
}

@end

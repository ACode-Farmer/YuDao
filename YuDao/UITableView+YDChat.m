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
    //NSLog(@"scrollToBottomWithAnimation");
    CGFloat offsetY = self.contentSize.height > self.height ? self.contentSize.height - self.height : -(height_navBar + height_statusBar);
    [self setContentOffset:CGPointMake(0, offsetY) animated:animation];
}

@end

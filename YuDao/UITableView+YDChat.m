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
//    NSLog(@"self.contentSize.height = %f  self.height = %f",self.contentSize.height,self.height);
//    CGFloat offsetY = self.contentSize.height > self.height ? self.contentSize.height - self.height : -(height_navBar + height_statusBar);
    
    if (self.contentSize.height < self.height) {
        return;
    }else{
        [self setContentOffset:CGPointMake(0,self.contentSize.height - self.height) animated:animation];
    }
    
}

@end

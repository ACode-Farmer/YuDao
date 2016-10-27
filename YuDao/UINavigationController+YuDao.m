//
//  UINavigationController+YuDao.m
//  YuDao
//
//  Created by 汪杰 on 16/10/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "UINavigationController+YuDao.h"

@implementation UINavigationController (YuDao)

- (void)firstLevel_push_fromViewController:(UIViewController *)fromVC toVC:(UIViewController *)toVC{
    
    [fromVC setHidesBottomBarWhenPushed:YES];
    [fromVC.navigationController pushViewController:toVC animated:YES];
    [fromVC setHidesBottomBarWhenPushed:NO];
}


- (void)secondLevel_push_fromViewController:(UIViewController *)fromVC toVC:(UIViewController *)toVC{
    [fromVC setHidesBottomBarWhenPushed:YES];
    [fromVC.navigationController pushViewController:toVC animated:YES];
}

@end

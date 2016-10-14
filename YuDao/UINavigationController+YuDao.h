//
//  UINavigationController+YuDao.h
//  YuDao
//
//  Created by 汪杰 on 16/10/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (YuDao)
/**
 *  push界面，返回时显示tabbar
 *
 *  @param fromVC 一级界面
 *  @param toVC   二级界面
 */
- (void)firstLevel_push_fromViewController:(UIViewController *)fromVC toVC:(UIViewController *)toVC;


/**
 *  push界面，返回时隐藏tabbar
 *
 *  @param fromVC 二级界面
 *  @param toVC   三级界面
 */
- (void)secondLevel_push_fromViewController:(UIViewController *)fromVC toVC:(UIViewController *)toVC;

@end

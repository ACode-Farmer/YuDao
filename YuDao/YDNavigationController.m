//
//  YDNavigationController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDNavigationController.h"

@interface YDNavigationController ()

@end

@implementation YDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.navigationBar setBarTintColor:[UIColor whiteColor]];
    //[self.navigationBar setTintColor:[UIColor whiteColor]];
    UINavigationBar *bar=[UINavigationBar appearance];
//    [bar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationBar_backImage"]]];

    UIImage *image = [UIImage imageNamed:@"navigationBar_backImage"];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    bar.barStyle = UIStatusBarStyleDefault;
//    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontNavBarTitle]}];
}


@end

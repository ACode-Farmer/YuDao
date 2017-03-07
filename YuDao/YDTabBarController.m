//
//  YDTabBarController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTabBarController.h"

@interface YDTabBarController ()

@end

@implementation YDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setTintColor:[UIColor colorWithString:@"#2B3552"]];
    self.tabBar.barTintColor = [UIColor whiteColor];
}
-(UIStatusBarStyle)preferredStatusBarStyle

{
    
    return UIStatusBarStyleLightContent;  //默认的值是黑色的
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

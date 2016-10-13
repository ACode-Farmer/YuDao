//
//  RootViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createVC:(UIViewController *)vc Title:(NSString *)title imageName:(NSString *)imageName
{
    vc.title = title;
    
    self.tabBar.tintColor = [UIColor colorWithRed:68/255.0 green:173/255.0 blue:159/255.0 alpha:1];
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    NSString *imageSelect = [NSString stringWithFormat:@"%@_selected",imageName];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageSelect] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

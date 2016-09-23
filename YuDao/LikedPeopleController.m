//
//  LikedPeopleController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/23.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "LikedPeopleController.h"
#import "ContainerController.h"
#import "LikedListController.h"

@interface LikedPeopleController ()<ContainerControllerDelegate>

@end

@implementation LikedPeopleController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"喜欢的人";
    self.view.backgroundColor = [UIColor whiteColor];
    
    LikedListController *one = [LikedListController new];
    one.title = @"喜欢我的";
    LikedListController *two = [LikedListController new];
    two.title = @"我喜欢的";
    LikedListController *three = [LikedListController new];
    three.title = @"互相喜欢";
    
    // ContainerView
//    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
//    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    ContainerController *containerVC = [[ContainerController alloc]initWithControllers:@[one,two,three]
                                                                          topBarHeight:64
                                                                      parentController:self];
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont fontWithName:@"Futura-Medium" size:16];
    containerVC.menuBackgroudColor = [UIColor whiteColor];
    containerVC.menuItemTitleColor = [UIColor blackColor];
    containerVC.menuItemSelectedTitleColor = [UIColor orangeColor];
    
    [self.view addSubview:containerVC.view];
    
}


#pragma mark -- YSLContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

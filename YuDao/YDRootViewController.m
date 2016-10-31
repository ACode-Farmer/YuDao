//
//  YDRootViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDRootViewController.h"
#import "YDNavigationController.h"

#import "YDMainViewController.h"
#import "DiscoverTableViewController.h"
#import "YDServiceViewController.h"
#import "MyselfController.h"
#import "YDChatViewController.h"
#import "YDFriendsViewController.h"

static YDRootViewController *rootVC = nil;

@interface YDRootViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) NSArray *childVCArray;

@property (nonatomic, strong) YDMainViewController *mainVC;
@property (nonatomic, strong) DiscoverTableViewController *discoverVC;
@property (nonatomic, strong) YDServiceViewController *serviceVC;
@property (nonatomic, strong) MyselfController *myselfVC;

@property (nonatomic, strong) YDFriendsViewController *friendsVC;
@property (nonatomic, strong) YDChatViewController *chatVC;

@property (nonatomic, weak) UIViewController *currentController;

@end

@implementation YDRootViewController

+ (YDRootViewController *)sharedRootViewController{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        rootVC = [[YDRootViewController alloc] init];
    });
    return rootVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setViewControllers:self.childVCArray];
}

#pragma mark - 还是有问题啊！下次再搞吧...
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"currentController = %@",self.currentController);
    
//    if (self.currentController == self.mainVC) {
//        [self.discoverVC removeFromParentViewController];
//        [self.discoverVC.view removeFromSuperview];
//        [self setDiscoverVC:nil];
//        
//        [self.serviceVC removeFromParentViewController];
//        [self.serviceVC.view removeFromSuperview];
//        [self setServiceVC:nil];
//        
//        [self.myselfVC removeFromParentViewController];
//        [self.myselfVC.view removeFromSuperview];
//        [self setMyselfVC:nil];
//        
//    }else if (self.currentController == self.discoverVC){
//        [self.mainVC removeFromParentViewController];
//        [self.mainVC.view removeFromSuperview];
//        [self setMainVC:nil];
//        
//        [self.serviceVC removeFromParentViewController];
//        [self.serviceVC.view removeFromSuperview];
//        [self setServiceVC:nil];
//        
//        [self.myselfVC removeFromParentViewController];
//        [self.myselfVC.view removeFromSuperview];
//        [self setMyselfVC:nil];
//    
//    }else if (self.currentController == self.serviceVC){
//        [self.mainVC removeFromParentViewController];
//        [self.mainVC.view removeFromSuperview];
//        [self setMainVC:nil];
//        
//        [self.discoverVC removeFromParentViewController];
//        [self.discoverVC.view removeFromSuperview];
//        [self setDiscoverVC:nil];
//        
//        [self.myselfVC removeFromParentViewController];
//        [self.myselfVC.view removeFromSuperview];
//        [self setMyselfVC:nil];
//    }else{
//        [self.mainVC removeFromParentViewController];
//        [self.mainVC.view removeFromSuperview];
//        [self setMainVC:nil];
//        
//        [self.discoverVC removeFromParentViewController];
//        [self.discoverVC.view removeFromSuperview];
//        [self setDiscoverVC:nil];
//        
//        [self.serviceVC removeFromParentViewController];
//        [self.serviceVC.view removeFromSuperview];
//        [self setServiceVC:nil];
//    }
}

- (id)childViewControllerAtIndex:(NSUInteger)index{
    return [[self.childViewControllers objectAtIndex:index] rootViewController];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    self.currentController = [viewController.childViewControllers firstObject];
    
}

#pragma mark Getters
- (NSArray *)childVCArray{
    if (_childVCArray == nil) {
        YDNavigationController *mainNaVC = [[YDNavigationController alloc] initWithRootViewController:self.friendsVC];
        YDNavigationController *discoverNaVC = [[YDNavigationController alloc] initWithRootViewController:self.discoverVC];
        YDNavigationController *serviceNaVC = [[YDNavigationController alloc] initWithRootViewController:self.serviceVC];
        YDNavigationController *myselfNaVC = [[YDNavigationController alloc] initWithRootViewController:self.myselfVC];
        _childVCArray = @[mainNaVC,discoverNaVC,serviceNaVC,myselfNaVC];
    }
    return _childVCArray;
}

- (YDFriendsViewController *)friendsVC{
    if (_friendsVC == nil) {
        _friendsVC = [YDFriendsViewController new];
    }
    return _friendsVC;
}

- (YDChatViewController *)chatVC{
    if (_chatVC == nil) {
        _chatVC = [YDChatViewController new];
    }
    return _chatVC;
}

- (YDMainViewController *)mainVC{
    if (_mainVC == nil) {
        _mainVC = [YDMainViewController new];
        _mainVC.tabBarItem.title = @"首页";
        _mainVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_mainframe"];
        _mainVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_mainframeHL"];
    }
    return _mainVC;
}

- (DiscoverTableViewController *)discoverVC{
    if (_discoverVC == nil) {
        _discoverVC = [DiscoverTableViewController new];
        _discoverVC.tabBarItem.title = @"发现";
        _discoverVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
        _discoverVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_discoverHL"];
        
    }
    return _discoverVC;
}

- (YDServiceViewController *)serviceVC{
    if (_serviceVC == nil) {
        _serviceVC = [YDServiceViewController new];
        _serviceVC.tabBarItem.title = @"服务";
        _serviceVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_contacts"];
        _serviceVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_contacts"];
    }
    return _serviceVC;
}

- (MyselfController *)myselfVC{
    if (_myselfVC == nil) {
        _myselfVC = [MyselfController new];
        _myselfVC.tabBarItem.title = @"我";
        _myselfVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_me"];
        _myselfVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_meHL"];
    }
    return _myselfVC;
}



@end

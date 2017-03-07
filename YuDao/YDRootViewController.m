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
#import "YDDiscoverController.h"
#import "YDServiceViewController.h"
#import "YDMyselfController.h"

//test
#import "YDNewDynamicController.h"

static YDRootViewController *rootVC = nil;

@interface YDRootViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) NSArray *childVCArray;

@property (nonatomic, strong) YDMainViewController        *mainVC;
@property (nonatomic, strong) YDDiscoverController *discoverVC;
@property (nonatomic, strong) YDServiceViewController     *serviceVC;
@property (nonatomic, strong) YDMyselfController          *myselfVC;

@property (nonatomic, weak  ) UIViewController *currentController;

@property (nonatomic, assign) NSInteger systemMessageCount;
@property (nonatomic, assign) NSInteger friendRequestCount;
@property (nonatomic, assign) NSInteger chatMessageCount;


@end

@implementation YDRootViewController

+ (YDRootViewController *)sharedRootViewController{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        rootVC = [[YDRootViewController alloc] init];
    });
    return rootVC;
}

- (instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMyselfViewControllerBadge:) name:kChangeMyselfBadgeNotification object:nil];
        [self changeMyselfViewControllerBadge:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setViewControllers:self.childVCArray];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 还是有问题啊！下次再搞吧...
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (id)childViewControllerAtIndex:(NSUInteger)index{
    return [self.childViewControllers objectAtIndex:index] ;
}

#pragma mark - 收到有新消息或消息已被阅读,修改<我>控制器的角标
- (void)changeMyselfViewControllerBadge:(NSNotification *)noti{
    NSLog(@"Notification_Manager: systemMessageCount = %ld friendRequestCount = %ld",self.systemMessageCount,self.friendRequestCount);
    NSInteger allCount = self.systemMessageCount + self.friendRequestCount + self.chatMessageCount;
    
    NSString *badgeValue = allCount == 0 ? nil : [NSString stringWithFormat:@"%ld",allCount];
    
    UITabBarItem *item = [self.tabBar.items objectAtIndex:3];
    
    [item setBadgeValue:badgeValue];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    if ([viewController isKindOfClass:[YDNavigationController class]]) {
        YDNavigationController *navVC = (YDNavigationController *)viewController;
        UIViewController  *vc = navVC.viewControllers.firstObject;
        //判断用户点击的是我
        if ([vc isKindOfClass:[YDMyselfController class]]) {
            if (!YDHadLogin) {//用户未登录
                [self presentViewController:[YDLoginViewController new] animated:YES completion:nil];
                return NO;
            }
        }
        
    }
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[YDMyselfController class]]) {
        NSLog(@"3");
        if (![[NSUserDefaults standardUserDefaults] valueForKey:@"currentUserid"]) {
            NSLog(@"4");
            [UIAlertView bk_showAlertViewWithTitle:@"用户未登录,不可查看" message:@"是否进入登录界面" cancelButtonTitle:@"否" otherButtonTitles:@[@"是"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    [self presentViewController:[YDLoginViewController new] animated:YES completion:nil];
                }
            }];
        }else{
            [YDNetworking postUrl:kRefreshTokenURL parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token} success:^(NSURLSessionDataTask *task, id responseObject) {
                NSNumber *status_code = [[responseObject mj_JSONObject] valueForKey:@"status_code"];
                NSString *status = [[responseObject mj_JSONObject] valueForKey:@"status"];
                NSLog(@"status_code = %@, status = %@",status_code, status);
                if ([status_code isEqual:@3005]) {
                    [UIAlertView bk_showAlertViewWithTitle:@"用户未登录,不可查看" message:@"是否进入登录界面" cancelButtonTitle:@"否" otherButtonTitles:@[@"是"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                        if (buttonIndex == 1) {
                            [self presentViewController:[YDLoginViewController new] animated:YES completion:nil];
                        }
                    }];
                }
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hadLogin"];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"error = %@",error);
            }];
        }
    }
    

}

#pragma mark - Private Methods - 
//获取当前最前显示的ViewController
- (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}

#pragma mark Getters
//系统通知kkkkkkkkkkk
- (NSInteger )systemMessageCount{
    return [[YDSystemMessageHelper sharedSystemMessageHelper] getUnreadSystemMessageCount];
}
//好友请求
- (NSInteger )friendRequestCount{
    return [[YDSystemMessageHelper sharedSystemMessageHelper] getUnreadFriendRequestCount];
}
//聊天通知
- (NSInteger )chatMessageCount{
    return [[YDConversationHelper shareInstance] allUnreadMessageByUid:[YDUserDefault defaultUser].user.ub_id];
}

- (NSArray *)childVCArray{
    if (_childVCArray == nil) {
        YDNavigationController *mainNaVC = [[YDNavigationController alloc] initWithRootViewController:self.mainVC];
        YDNavigationController *discoverNaVC = [[YDNavigationController alloc] initWithRootViewController:self.discoverVC];
        YDNavigationController *serviceNaVC = [[YDNavigationController alloc] initWithRootViewController:self.serviceVC];
        YDNavigationController *myselfNaVC = [[YDNavigationController alloc] initWithRootViewController:self.myselfVC];
        _childVCArray = @[mainNaVC,discoverNaVC,serviceNaVC,myselfNaVC];
    }
    return _childVCArray;
}

- (YDMainViewController *)mainVC{
    if (_mainVC == nil) {
        _mainVC = [YDMainViewController new];
        _mainVC.tabBarItem.title = @"首页";
        _mainVC.tabBarItem.image = [UIImage imageNamed:@"tab_shouye_normal"];
        _mainVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_shouye_highlight"];
    }
    return _mainVC;
}

- (YDDiscoverController *)discoverVC{
    if (_discoverVC == nil) {
        _discoverVC = [YDDiscoverController new];
        _discoverVC.tabBarItem.title = @"发现";
        _discoverVC.tabBarItem.image = [[UIImage imageNamed:@"tab_discover_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _discoverVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_discover_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
    }
    return _discoverVC;
}

- (YDServiceViewController *)serviceVC{
    if (_serviceVC == nil) {
        _serviceVC = [YDServiceViewController new];
        _serviceVC.tabBarItem.title = @"服务";
        _serviceVC.tabBarItem.image = [UIImage imageNamed:@"tab_service_normal"];
        _serviceVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_service_highlight"];
    }
    return _serviceVC;
}

- (YDMyselfController *)myselfVC{
    if (_myselfVC == nil) {
        _myselfVC = [YDMyselfController new];
        _myselfVC.tabBarItem.title = @"我";
        _myselfVC.tabBarItem.image = [UIImage imageNamed:@"tab_mine_normal"];
        _myselfVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_mine_highlight"];
    }
    return _myselfVC;
}



@end

//
//  AppDelegate.m
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworking.h>
#import "YDNotificationView.h"
#import "YDLaunchViewController.h"
#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapView.h>

#import "YDNavigationController.h"
#import "YDAllDynamicController.h"
#import "YDNewDynamicController.h"
#import "YDLoginViewController.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "NSString+PinYin.h"
#define baiduMapKey @"8ckuVvwRl3mu8RK4FYCnCiVI5CKKTCte"

// 引入JPush功能所需头文件
#import "JPUSHService.h"

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#define kBaiduMobAppKey @"0945bc67e6"

@interface AppDelegate ()<BMKGeneralDelegate,JPUSHRegisterDelegate>

@property (strong ,nonatomic) BMKMapManager *mapManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (YDHadLogin) {//登录xmpp
        [[YDXMPPTool sharedInstance] loginWithUserId:[YDUserDefault defaultUser].user.ub_id andPassword:[YDUserDefault defaultUser].user.ub_password];
    }
    
    [self y_initJPush:launchOptions];//初始化极光推送
    
    [self y_init3DTouch];//初始化3Dtouch
    
    [self y_initUI:launchOptions];//初始化界面
    
    [self y_startBaiduAppCount];//百度app统计
    
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:baiduMapKey generalDelegate:self];
    if (ret) {
        NSLog(@"开启百度地图功能");
    }
    // 网络环境监测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    
    
    return YES;
}

#pragma mark - Private Methods
//开启百度app统计
- (void)y_startBaiduAppCount{
    /*若应用是基于iOS 9系统开发，需要在程序的info.plist文件中添加一项参数配置，确保日志正常发送，配置如下：
     NSAppTransportSecurity(NSDictionary):
     NSAllowsArbitraryLoads(Boolen):YES
     详情参考本Demo的BaiduMobStatSample-Info.plist文件中的配置
     */
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    // 此处(startWithAppId之前)可以设置初始化的可选参数，具体有哪些参数，可详见BaiduMobStat.h文件，例如：
    statTracker.shortAppVersion  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    statTracker.enableDebugOn = NO;
    statTracker.enableExceptionLog = YES;
    
    
    [statTracker startWithAppId:kBaiduMobAppKey]; // 设置您在mtj网站上添加的app的appkey,此处AppId即为应用的appKey
}
//初始化3DTouch
- (void)y_init3DTouch{
    NSString *platform = [YDNavigationController platform];
    
    if ([platform isEqualToString:@"iPhone 6s"] || [platform isEqualToString:@"iPhone 6s Plus"] || [platform isEqualToString:@"iPhone 7"] || [platform isEqualToString:@"iPhone 7 Plus"] || [platform isEqualToString:@"iPhone Simulator"]) {
        /**
         type 该item 唯一标识符
         localizedTitle ：标题
         localizedSubtitle：副标题
         icon：icon图标 可以使用系统类型 也可以使用自定义的图片
         userInfo：用户信息字典 自定义参数，完成具体功能需求
         */
        //    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"标签.png"];
        UIApplicationShortcutIcon *cameraIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
        UIApplicationShortcutItem *cameraItem = [[UIApplicationShortcutItem alloc] initWithType:@"ONE" localizedTitle:@"发个动态" localizedSubtitle:@"" icon:cameraIcon userInfo:nil];
        
        UIApplicationShortcutIcon *shareIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
        UIApplicationShortcutItem *shareItem = [[UIApplicationShortcutItem alloc] initWithType:@"TWO" localizedTitle:@"分享" localizedSubtitle:@"" icon:shareIcon userInfo:nil];
        /** 将items 添加到app图标 */
        [UIApplication sharedApplication].shortcutItems = @[cameraItem,shareItem];
    }
}
//Icon 3Dtouch 回调
- (void)application:(UIApplication *)application performActionForShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem completionHandler:(nonnull void (^)(BOOL))completionHandler{
    
    if ([shortcutItem.type isEqualToString:@"ONE"]) {
        NSInteger selectedIndex = YDHadLogin ? 1 : 0 ;
        
        self.rootVC.selectedIndex = selectedIndex;
        YDNavigationController *naviVC = self.rootVC.selectedViewController;
        if (YDHadLogin) {
            [naviVC pushViewController:[YDAllDynamicController new] animated:YES];
            YDNewDynamicController *vc = [YDNewDynamicController new];
            [naviVC pushViewController:vc animated:YES];
        }else{
            [naviVC.visibleViewController presentViewController:[YDLoginViewController new] animated:YES completion:^{
                
            }];
        }
        
    }
    if ([shortcutItem.type isEqualToString:@"TWO"]) {
        NSArray *arr = @[@"遇道"];
        
        UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:arr applicationActivities:nil];
        
        //设置当前的VC 为rootVC
        
        [self.window.rootViewController presentViewController:vc animated:YES completion:^{
            
        }];
    }
}

//初始化极光推送
- (void)y_initJPush:(NSDictionary *)launchOptions{
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:kJPushAppKey
                          channel:kJPushChannel
                 apsForProduction:kJPushIsProduction
            advertisingIdentifier:nil];
    
    //添加JPush登录成功监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(YDJPushDidLogin:)
                                                 name:kJPFNetworkDidLoginNotification
                                               object:nil];
    //添加JPush收到非APNS消息监听
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}
//JPush登录成功回调
- (void)YDJPushDidLogin:(NSNotification *)noti{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kJPFNetworkDidLoginNotification object:nil];
}
//收到消息(非APNS)
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    /*content：获取推送的内容
     extras：获取用户自定义参数
     customizeField1：根据自定义key获取自定义的value*/
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    //NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    NSLog(@"非APNS消息: content = %@, extras = %@",content,extras);
}

- (void)y_initUI:(NSDictionary *)launchOptions{
    //开启AFNetworking的菊花效果
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //判断是否是通过点击推送消息进入的APP
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    _rootVC = [YDRootViewController sharedRootViewController];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user boolForKey:@"isFirst"]) {
        self.window.rootViewController = _rootVC;
    }else{
        self.window.rootViewController = [YDLaunchViewController new];
    }
    NSDictionary *resultDic = launchOptions[@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    if (resultDic) {
        NSLog(@"resultDic = %@",resultDic);
        _rootVC.selectedIndex = 3;
    }else{
        _rootVC.selectedIndex = 0;
    }
    
    [self.window makeKeyAndVisible];
}

/*****************************   程序生命周期  *************************/
/*应用程序将要进入非活动状态，即将进入后台
 说明：当应用程序将要进入非活动状态时执行，在此期间，应用程序不接收消息或事件，比如来电话了。*/
- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"applicationWillResignActive");
    BOOL backgroundAccepted = [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^{
        NSLog(@"APP进入后台，申请再运行一分钟，进行未执行完的任务");
    }];
    if (backgroundAccepted)
    {
        NSLog(@"backgrounding accepted");
    }
}

/*如果应用程序支持后台运行，则应用程序已经进入后台运行
 说明：当程序被推送到后台的时候调用。所以要设置后台继续运行，则在这个函数里面设置即可。*/
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"应用程序已经进入后台运行");
    
    #pragma mark APP进入后台，申请再运行一分钟，进行未执行完的任务
    //关闭定位
    [[YDCurrentLocation shareCurrentLocation].locService setAllowsBackgroundLocationUpdates:NO];
}

/*应用程序将要进入活动状态，即将进入前台运行
  说明：当程序从后台将要重新回到前台时候调用，这个刚好跟上面的那个方法相反。*/
- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationWillEnterForeground");
    [application setApplicationIconBadgeNumber:0];   //清除角标
    [application cancelAllLocalNotifications];
}

/*应用程序已进入前台，处于活动状态
  说明：当应用程序进入活动状态时执行，这个刚好跟上面那个方法相反 。*/
- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
    //开启定位
    [[YDCurrentLocation shareCurrentLocation].locService setAllowsBackgroundLocationUpdates:YES];
    
    NSString *access_token = [YDUserDefault defaultUser].user.access_token;
    if (access_token) {
        [YDNetworking postUrl:kRefreshTokenURL parameters:@{@"access_token":access_token} success:^(NSURLSessionDataTask *task, id responseObject) {
            NSNumber *status_code = [[responseObject mj_JSONObject] valueForKey:@"status_code"];
            if ([status_code isEqual:@3005]) {
                [UIAlertController YD_alertController_OK_WithTitle:@"你的帐号已在其他地方登录" clickBlock:^{
                    [[YDViewController getCurrentViewController] presentViewController:[YDLoginViewController new] animated:YES completion:^{
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        [defaults removeObjectForKey:@"currentUser"];
                        [[YDCarHelper sharedHelper].carArray removeAllObjects];
                        [[YDCarHelper sharedHelper] deleteAllCars];
                        [YDAppConfigure defaultAppConfigure].userStatus = YDUserStatusLogout;
                        
                        //回到首页
                        [[YDRootViewController sharedRootViewController] setSelectedIndex:0];
                    }];
                }];
            }
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hadLogin"];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error = %@",error);
        }];

    }
    
    //红色表示清零
    [UIApplication sharedApplication].applicationIconBadgeNumber  =  0;
    
}

/*应用程序将要退出，通常用于保存数据和一些退出前的清理工作
  说明：当程序将要退出是被调用，通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值。*/
- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"applicationWillTerminate");
    
}

/*iPhone设备只有有限的内存，如果为应用程序分配了太多内存操作系统会终止应用程序的运行，在终止前会执行这个方法，通常可以在这里进行内存清理工作防止程序被终止。*/
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    NSLog(@"系统内存不足，需要进行清理工作");
    //1.清空缓存
    [[SDWebImageManager sharedManager].imageCache clearDisk];
    [[SDWebImageManager sharedManager].imageCache cleanDisk];
}

/*****************************   处理本地消息  *************************/
//处理本地消息,当一个运行着的应用程序收到一个本地的通知 发送到委托去...
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
}

//注册APNS成功并上报DeviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken{
    NSLog(@"device1 = %@",deviceToken);
    [JPUSHService registerDeviceToken:deviceToken];
}
//当 APS无法成功的完成向 程序进程推送时 发送到委托去...
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

/*****************************   处理远程消息  *************************/
//当一个应用程序成功的注册一个推送服务（APS） 发送到委托去...
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // apn 内容获取：
    // 取得 APNs 标准信息内容
    [JPUSHService handleRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification
                   :(NSDictionary *)userInfo fetchCompletionHandler
                   : (void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 && [UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        NSLog(@"iOS7及以上系统，收到前台通知:%@", [self logDic:userInfo]);
        // 处于前台时 ，添加各种需求代码。。。。
        [self showNotificationView:userInfo];
        
    }else if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 && [UIApplication sharedApplication].applicationState != UIApplicationStateActive)
    {
        NSLog(@"iOS7及以上系统，收到后台通知:%@", [self logDic:userInfo]);
        // app 处于后台 ，添加各种需求
        [self showNotificationView:userInfo];
        
    }
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
// 当ios10.0 程序在前台时, 收到推送弹出的通知
-(void)jpushNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        [self showNotificationView:userInfo];
        
    }else{
        //本地通知
    }
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}
// 程序关闭后, 通过点击推送弹出的通知
-(void)jpushNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 点击通知进入收到远程通知:%@", [self logDic:userInfo]);
        [self showNotificationView:userInfo];
        //[self showNotificationView:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}
#endif
//MARK:收到推送时调用---自定义通知视图
- (void)showNotificationView:(NSDictionary *)userInfo{
    //保存系统通知
    NSNumber *code = [userInfo valueForKey:@"code"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSNumber *timeNum = [userInfo valueForKey:@"time"];
    NSNumber *ub_id = [userInfo valueForKey:@"ub_id"];
    NSString *ub_nickname = [userInfo valueForKey:@"ub_nickname"];
    NSString *ud_face = [userInfo valueForKey:@"ud_face"];
    
#pragma mark - 有其他用户登录,跳入登录界面
    if ([code isEqual:@3002]) {
        [UIAlertController YD_alertController_OK_WithTitle:@"你的帐号已在其他地方登录" clickBlock:^{
            [[YDViewController getCurrentViewController] presentViewController:[YDLoginViewController new] animated:YES completion:^{
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults removeObjectForKey:@"currentUser"];
                [[YDCarHelper sharedHelper].carArray removeAllObjects];
                [[YDCarHelper sharedHelper] deleteAllCars];
                [YDAppConfigure defaultAppConfigure].userStatus = YDUserStatusLogout;
                
                //回到首页
                [[YDRootViewController sharedRootViewController] setSelectedIndex:0];
            }];
        }];
        return;
    }
    
    YDSystemMessage *lastMessage = [[YDSystemMessageHelper sharedSystemMessageHelper] lastSysMessage];
    
    YDSystemMessage *message = [[YDSystemMessage alloc] init];
    message.msgid = lastMessage? @(lastMessage.msgid.integerValue+1) : @0;
    NSNumber *userid = nil;
    if (YDHadLogin) {
        userid = [YDUserDefault defaultUser].user.ub_id;
    }else{
        userid = @0;
    }
    message.userid = userid;
    message.code = code;
    message.content = content;
    message.date = [NSDate dateFromTimeStamp:[NSString stringWithFormat:@"%@",timeNum]];
    message.messageType = YDSystemMessageNotification;
    message.readState = YDMessageUnRead;
    message.frStatus = YDFriendRequestStatusNormal;
    
    //1001 -> 添加好友  1002 -> 对方同意好友请求
    if ([code isEqual:@1001] || [code isEqual:@1002]) {
        message.ub_id = ub_id;
        message.ub_nickname = ub_nickname;
        message.ud_face = ud_face;
        if ([code isEqual:@1002]) {
            YDFriendModel *model = [YDFriendModel new];
            model.friendid = message.ub_id;
            model.currentUserid = message.userid;
            model.friendImage = message.ud_face;
            model.friendName = message.ub_nickname;
            model.friendGrade = @0;
            NSString *pinyin = [message.ub_nickname pinyinInitial];
            if (pinyin.length == 1) {
                model.firstchar = pinyin;
            }else{
                model.firstchar = [pinyin substringFromIndex:0];
            }
            if ([[YDFriendHelper sharedFriendHelper] addFriendByUid:model]) {
                NSLog(@"接受好友请求，并插入数据库");
            }
            //对方同意发到通知中心
            [[NSNotificationCenter defaultCenter] postNotificationName:kSystemMessageNotification object:nil];
        }else{
            //新的好友请求发到通知中心
            //[[NSNotificationCenter defaultCenter] postNotificationName:kFriendRequestNotification object:nil];
        }
    }else{
        message.ub_id = timeNum;
        message.ub_nickname = @"";
        message.ud_face = @"";
        //系统通知发到通知中心
        [[NSNotificationCenter defaultCenter] postNotificationName:kSystemMessageNotification object:nil];
    }
    //存入数据库
    [[YDSystemMessageHelper sharedSystemMessageHelper] addSystemMessage:message];
    
    
}
- (NSString *)logDic:(NSDictionary *)dic {
    
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}


@end

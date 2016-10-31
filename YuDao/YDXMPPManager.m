//
//  YDXMPPManager.m
//  YuDao
//
//  Created by 汪杰 on 16/10/31.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDXMPPManager.h"
#import "XMPPReconnect.h"

@interface YDXMPPManager()

@property (nonatomic, strong) XMPPJID *fromJid;

@property (nonatomic, strong) XMPPReconnect *reconnect;


@end

static YDXMPPManager *manager = nil;
@implementation YDXMPPManager

+ (YDXMPPManager *)defaultManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YDXMPPManager alloc] init];
    });
    return manager;
}

- (instancetype )init{
    if (self = [super init]) {
        //1.初始化数据流
        self.stream = [XMPPStream new];
        self.stream.hostName = kHostName;
        self.stream.hostPort = kHostPort;
        [self.stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
        [self.stream setKeepAliveInterval:30];//心跳包的时间
        
        //允许xmpp在后台运行
        self.stream.enableBackgroundingOnSocket = YES;
        
        //断线重连
        self.reconnect = [XMPPReconnect new];
        [self.reconnect setAutoReconnect:YES];
        [self.reconnect activate:self.stream];
        
        //2.接入流管理模块，用于流恢复跟消息确认
        self.storage = [XMPPStreamManagementMemoryStorage new];
        self.streamManager = [[XMPPStreamManagement alloc] initWithStorage:self.storage];
        self.streamManager.autoResume = YES;
        [self.streamManager addDelegate:self delegateQueue:dispatch_get_main_queue()];
        [self.streamManager activate:self.stream];
        
        //3.好友管理,获得一个存储好友的CoreData仓库，用来数据持久化
        XMPPRosterCoreDataStorage *rosterCoreDataStorage = [XMPPRosterCoreDataStorage sharedInstance];
        //初始化xmppRoster
        self.roster = [[XMPPRoster alloc]initWithRosterStorage:rosterCoreDataStorage dispatchQueue:dispatch_get_main_queue()];
        //激活
        [self.roster activate:self.stream];
        //设置代理
        [self.roster addDelegate:self delegateQueue:dispatch_get_main_queue()];
     
        //4.保存聊天记录
        //初始化一个仓库
        XMPPMessageArchivingCoreDataStorage *messageStorage = [XMPPMessageArchivingCoreDataStorage sharedInstance];
        //创建一个消息归档对象
        self.xmppMessageArchiving = [[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:messageStorage dispatchQueue:dispatch_get_main_queue()];
        //激活
        [self.xmppMessageArchiving activate:self.stream];
        //上下文
        self.messageArchivingContext = messageStorage.mainThreadManagedObjectContext;
    }
    return self;
}

-(void)loginwithName:(NSString *)userName andPassword:(NSString *)password
{
    //标记连接服务器的目的
    self.connectPurPose = YDConnectServerPurposeLogin;
    //这里记录用户输入的密码，在登录（注册）的方法里面使用
    self.password = password;
    /**
     *  1.初始化一个xmppStream
     2.连接服务器（成功或者失败）
     3.成功的基础上，服务器验证（成功或者失败）
     4.成功的基础上，发送上线消息
     */
    
    
    // *  创建xmppjid（用户）
    // *  @param NSString 用户名，域名，登录服务器的方式（苹果，安卓等）
    
    XMPPJID *jid = [XMPPJID jidWithUser:userName domain:@"yulian" resource:@"iPhone6p"];
    self.stream.myJID = jid;
    //连接到服务器
    [self connectToServer];
    
    //有可能成功或者失败，所以有相对应的代理方法
    
}

#pragma mark 注册
-(void)registerWithName:(NSString *)userName andPassword:(NSString *)password{
    self.password = password;
    //0.标记连接服务器的目的
    self.connectPurPose = YDConnectServerPurposeRegister;
    //1. 创建一个jid
    XMPPJID *jid = [XMPPJID jidWithUser:userName domain:@"yulian" resource:@"iPhone6p"];
    //2.将jid绑定到xmppStream
    self.stream.myJID = jid;
    //3.连接到服务器
    [self connectToServer];
    
}

/**
 *  连接服务器
 */
- (void)connectToServer{
    if ([self.stream isConnected]) {
        [self logout];
    }
    NSError *error = nil;
    [self.stream connectWithTimeout:15.0f error:&error];
    if (error) {
        NSLog(@"error = %@",error);
    }
}

// 收到好友请求执行的方法
-(void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence{
    self.fromJid = presence.from;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示:有人添加你" message:presence.from.user  delegate:self cancelButtonTitle:@"拒绝" otherButtonTitles:@"OK", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self.roster rejectPresenceSubscriptionRequestFrom:self.fromJid];
            break;
        case 1:
            [self.roster acceptPresenceSubscriptionRequestFrom:self.fromJid andAddToRoster:YES];
            break;
        default:
            break;
    }
}

#pragma mark xmppStream的代理方法
//连接服务器成功的方法
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"连接服务器成功的方法");
    if (self.connectPurPose == YDConnectServerPurposeLogin) {
        NSError *error = nil;
        //        向服务器发送密码验证 //验证可能失败或者成功
        [sender authenticateWithPassword:self.password error:&error];
        //        NSLog(@"-----%@",self.password);
    }else{
        //向服务器发送一个密码注册（成功或者失败）
        [sender registerWithPassword:self.password error:nil];
    }
}

//连接服务器失败的方法
- (void)xmppStreamConnectDidTimeout:(XMPPStream *)sender{
     NSLog(@"连接服务器失败的方法，请检查网络是否正常");
}

//验证成功的方法
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"验证成功的方法");
    /**
     *  unavailable 离线
     available  上线
     away  离开
     do not disturb 忙碌
     */
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"available"];
    [self.stream sendElement:presence];
}

//验证失败的方法
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    NSLog(@"验证失败的方法,请检查你的用户名或密码是否正确,%@",error);
}


#pragma mark 注销方法的实现
-(void)logout{
    //表示离线不可用
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    //    向服务器发送离线消息
    [self.stream sendElement:presence];
    //断开链接
    [self.stream disconnect];
}



@end

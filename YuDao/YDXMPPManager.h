//
//  YDXMPPManager.h
//  YuDao
//
//  Created by 汪杰 on 16/10/31.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPP.h"
#import "XMPPRoster.h"
#import "XMPPRosterCoreDataStorage.h"
#import "XMPPMessageArchiving.h"
#import "XMPPMessageArchivingCoreDataStorage.h"
#import "XMPPStreamManagementMemoryStorage.h"

#define kHostName @"ve-link.com"
#define kHostPort 5222

typedef NS_ENUM(NSInteger, YDConnectServerPurpose)
{
    YDConnectServerPurposeLogin,    //登录
    YDConnectServerPurposeRegister   //注册
};

@interface YDXMPPManager : NSObject<XMPPStreamDelegate,XMPPRosterDelegate>

@property (nonatomic, strong) XMPPStream *stream;
@property (nonatomic, strong) XMPPStreamManagement *streamManager;

@property (nonatomic, strong) XMPPStreamManagementMemoryStorage *storage;

@property (nonatomic, strong) XMPPRoster *roster;

@property (nonatomic, strong) NSString *password;
@property (nonatomic, assign) YDConnectServerPurpose connectPurPose;

//聊天信息归档
@property(nonatomic,strong)XMPPMessageArchiving *xmppMessageArchiving;
//信息归档的上下文
@property(nonatomic,strong)NSManagedObjectContext *messageArchivingContext;

//单例方法
+(YDXMPPManager *)defaultManager;

//登录的方法
-(void)loginwithName:(NSString *)userName andPassword:(NSString *)password;

//注册的方法
-(void)registerWithName:(NSString *)userName andPassword:(NSString *)password;

-(void)logout;

@end

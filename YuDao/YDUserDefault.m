//
//  YDUserDefault.m
//  YuDao
//
//  Created by 汪杰 on 16/12/6.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDUserDefault.h"

//上传用户信息
#define kUpUserInfoURL [kOriginalURL stringByAppendingString:@"upuserinfo"]

static YDUserDefault *userDefault = nil;

@implementation YDUserDefault

+ (YDUserDefault *)defaultUser{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userDefault = [[YDUserDefault alloc] init];
    });
    return userDefault;
}

- (id)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (YDUser *)getUser{
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"];
    return [YDUser mj_objectWithKeyValues:userDic];
}

- (void)setUser:(YDUser *)user{
    //保存用户信息至本地
    NSDictionary *userDic = user.mj_keyValues;
    
    [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:@"currentUser"];
    
    //上传用户信息至服务器
    [YDNetworking postUrl:kUpUserInfoURL parameters:userDic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *originalDic = [responseObject mj_JSONObject];
        
        NSLog(@"status = %@",[originalDic valueForKey:@"status"]);
        NSLog(@"status_code = %@",[originalDic valueForKey:@"status_code"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"上传用户信息失败 error = %@",error);
    }];
}

@end

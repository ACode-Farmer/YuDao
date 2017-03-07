//
//  YDUserDefault.h
//  YuDao
//
//  Created by 汪杰 on 16/12/6.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDUser.h"

@interface YDUserDefault : NSObject


+ (YDUserDefault *)defaultUser;

@property (nonatomic, strong, getter=getUser,setter=setUser:) YDUser  *user;

@end

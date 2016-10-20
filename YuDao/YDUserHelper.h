//
//  YDUserHelper.h
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDUser.h"

@interface YDUserHelper : NSObject

@property (nonatomic, strong) YDUser *user;

@property (nonatomic, strong, readonly) NSString *userID;

+ (YDUserHelper *) sharedHelper;

@end

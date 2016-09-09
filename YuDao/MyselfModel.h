//
//  MyselfModel.h
//  YuDao
//
//  Created by 汪杰 on 16/9/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyselfModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL haveMessage;

+ (instancetype)modelWithIamgeName:(NSString *)imageName name:(NSString *)name;

@end

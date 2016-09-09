//
//  MyMseeageModel.h
//  YuDao
//
//  Created by 汪杰 on 16/9/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMseeageModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *lastMessage;
@property (nonatomic, copy) NSString *time;

+ (instancetype)modelWith:(NSString *)imageName name:(NSString *)name lastMessage:(NSString *)lastMessage time:(NSString *)time;

@end

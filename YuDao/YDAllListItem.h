//
//  YDAllListItem.h
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDAllListItem : NSObject

@property (nonatomic, copy) NSString *placing;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *data;
@property (nonatomic, assign) BOOL isLiked;

+ (instancetype)modelWithPlacing:(NSString *)placing imageName:(NSString *)imageName name:(NSString *)name isLiked:(BOOL)isLiked data:(NSString *)data;

@end

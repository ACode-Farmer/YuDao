//
//  YDAllListItem.m
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDAllListItem.h"

@implementation YDAllListItem

+ (instancetype)modelWithPlacing:(NSString *)placing imageName:(NSString *)imageName name:(NSString *)name isLiked:(BOOL)isLiked data:(NSString *)data{
    YDAllListItem *item = [self new];
    item.placing = placing;
    item.imageName = imageName;
    item.name = name;
    item.isLiked = isLiked;
    item.data = data;
    
    return item;
}

@end

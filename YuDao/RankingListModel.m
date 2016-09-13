//
//  RankingListModel.m
//  YuDao
//
//  Created by 汪杰 on 16/9/13.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "RankingListModel.h"

@implementation RankingListModel

+(instancetype)modelWithRanking:(NSString *)ranking imageName:(NSString *)imageName name:(NSString *)name data:(NSString *)data isLike:(BOOL)isLike{
    RankingListModel *model = [self new];
    model.ranking = ranking;
    model.imageName = imageName;
    model.name = name;
    model.data = data;
    model.isLike = isLike;
    
    return model;
}

@end

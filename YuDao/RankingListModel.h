//
//  RankingListModel.h
//  YuDao
//
//  Created by 汪杰 on 16/9/13.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankingListModel : NSObject

@property (nonatomic, copy) NSString *ranking;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *data;
@property (nonatomic, assign) BOOL isLike;

+ (instancetype)modelWithRanking:(NSString *)ranking imageName:(NSString *)imageName name:(NSString *)name data:(NSString *)data isLike:(BOOL )isLike;

@end

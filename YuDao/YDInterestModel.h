//
//  YDInterestModel.h
//  YuDao
//
//  Created by 汪杰 on 16/11/10.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDInterestModel : NSObject

@property (nonatomic, assign) NSNumber *t_id;   //当前id
@property (nonatomic, copy  ) NSString *t_name; //父级id
@property (nonatomic, assign) NSNumber *t_pid;
@property (nonatomic, assign) NSNumber *t_time;

@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) NSMutableArray *items;

+ (YDInterestModel *)shareInterests;

@end

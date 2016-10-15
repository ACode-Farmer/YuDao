//
//  YDGroupModel.h
//  YuDao
//
//  Created by 汪杰 on 16/10/15.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDGroupModel : NSObject

@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, copy) NSString *groupImageName;
@property (nonatomic, assign) YDGroupDetailType groupType;

@property (nonatomic, copy) NSString *groupID;//预留字段，用于标识群组

+ (instancetype)groupModelWithGroupName:(NSString *)groupName groupImageName:(NSString *)groupImageName groupType:(YDGroupDetailType )groupType;

@end

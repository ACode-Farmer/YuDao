//
//  DrivingDataModel.h
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrivingDataModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *firstData;
@property (nonatomic, copy) NSString *secondData;

+ (instancetype)modelWith:(NSString *)title imageName:(NSString *)imageName firstData:(NSString *)firstData secondData:(NSString *)secondData;

@end

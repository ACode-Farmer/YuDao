//
//  LocationModel.h
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModel : NSObject

@property (nonatomic, copy) NSString *userImageName;
@property (nonatomic, copy) NSString *userLocation;

@property (nonatomic, strong) NSMutableArray *carNumber;
@property (nonatomic, copy) NSString *carArrowName;

@property (nonatomic, copy) NSString *carImageName;
@property (nonatomic, copy) NSString *distance;

@end

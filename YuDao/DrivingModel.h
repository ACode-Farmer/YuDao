//
//  DrivingModel.h
//  YuDao
//
//  Created by 汪杰 on 16/9/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrivingModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *data;
@property (nonatomic, copy) NSString *subTitle;

+ (instancetype)modelWithTitle:(NSString *)title data:(NSString *)data subTitle:(NSString *)subTitle;

@end

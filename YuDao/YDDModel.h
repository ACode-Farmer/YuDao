//
//  YDDModel.h
//  YuDao
//
//  Created by 汪杰 on 16/10/10.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDDModel : NSObject

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *placeImageName;
@property (nonatomic, strong) NSString *place;

+ (instancetype)modelWithImageName:(NSString *)imageName number:(NSString *)number time:(NSString *)time name:(NSString *)name content:(NSString *)content placeImageName:(NSString *)placeImageName place:(NSString *)place;

@end

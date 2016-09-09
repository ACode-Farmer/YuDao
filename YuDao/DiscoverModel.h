//
//  DiscoverModel.h
//  YuDao
//
//  Created by 汪杰 on 16/9/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *name;

+ (instancetype)modelWithImageName:(NSString *)imageName name:(NSString *)name;

@end

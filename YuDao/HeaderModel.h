//
//  HeaderModel.h
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *name;

+(HeaderModel *)modelWithImageName:(NSString *)imageName Name:(NSString *)name;

@end

//
//  SetupModel.h
//  YuDao
//
//  Created by 汪杰 on 16/9/18.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetupModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;

+ (instancetype)modelWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

@end

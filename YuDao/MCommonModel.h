//
//  MCommonModel.h
//  YuDao
//
//  Created by 汪杰 on 16/9/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCommonModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;


+ (instancetype)normalModelWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

+ (instancetype)singleModelWithTitle:(NSString *)title;

@end

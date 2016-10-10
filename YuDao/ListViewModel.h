//
//  ListViewModel.h
//  YuDao
//
//  Created by 汪杰 on 16/10/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListViewModel : NSObject

@property (nonatomic, copy) NSString *placing;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *grade;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) BOOL isAttention;

+ (instancetype)modelWithPlacing:(NSString *)placing imageName:(NSString *)imageName name:(NSString *)name grade:(NSString *)grade sign:(NSString *)sign type:(NSString *)type isAttention:(BOOL)isAttention;

@end

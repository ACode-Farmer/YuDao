//
//  MenuModel.h
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuModel : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *menuLable;
@property (nonatomic, copy) NSString *arrow;

- (instancetype)initWithIcon:(NSString *)iconName lable:(NSString *)label arrow:(NSString *)arrowIcon;

@end

//
//  YDMyDataModel.h
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDMyDataModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *subImageName;

+ (YDMyDataModel *)modelWithTitle:(NSString *)title subTitle:(NSString *)subTitle subImageName:(NSString *)subImageName;

@end

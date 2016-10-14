//
//  YDGarageModel.h
//  YuDao
//
//  Created by 汪杰 on 16/10/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDGarageModel : NSObject

@property (nonatomic, copy) NSString *carImageName;
@property (nonatomic, copy) NSString *carname;
@property (nonatomic, assign) BOOL isIdentified;
@property (nonatomic, copy) NSString *carModel;
@property (nonatomic, copy) NSString *checkTitle;

+ (instancetype)modelWithCarImageName:(NSString *)carImageName carName:(NSString *)carName isIdentified:(BOOL )isIdentified carModel:(NSString *)carModel checkTitle:(NSString *)checkTitle;

@end

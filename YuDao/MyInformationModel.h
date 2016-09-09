//
//  MyInformationModel.h
//  JiaPlus
//
//  Created by 汪杰 on 16/9/6.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyInformationModel : NSObject

@property (nonatomic, copy) NSString *headImage;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *emotion;
@property (nonatomic, copy) NSString *place;
@property (nonatomic, copy) NSString *interesting;

+ (id)modelWithDictionary:(NSDictionary *)dic;

@end

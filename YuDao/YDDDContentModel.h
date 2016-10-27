//
//  YDDDContentModel.h
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDDDContentModel : NSObject

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@end



@interface YDDDNormalModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;

@end
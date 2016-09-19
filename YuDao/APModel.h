//
//  APModel.h
//  YuDao
//
//  Created by 汪杰 on 16/9/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CellType) {
    CellTypeSubTitle,
    CellTypeSwitch,
    CellTypeArrow,
    CellTypeCheckmark,
};

@interface APModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, assign) CellType type;

+(instancetype)modelWithTitle:(NSString *)title subTitle:(NSString *)subTitle cellType:(CellType )type;

@end

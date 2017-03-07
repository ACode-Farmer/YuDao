//
//  YDBindOBDModel.h
//  YuDao
//
//  Created by 汪杰 on 16/11/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDBindOBDModel : NSObject

@property (nonatomic, copy) NSString *title;      //标题
@property (nonatomic, copy) NSString *placeholder;//占位内容
@property (nonatomic, copy) NSString *imageString;//Button图片


+ (YDBindOBDModel *)modelWithTitle:(NSString *)title placeholder:(NSString *)placeholder imageString:(NSString *)imageString;

@end

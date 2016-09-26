//
//  CornerButton.h
//  YuDao
//
//  Created by 汪杰 on 16/9/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+ImageTitleSpacing.h"

@interface CornerButton : UIButton

+ (instancetype)circularButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)color;

+ (instancetype)circularButtonWithImageName:(NSString *)imageName;

+ (instancetype)normalButtonWithTitle:(NSString *)title
                            imageName:(NSString *)imageName
                MKButtonEdgeInsetsStyle:(MKButtonEdgeInsetsStyle )style;

@end

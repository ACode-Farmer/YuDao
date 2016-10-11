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
/**
 *  返回只有标题的圆角Button
 *
 *  @param title        标题
 *  @param color        背景颜色
 *  @param cornerRadius 圆角
 *
 *  @return 返回只有标题的圆角Button
 */
+ (instancetype)circularButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)color cornerRadius:(CGFloat) cornerRadius;

/**
 *  返回圆形Button
 *
 *  @param title 标题
 *  @param color 背景颜色
 *
 *  @return 返回圆形Button
 */
+ (instancetype)circularButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)color;

/**
 *  返回圆形图片Button
 *
 *  @param imageName 图片名字
 *
 *  @return 返回圆形图片Button
 */
+ (instancetype)circularButtonWithImageName:(NSString *)imageName;


/**
 *  返回圆形且有边宽的图片Button
 *
 *  @param imageName   图片名字
 *  @param borderWidth 变宽
 *
 *  @return <#return value description#>
 */
+ (instancetype)circularButtonWithImageName:(NSString *)imageName borderWidth:(CGFloat )borderWidth;

+ (instancetype)normalButtonWithTitle:(NSString *)title
                            imageName:(NSString *)imageName
                MKButtonEdgeInsetsStyle:(MKButtonEdgeInsetsStyle )style;

@end

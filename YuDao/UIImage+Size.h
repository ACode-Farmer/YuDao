//
//  UIImage+Size.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/19.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Size)

-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)size;

- (UIImage *)scalingToSize:(CGSize)size;

//将UIImage转换为NSData
+(NSData*)getDataFromImage:(UIImage*)image;

@end

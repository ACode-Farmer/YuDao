//
//  UIImage+ChangeIt.m
//  YuDao
//
//  Created by 汪杰 on 16/9/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "UIImage+ChangeIt.h"

@implementation UIImage (ChangeIt)

/**
 *  剪切图片
 *
 *  @param image 原始图片
 *  @param rect  裁剪范围
 *
 *  @return 剪切好的图片
 */
- (UIImage*)clipImageWithImage:(UIImage*)image inRect:(CGRect)rect {
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, rect, imageRef);
    
    UIImage* clipImage = [UIImage imageWithCGImage:imageRef];
    
    //    CGImageCreateWithImageInRect(CGImageRef  _Nullable image, <#CGRect rect#>)
    
    //    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();      // 不同的方式
    
    UIGraphicsEndImageContext();
    
    //    NSData* data = [NSData dataWithData:UIImagePNGRepresentation(clipImage)];
    
    //    BOOL flag = [data writeToFile:@"/Users/gua/Desktop/Image/后.png" atomically:YES];
    
    //    GGLogDebug(@"========压缩后=======%@",clipImage);
    
    return clipImage;
    
}

@end

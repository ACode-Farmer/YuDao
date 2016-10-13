//
//  YDMacros.h
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#ifndef YDMacros_h
#define YDMacros_h

/********************  尺寸  ************************/
//屏幕宽
#define screen_width ([[UIScreen mainScreen] bounds].size.width)
//屏幕高
#define screen_height ([[UIScreen mainScreen] bounds].size.height)
//手机型号的宽高比
#define widthHeight_ratio screen_width/414

/********************  Methods  ************************/
#define     YDURL(urlString)    [NSURL URLWithString:urlString]
#define     YDWeakSelf(type)    __weak typeof(type) weak##type = type;
#define     YDStrongSelf(type)  __strong typeof(type) strong##type = type;
#define     YDColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

#endif /* YDMacros_h */
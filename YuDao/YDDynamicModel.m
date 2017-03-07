//
//  YDDynamicModel.m
//  YuDao
//
//  Created by 汪杰 on 16/11/11.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDynamicModel.h"

@implementation YDDynamicModel

- (CGFloat )width{
    NSString *width = [[self.d_image componentsSeparatedByString:@","] objectAtIndex:1];
    return [width floatValue];
}

- (CGFloat )height{
    NSString *height = [[self.d_image componentsSeparatedByString:@","] lastObject];
    return [height floatValue];
}

@end

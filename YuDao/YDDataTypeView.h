//
//  YDDataTypeView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDDataTypeView : UIView

@property (nonatomic, copy) void(^buttonActionBlock)(NSUInteger index);

- (instancetype)initWithTitleArray:(NSArray *)titleArray;

@end

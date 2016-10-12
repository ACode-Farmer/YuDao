//
//  YDRTypeView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YDRTypeViewDelegate <NSObject>

- (void)typeViewWithButton:(UIButton *)sender;

@end

@interface YDRTypeView : UIView

@property (nonatomic, weak) id<YDRTypeViewDelegate> delegate;
@property (nonatomic, assign) NSUInteger index;

- (instancetype)initWithTitles:(NSArray *)titles;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@end

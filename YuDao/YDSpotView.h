//
//  YDSpotView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/11.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YDSpotViewDelegate <NSObject>

- (void)spotViewWithTitle:(NSString *)title;

@end

@interface YDSpotView : UIView

@property (nonatomic, weak) id<YDSpotViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title;

@end

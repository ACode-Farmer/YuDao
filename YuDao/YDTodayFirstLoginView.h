//
//  YDTodayFirstLoginView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDTodayFirstLoginView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;

- (void)updateTFLView:(UIImage *)image title:(NSString *)title;

@end

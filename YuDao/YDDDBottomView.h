//
//  YDDDBottomView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YDDDBottomView;
@protocol YDDDBottomViewDelegate <NSObject>

- (void)ddBottomView:(YDDDBottomView *)bottomView commentContent:(NSString *)content;

- (void)ddBottomView:(YDDDBottomView *)bottomView didChangeTextViewHeight:(CGFloat )height;

@end

@interface YDDDBottomView : UIView

@property (nonatomic, weak) id<YDDDBottomViewDelegate> delegate;

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *commentBtn;

- (void)sendCurrentText;

@end

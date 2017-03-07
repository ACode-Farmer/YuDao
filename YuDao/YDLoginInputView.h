//
//  YDLoginInputView.h
//  YuDao
//
//  Created by 汪杰 on 16/11/15.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YDLoginInputView;
@protocol YDLoginInputViewDelegate <NSObject>

@optional
- (void)loginInputView:(YDLoginInputView *)inView getPassword:(UIButton *)btn;

@end

@interface YDLoginInputView : UIView<UITextFieldDelegate>

@property (nonatomic, weak  ) id<YDLoginInputViewDelegate> delegate;

@property (nonatomic, strong) UIButton      *labelButton;

@property (nonatomic, strong) UILabel       *label;
@property (nonatomic, strong) UITextField    *textF;

@property (nonatomic, strong) UIButton      *variableBtn;

@property (nonatomic, strong) NSDictionary   *dataDic;

@end

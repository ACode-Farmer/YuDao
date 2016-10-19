//
//  YDTalkButton.h
//  YuDao
//
//  Created by 汪杰 on 16/10/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDTalkButton : UIView

@property (nonatomic, copy) NSString *normalTitle;
@property (nonatomic, copy) NSString *cancelTitle;
@property (nonatomic, copy) NSString *highlightTitle;

@property (nonatomic, strong) UIColor *highlightCoclor;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)setTouchBeginAction:(void (^)())touchBegin
      willTouchCancelAction:(void (^)(BOOL cancel))willTouchCancel
             touchEndAction:(void (^)())touchEnd
          touchCancenAction:(void (^)())touchCancel;

@end

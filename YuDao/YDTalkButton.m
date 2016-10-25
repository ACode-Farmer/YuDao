//
//  YDTalkButton.m
//  YuDao
//
//  Created by 汪杰 on 16/10/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTalkButton.h"

@interface YDTalkButton()

@property (nonatomic, copy) void (^touchBegin)();
@property (nonatomic, copy) void (^touchMove)(BOOL cancel);
@property (nonatomic, copy) void (^touchCancel)();
@property (nonatomic, copy) void (^touchEnd)();

@end

@implementation YDTalkButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.normalTitle = @"按住 说话";
        self.highlightTitle = @"松开 结束";
        self.cancelTitle = @"松开 取消";
        self.highlightCoclor = [UIColor colorWithWhite:0.0 alpha:0.1];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.0f;
        self.layer.borderWidth = BORDER_WIDTH_1PX;
        self.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.3].CGColor;
        
        [self addSubview:self.titleLabel];
        [self y_layoutSubviews];
    }
    return self;
}

#pragma mark - Public Methods
- (void)setTouchBeginAction:(void (^)())touchBegin willTouchCancelAction:(void (^)(BOOL))willTouchCancel touchEndAction:(void (^)())touchEnd touchCancenAction:(void (^)())touchCancel{
    self.touchBegin = touchBegin;
    self.touchMove = willTouchCancel;
    self.touchCancel = touchCancel;
    self.touchEnd = touchEnd;
}

#pragma mark - Event Response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self setBackgroundColor:self.highlightCoclor];
    self.titleLabel.text = self.highlightTitle;
    if (self.touchBegin) {
        self.touchBegin();
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.touchMove) {
        CGPoint curPoint = [[touches anyObject] locationInView:self];
        BOOL moveIn = curPoint.x >= 0 && curPoint.x <= self.width && curPoint.y >= 0 && curPoint.y <= self.height;
        [self.titleLabel setText:(moveIn ? self.highlightTitle : self.cancelTitle)];
        self.touchMove(!moveIn);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setText:self.normalTitle];
    CGPoint curPoint = [[touches anyObject] locationInView:self];
    BOOL moveIn = curPoint.x >= 0 && curPoint.x <= self.width && curPoint.y >= 0 && curPoint.y <= self.height;
    if (moveIn && self.touchEnd) {
        self.touchEnd();
    }
    else if (!moveIn && self.touchCancel) {
        self.touchCancel();
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setText:self.normalTitle];
    if (self.touchCancel) {
        self.touchCancel();
    }
}

#pragma mark - Private Methods
- (void)y_layoutSubviews{
    self.titleLabel.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

#pragma mark - Getter
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        _titleLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = self.normalTitle;
    }
    return _titleLabel;
}




@end

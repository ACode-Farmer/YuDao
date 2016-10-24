//
//  YDChatCellMenuView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDChatCellMenuView.h"

@interface YDChatCellMenuView ()

@property (nonatomic, strong) UIMenuController *menuController;

@end

@implementation YDChatCellMenuView

+ (YDChatCellMenuView *)sharedMenuView
{
    static YDChatCellMenuView *menuView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        menuView = [[YDChatCellMenuView alloc] init];
    });
    return menuView;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.menuController = [UIMenuController sharedMenuController];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)showInView:(UIView *)view withMessageType:(YDMessageType)messageType rect:(CGRect)rect actionBlock:(void (^)(TLChatMenuItemType))actionBlock
{
    if (_isShow) {
        return;
    }
    _isShow = YES;
    [self setFrame:view.bounds];
    [view addSubview:self];
    [self setActionBlcok:actionBlock];
    [self setMessageType:messageType];
    
    [self.menuController setTargetRect:rect inView:self];
    [self becomeFirstResponder];
    [self.menuController setMenuVisible:YES animated:YES];
}

- (void)setMessageType:(YDMessageType)messageType
{
    UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyButtonDown:)];
    UIMenuItem *transmit = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(transmitButtonDown:)];
    UIMenuItem *collect = [[UIMenuItem alloc] initWithTitle:@"收藏" action:@selector(collectButtonDown:)];
    UIMenuItem *del = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteButtonDown:)];
    [self.menuController setMenuItems:@[copy, transmit, collect, del]];
}

- (void)dismiss
{
    _isShow = NO;
    if (self.actionBlcok) {
        self.actionBlcok(TLChatMenuItemTypeCancel);
    }
    [self.menuController setMenuVisible:NO animated:YES];
    [self removeFromSuperview];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - Event Response -
- (void)copyButtonDown:(UIMenuController *)sender
{
    [self p_clickedMenuItemType:TLChatMenuItemTypeCopy];
}

- (void)transmitButtonDown:(UIMenuController *)sender
{
    [self p_clickedMenuItemType:TLChatMenuItemTypeCopy];
}

- (void)collectButtonDown:(UIMenuController *)sender
{
    [self p_clickedMenuItemType:TLChatMenuItemTypeCopy];
}

- (void)deleteButtonDown:(UIMenuController *)sender
{
    [self p_clickedMenuItemType:TLChatMenuItemTypeDelete];
}

#pragma mark - Private Methods -
- (void)p_clickedMenuItemType:(TLChatMenuItemType)type
{
    _isShow = NO;
    [self removeFromSuperview];
    if (self.actionBlcok) {
        self.actionBlcok(type);
    }
}

@end
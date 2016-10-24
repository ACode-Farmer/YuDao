//
//  YDChatCellMenuView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TLChatMenuItemType) {
    TLChatMenuItemTypeCancel,
    TLChatMenuItemTypeCopy,
    TLChatMenuItemTypeDelete,
};

@interface YDChatCellMenuView : UIView

@property (nonatomic, assign, readonly) BOOL isShow;

@property (nonatomic, assign) YDMessageType messageType;

@property (nonatomic, copy) void (^actionBlcok)();

+ (YDChatCellMenuView *)sharedMenuView;

- (void)showInView:(UIView *)view withMessageType:(YDMessageType)messageType rect:(CGRect)rect actionBlock:(void (^)(TLChatMenuItemType))actionBlock;

- (void)dismiss;


@end

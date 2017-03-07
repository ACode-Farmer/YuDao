//
//  AWActionSheet.h
//  AWIconSheet
//
//  Created by Narcissus on 10/26/12.
//  Copyright (c) 2012 Narcissus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AWActionSheetCell;

@protocol AWActionSheetDelegate <NSObject>

- (int)numberOfItemsInActionSheet;
- (AWActionSheetCell*)cellForActionAtIndex:(NSInteger)index;
- (void)DidTapOnItemAtIndex:(NSInteger)index title:(NSString*)name;

@end


#pragma mark 底部弹出的分享视图
@interface AWActionSheet : UIWindow

@property (nonatomic, copy  ) void (^didTouchItemBlock)(NSInteger index);

@property (nonatomic, assign)id<AWActionSheetDelegate> IconDelegate;

-(id)initWithIconSheetDelegate:(id<AWActionSheetDelegate>)delegate ItemCount:(int)cout;

- (void)show;

@end


@interface AWActionSheetCell : UIView
@property (nonatomic,retain)UIImageView* iconView;
@property (nonatomic,retain)UILabel*     titleLabel;
@property (nonatomic,assign)int          index;
@end

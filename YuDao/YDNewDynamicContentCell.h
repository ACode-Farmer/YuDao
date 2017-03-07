//
//  YDNewDynamicContentCell.h
//  YuDao
//
//  Created by 汪杰 on 2017/1/15.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDNewDynamicContentCell;
@protocol YDNewDynamicContentCellDelegate <NSObject>

- (void)newDynamicContentCell:(YDNewDynamicContentCell *)cell selectedIndex:(NSInteger )index;

@end

@interface YDNewDynamicContentCell : UITableViewCell

@property (nonatomic, weak  ) id<YDNewDynamicContentCellDelegate> delegate;

@property (nonatomic, strong) UILabel    *placeholderLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView     *imagesView;

@property (nonatomic, strong) NSMutableArray *imagesArray;

@end

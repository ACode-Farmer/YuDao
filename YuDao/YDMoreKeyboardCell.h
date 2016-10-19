//
//  TLMoreKeyboardCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/18.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDMoreKeyboardItem.h"

@interface YDMoreKeyboardCell : UICollectionViewCell

@property (nonatomic, strong) YDMoreKeyboardItem *item;

@property (nonatomic, strong) void(^clickBlock)(YDMoreKeyboardItem *item);

@end
//
//  YDEmojiDisplayView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDEmoji.h"

@interface YDEmojiDisplayView : UIImageView

@property (nonatomic, strong) YDEmoji *emoji;

@property (nonatomic, assign) CGRect rect;

- (void)displayEmoji:(YDEmoji *)emoji atRect:(CGRect)rect;

@end

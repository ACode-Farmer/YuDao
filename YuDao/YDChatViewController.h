//
//  YDChatViewController.h
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDChatBaseViewController.h"


@interface YDChatViewController : YDChatBaseViewController

+ (YDChatViewController *)sharedChatVC;

/**
 *  用于测试图片的点击所写的临时数组
 */
@property (nonatomic, strong) NSMutableArray *textImageArray;




@end

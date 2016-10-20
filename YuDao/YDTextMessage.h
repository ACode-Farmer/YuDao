//
//  YDTextMessage.h
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMessage.h"

@interface YDTextMessage : YDMessage

@property (nonatomic, strong) NSString *text;                       // 文字信息

@property (nonatomic, strong) NSAttributedString *attrText;         // 格式化的文字信息（仅展示用）

@end

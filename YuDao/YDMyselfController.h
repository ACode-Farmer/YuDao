//
//  MyselfController.h
//  JiaPlus
//
//  Created by 汪杰 on 16/9/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDViewController.h"

@interface YDMyselfController :YDViewController

//更新消息或联系人提醒
- (void)updateMessageOrContactsRemindWith:(YDNotificationType )type count:(NSInteger )count;

@end

//
//  GroupDetailController.h
//  YuDao
//
//  Created by 汪杰 on 16/9/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "CommonController.h"

typedef NS_ENUM(NSUInteger, ControllerType) {
    ControllerTypeMine,
    ControllerTypeNew,
    ControllerTypeOld,
};

@interface GroupDetailController : UIViewController

@property (nonatomic, assign) ControllerType type;

@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, copy) NSString *groupID;

@end

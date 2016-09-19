//
//  AgeOrPlaceController.h
//  YuDao
//
//  Created by 汪杰 on 16/9/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ControllerType) {
    ControllerTypeAge,
    ControllerTypePlace,
    ControllerTypeGender,
    ControllerTypeEmotion,
};

@interface AgeOrPlaceController : UITableViewController

@property (nonatomic, assign) ControllerType vcType;

@end

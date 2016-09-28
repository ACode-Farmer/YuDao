//
//  FirstTableViewController.h
//  YuDao
//
//  Created by 汪杰 on 16/9/18.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ControllerType) {
    ControllerTypeOne = 0,
    ControllerTypeTwo,
    ControllerTypeThree,
};

@interface UniversalViewController : UITableViewController

- (id)initWithControllerType:(ControllerType )type title:(NSString *)title;

@end

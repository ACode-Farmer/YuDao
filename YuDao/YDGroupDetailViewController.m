//
//  YDGroupDetailViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/15.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDGroupDetailViewController.h"
#import "AWActionSheet.h"

@interface YDGroupDetailViewController ()

@end

@implementation YDGroupDetailViewController

//重写构造方法
- (instancetype)initWithType:(YDGroupDetailType)groupType title:(NSString *)title{
    if (self = [super init]) {
        _groupType = groupType;
        _variableTitle = title;
        switch (_groupType) {
            case YDGroupDetailTypeNew:_rightBarButtonTitle = @"完成";
                break;
            case YDGroupDetailTypeMine:_rightBarButtonTitle = @"分享";
                break;
            case YDGroupDetailTypeJoined:_rightBarButtonTitle = @"分享";
                break;
            case YDGroupDetailTypeNotJoin:_rightBarButtonTitle = @"分享";
                break;
            default:
                break;
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _variableTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    
}



@end

//
//  CaptureViewController.h
//  YuLianApp
//
//  Created by 汪杰 on 16/7/18.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaptureViewController : UIViewController

@property (nonatomic ,copy) void (^CaptureCancelBlock) (CaptureViewController *);

@property (nonatomic ,copy) void (^CaptureSuccessBlock) (CaptureViewController *,NSString *);

@property (nonatomic ,copy) void (^CaptureFailBlock) (CaptureViewController *);
@end

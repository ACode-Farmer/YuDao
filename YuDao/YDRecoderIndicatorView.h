//
//  YDRecoderIndicatorView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YDRecorderStatus) {
    YDRecorderStatusRecording,
    YDRecorderStatusWillCancel,
    YDRecorderStatusTooShort,
};

@interface YDRecoderIndicatorView : UIView

@property (nonatomic, assign) YDRecorderStatus status;

/**
 *  音量大小，取值（0-1）
 */
@property (nonatomic, assign) CGFloat volume;

@end

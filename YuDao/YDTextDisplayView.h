//
//  YDTextDisplayView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDTextDisplayView : UIView

@property (nonatomic, strong) NSAttributedString *attrString;

- (void)showInView:(UIView *)view withAttrText:(NSAttributedString *)attrText animation:(BOOL)animation;

@end

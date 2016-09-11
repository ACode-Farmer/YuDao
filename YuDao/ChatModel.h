//
//  ChatModel.h
//  YuDao
//
//  Created by 汪杰 on 16/9/11.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ChatModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) CGRect imageFrame;
@property (nonatomic, assign) CGRect messageFrame;
@property (nonatomic, assign) CGFloat rowHeight;

+ (instancetype)modelWithImage:(NSString *)imageName content:(NSString *)content time:(NSString *)time type:(NSInteger )type;

@end

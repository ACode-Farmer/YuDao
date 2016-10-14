//
//  ChatModel.m
//  YuDao
//
//  Created by 汪杰 on 16/9/11.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "ChatModel.h"

@implementation ChatModel

- (NSString *)description{
    return [NSString stringWithFormat:@"content = %@",self.content];
}

+ (instancetype)modelWithImage:(NSString *)imageName content:(NSString *)content time:(NSString *)time type:(NSInteger)type{
    ChatModel *model = [ChatModel new];
    model.imageName = imageName;
    model.content = content;
    model.time = time;
    model.type = type;
    
    [model updateFrame];
    
    return model;
}

- (void)updateFrame{
    CGFloat imageX = 0;
    CGFloat messageX = 0;
    CGFloat messageMasWidth = 200;
    CGSize maxSize = CGSizeMake(messageMasWidth, CGFLOAT_MAX);
    CGSize messageSize = [self.content boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size;
    
    if (self.type == 0) {
        imageX = 10;
        messageX = 65;
    }else{
        imageX = CGRectGetWidth([UIScreen mainScreen].bounds) - 60;
        messageX = imageX - messageSize.width - 45;
    }
    
    [self setImageFrame:CGRectMake(imageX, 41, 50, 50)];
    [self setMessageFrame:CGRectMake(messageX, 35, messageSize.width + 40, messageSize.height + 40)];
    [self setRowHeight:CGRectGetMaxY(self.messageFrame) + 10];
}
@end

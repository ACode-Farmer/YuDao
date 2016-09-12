//
//  DynamicCellModel.h
//  YuDao
//
//  Created by 汪杰 on 16/9/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LikeItemModel,CommentItemModel;
@interface DynamicCellModel : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSArray *picNameArray;

@property (nonatomic, assign, getter=isLiked) BOOL liked;
@property (nonatomic, strong) NSArray<LikeItemModel *> *likeItemsArray;
@property (nonatomic, strong) NSArray<CommentItemModel *> *commentItemsArray;

@property (nonatomic, assign) BOOL isOpening;
@property (nonatomic, assign, readonly) BOOL shouldShowMoreBtn;

@end


@interface LikeItemModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSAttributedString *attributedContent;

@end

@interface CommentItemModel : NSObject

@property (nonatomic, copy) NSString *commentString;
@property (nonatomic, copy) NSString *firstUserName;
@property (nonatomic, copy) NSString *firstUserId;

@property (nonatomic, copy) NSString *secondUserName;
@property (nonatomic, copy) NSString *secondUserId;

@property (nonatomic, copy) NSAttributedString *attributedContent;

@end
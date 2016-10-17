//
//  YDLTopThreeVIew.h
//  YuDao
//
//  Created by 汪杰 on 16/10/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListViewModel;

@protocol YDTopThreeViewDelegate <NSObject>

- (void)topThreeViewUserName:(NSString *)name;

@end

@interface YDLTopThreeView : UIView

@property (nonatomic, weak) id<YDTopThreeViewDelegate> delegate;

@property (nonatomic, strong) NSArray<ListViewModel *> *dataSource;

- (instancetype)initWithModelArray:(NSArray *)array;

@end

//
//  YDListCell.h
//  YuDao
//
//  Created by 汪杰 on 16/10/10.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDBaseCell.h"
@class ListViewModel;

@interface YDListCell : YDBaseCell

@property (nonatomic, strong) ListViewModel *model;

@end

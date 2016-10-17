//
//  YDPersonalDataController.h
//  YuDao
//
//  Created by 汪杰 on 16/10/17.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDViewController.h"
#import "InterestView.h"
@interface YDPersonalDataController : YDViewController

@property (nonatomic, strong) NSMutableArray *firstTableData;
@property (nonatomic, strong) NSMutableArray *secondTableData;
@property (nonatomic, strong) UIView *identifierView;
@property (nonatomic, strong) InterestView *inView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *selectedBtn;

@end

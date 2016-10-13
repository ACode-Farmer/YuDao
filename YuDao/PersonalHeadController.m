//
//  PersonalHeadController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/18.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "PersonalHeadController.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>

@interface PersonalHeadController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation PersonalHeadController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人头像";
    
    _scrollView = [UIScrollView new];
    [self.view addSubview:_scrollView];
    
    _scrollView.sd_layout
    .topSpaceToView(self.view,100)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,150);
    
    _headImageView = [UIImageView new];
    _headImageView.image = [UIImage imageNamed:@"icon1.jpg"];
    
    [_scrollView addSubview:_headImageView];
    _headImageView.sd_layout
    .topSpaceToView(_scrollView,0)
    .leftSpaceToView(_scrollView,0)
    .rightSpaceToView(_scrollView,0)
    .bottomSpaceToView(_scrollView,0);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"AlbumOperateMore"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

#pragma mark - Events
- (void)rightItemAction:(id)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"保存图片" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [alert addAction:action4];
    [self presentViewController:alert animated:YES completion:nil];
}


@end

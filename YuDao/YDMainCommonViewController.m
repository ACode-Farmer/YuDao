//
//  MainCommonViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMainCommonViewController.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
#import "YDMainViewConfigure.h"
@interface YDMainCommonViewController ()

@end

@implementation YDMainCommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [self.titleView viewWithTag:1001];
    titleLabel.text = self.mainTitle;
    // Do any additional setup after loading the view.
}

- (UIView *)titleView{
    if (!_titleView) {
        _titleView = [UIView new];
        _titleView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_titleView];
        _titleView.frame = CGRectMake(0, 0, screen_width, titleViewHeight);
//        _titleView.sd_layout
//        .topSpaceToView(self.view,0)
//        .leftSpaceToView(self.view,0)
//        .rightSpaceToView(self.view,0)
//        .heightRatioToView(self.view,0.2);
        
        UILabel *label = [UILabel new];
        label.tag = 1001;
        label.textColor = [UIColor orangeColor];
        UIView *leftLineView = [UIView new];
        leftLineView.backgroundColor = [UIColor blackColor];
        UIView *rightLineView = [UIView new];
        rightLineView.backgroundColor = [UIColor blackColor];
        [_titleView sd_addSubviews:@[label,leftLineView,rightLineView]];
        
        label.sd_layout
        .centerXEqualToView(_titleView)
        .centerYEqualToView(_titleView)
        .heightRatioToView(_titleView,0.8);
        [label setSingleLineAutoResizeWithMaxWidth:200];
        
        leftLineView.sd_layout
        .centerYEqualToView(_titleView)
        .rightSpaceToView(label,3)
        .widthRatioToView(_titleView,0.2)
        .heightIs(1);
        
        rightLineView.sd_layout
        .centerYEqualToView(_titleView)
        .leftSpaceToView(label,3)
        .widthRatioToView(_titleView,0.2)
        .heightIs(1);
    }
    return _titleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

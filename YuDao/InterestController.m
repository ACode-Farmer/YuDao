//
//  InterestController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "InterestController.h"
#import "GroupDetailController.h"
#import "InterestView.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
@interface InterestController ()

@property (nonatomic, strong) UIScrollView *scrView;

@end

@implementation InterestController
{
    InterestView *_inView1;
    InterestView *_inView2;
    InterestView *_inView3;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.optionalTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (![self.optionalTitle isEqualToString:@"个人兴趣"]) {
        self.navigationItem.rightBarButtonItem = ({
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction)];
            rightItem;
        });
    }
    
    _inView1 = [InterestView new];
    _inView2 = [InterestView new];
    _inView3 = [InterestView new];;
    NSArray *subViews = @[_inView1,_inView2,_inView3];
    for (UIView *view in subViews) {
        view.backgroundColor = [UIColor orangeColor];
        [self.scrView addSubview:view];
    }
    
    _inView1.sd_layout
    .topSpaceToView(self.scrView,0)
    .leftSpaceToView(self.scrView,0)
    .rightSpaceToView(self.scrView,0)
    ;
    
    _inView2.sd_layout
    .topSpaceToView(_inView1,10)
    .leftEqualToView(_inView1)
    .rightEqualToView(_inView1)
    ;
    
    _inView3.sd_layout
    .topSpaceToView(_inView2,10)
    .leftEqualToView(_inView2)
    .rightEqualToView(_inView2)
    ;
    
    [_inView1 addItems:@[@"腾讯",@"阿里巴巴",@"百度",@"谷歌(google)",@"这是一句用来测试的文本"]];
    [_inView2 addItems:@[@"腾讯",@"阿里巴巴",@"百度",@"谷歌(google)",@"这是一句用来测试的文本"]];
    [_inView3 addItems:@[@"这是一句用来测试的文本",@"腾讯",@"阿里巴巴",@"百度",@"谷歌(google)",@"这是一句用来测试的文本"]];
    
    [self.scrView setupAutoContentSizeWithBottomView:_inView3 bottomMargin:0];
    
}

- (UIScrollView *)scrView{
    if (!_scrView) {
        _scrView = [UIScrollView new];
        _scrView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrView];
        _scrView.sd_layout
        .spaceToSuperView(UIEdgeInsetsZero);
    }
    return _scrView;
}

- (void)rightBarButtonItemAction{
    [self.navigationController pushViewController:[GroupDetailController new] animated:YES];
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

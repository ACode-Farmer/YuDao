//
//  YDDynamicDetailController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDynamicDetailController.h"
#import "YDDynamicDetailController+Delegate.h"


@interface YDDynamicDetailController ()



@end

@implementation YDDynamicDetailController
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动态";
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.bottomView;
    
    [self.tableView registerClass:[YDDDContentCell class] forCellReuseIdentifier:YDDDContentCellID];
    [self.tableView registerClass:[YDDDCommentCell class] forCellReuseIdentifier:YDDDCommentCellID];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTableViewAction:)];
    [self.tableView addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}


#pragma mark - Events

- (void)rightBarButtonItemAction:(id)sender{
    AWActionSheet *sheet = [[AWActionSheet alloc] initWithIconSheetDelegate:self ItemCount:4];
    [sheet show];
}

- (void)tapTableViewAction:(UIGestureRecognizer *)tap{
    [self.bottomView.textView resignFirstResponder];
    self.kKeybordHeight = 0;
}

- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    self.kKeybordHeight = rect.size.height;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0]];
    CGRect cellRect = [cell.superview convertRect:cell.frame toView:window];
    CGFloat delta = CGRectGetMaxY(cellRect) - (window.bounds.size.height - rect.size.height)+60;
    
    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    
    [self.tableView setContentOffset:offset animated:YES];
}


#pragma mark - Private Methods



#pragma mark - Getter
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {

        YDDDContentModel *model = [YDDDContentModel new];
        model.imageArray = @[@"head0.jpg",@"head1.jpg"];
        model.location = @"不知道在哪里!";
        model.title = @"就是突然想发个动态!";
        model.content = @"就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!就是突然想发个动态!";
        
        YDDDNormalModel *model1 = [YDDDNormalModel new];
        model1.imageName = @"head1.jpg";
        model1.title = @"Simon";
        model1.subTitle = @"今天天气阔以哦!";
        
        _dataArray = [NSMutableArray arrayWithObjects:model,model1,model1,model1, nil];
    }
    return _dataArray;
}

- (YDDDHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [[YDDDHeaderView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 80)];
        [_headerView updateHeaderView:@"head0.jpg" userName:@"来啊来啊!" genderImage:@"head1.jpg" level:@"V5" time:@"一小时前"];
    }
    return _headerView;
}

- (YDDDBottomView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[YDDDBottomView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 60)];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

- (NSArray *)shareArray{
    if (_shareArray == nil) {
        _shareArray = @[@{@"imageName":@"head0.jpg", @"title":@"好友"},
                        @{@"imageName":@"head0.jpg", @"title":@"群组"},
                        @{@"imageName":@"head0.jpg", @"title":@"动态"},
                        @{@"imageName":@"head0.jpg", @"title":@"微博"},
                        @{@"imageName":@"head0.jpg", @"title":@"微信"},
                        @{@"imageName":@"head0.jpg", @"title":@"微信朋友圈"},
                        @{@"imageName":@"head0.jpg", @"title":@"QQ"},
                        @{@"imageName":@"head0.jpg", @"title":@"QQ空间"}];
    }
    return _shareArray;
}

@end

//
//  YDListViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDListViewController.h"
#import "YDMainTitleView.h"
#import "YDLTopThreeView.h"
#import "YDListTableView.h"
#import "YDMainViewConfigure.h"
#import "ListViewModel.h"
#import "RankingListTableViewController.h"

@interface YDListViewController ()<YDListTableViewDelegate>

@property (nonatomic, strong) YDMainTitleView *titleView;

@property (nonatomic, strong) YDLTopThreeView *topThreeView;

@property (nonatomic, strong) YDListTableView *listTableView;

@property (nonatomic, strong) NSMutableArray *topThreeDataArray;

@property (nonatomic, strong) NSMutableArray *fourToTenDataArray;

@end

@implementation YDListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.topThreeView];
    [self.view addSubview:self.listTableView];
    [self.view setupAutoHeightWithBottomView:self.listTableView bottomMargin:0];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma - mark Actions
- (void)allListBtnAction:(UIButton *)sender{
    [self.navigationController pushViewController:[RankingListTableViewController new] animated:YES];
}

#pragma - mark Custom Delegate
- (void)ListTableViewWithName:(NSString *)name{
    NSLog(@"name = %@",name);
}

#pragma mark - lazy load

- (NSMutableArray *)topThreeDataArray{
    if (!_topThreeDataArray) {
        _topThreeDataArray = [NSMutableArray arrayWithCapacity:3];
        ListViewModel *model1 = [ListViewModel modelWithPlacing:@"2" imageName:@"head1.jpg" name:@"Hight起来" grade:@"5" sign:@"白羊" type:@"自驾" isAttention:NO];
        ListViewModel *model2 = [ListViewModel modelWithPlacing:@"1" imageName:@"head1.jpg" name:@"Hight起来" grade:@"5" sign:@"白羊" type:@"自驾" isAttention:YES];
        ListViewModel *model3 = [ListViewModel modelWithPlacing:@"3" imageName:@"head1.jpg" name:@"Hight起来" grade:@"5" sign:@"白羊" type:@"自驾" isAttention:NO];
        [_topThreeDataArray addObject:model1];
        [_topThreeDataArray addObject:model2];
        [_topThreeDataArray addObject:model3];
    }
    return _topThreeDataArray;
}

- (NSMutableArray *)fourToTenDataArray{
    if (!_fourToTenDataArray) {
        _fourToTenDataArray = [NSMutableArray arrayWithCapacity:7];
        ListViewModel *model1 = [ListViewModel modelWithPlacing:@"4" imageName:@"head1.jpg" name:@"Hight起来" grade:@"5" sign:@"白羊" type:@"自驾" isAttention:NO];
        ListViewModel *model2 = [ListViewModel modelWithPlacing:@"5" imageName:@"head1.jpg" name:@"Hight起来" grade:@"5" sign:@"白羊" type:@"自驾" isAttention:YES];
        ListViewModel *model3 = [ListViewModel modelWithPlacing:@"6" imageName:@"head1.jpg" name:@"Hight起来" grade:@"5" sign:@"白羊" type:@"自驾" isAttention:NO];
        ListViewModel *model4 = [ListViewModel modelWithPlacing:@"7" imageName:@"head1.jpg" name:@"Hight起来" grade:@"5" sign:@"白羊" type:@"自驾" isAttention:NO];
        ListViewModel *model5 = [ListViewModel modelWithPlacing:@"8" imageName:@"head1.jpg" name:@"Hight起来" grade:@"5" sign:@"白羊" type:@"自驾" isAttention:YES];
        ListViewModel *model6 = [ListViewModel modelWithPlacing:@"9" imageName:@"head1.jpg" name:@"Hight起来" grade:@"5" sign:@"白羊" type:@"自驾" isAttention:NO];
        ListViewModel *model7 = [ListViewModel modelWithPlacing:@"10" imageName:@"head1.jpg" name:@"Hight起来" grade:@"5" sign:@"白羊" type:@"自驾" isAttention:NO];
        [_fourToTenDataArray addObject:model1];
        [_fourToTenDataArray addObject:model2];
        [_fourToTenDataArray addObject:model3];
        [_fourToTenDataArray addObject:model4];
        [_fourToTenDataArray addObject:model5];
        [_fourToTenDataArray addObject:model6];
        [_fourToTenDataArray addObject:model7];
    }
    return _fourToTenDataArray;
}

- (YDMainTitleView *)titleView{
    if (!_titleView) {
        _titleView = [YDMainTitleView new];
        _titleView.frame = CGRectMake(0, 0, screen_width, kTitleViewHeight);
        [_titleView setTitle:@"排行榜" leftBtnImage:@"Icon-60" rightBtnImage:@"Icon-60"];
    }
    return _titleView;
}

- (YDLTopThreeView *)topThreeView{
    if (!_topThreeView) {
        _topThreeView = [[YDLTopThreeView alloc] initWithModelArray:self.topThreeDataArray];
        _topThreeView.frame = CGRectMake(0, CGRectGetMaxY(self.titleView.frame)+8*widthHeight_ratio, screen_width, 188*widthHeight_ratio);
    }
    return _topThreeView;
}

- (YDListTableView *)listTableView{
    if (!_listTableView) {
        _listTableView = [[YDListTableView alloc] initWithDataSource:self.fourToTenDataArray];
        _listTableView.frame = CGRectMake(0, CGRectGetMaxY(self.topThreeView.frame) + 8*widthHeight_ratio, screen_width, 7*_listTableView.rowHeight+106 * widthHeight_ratio);
        _listTableView.listTableViewDelegate = self;
        
        _listTableView.tableFooterView = ({
            UIView *view = [UIView new];
            view.frame = CGRectMake(0, 0, screen_width, 106 * widthHeight_ratio);
            UIButton *allListBtn = [UIButton new];
            [allListBtn setBackgroundImage:[UIImage imageNamed:@"allListBtnIcon"] forState:0];
            [allListBtn addTarget:self action:@selector(allListBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:allListBtn];
            allListBtn.sd_layout
            .centerXEqualToView(view)
            .centerYEqualToView(view)
            .widthIs(306*widthHeight_ratio)
            .heightIs(50*widthHeight_ratio);
            view;
        });
    }
    return _listTableView;
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

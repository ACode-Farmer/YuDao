//
//  YDPersonalDataController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/17.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDPersonalDataController.h"
#import "YDPersonalDataController+Delegate.h"
#import "YDPersonalHeaderView.h"
#import "UIButton+ImageTitleSpacing.h"
#import "UIView+Frame.h"
#import "YDPersonalTableView.h"
#import "YDPTimeAxisModel.h"

@interface YDPersonalDataController ()

@property (nonatomic, strong) YDPersonalHeaderView *headerView;
@property (nonatomic, strong) UIView *labelView;
@property (nonatomic, strong) UIScrollView *scrolleView;
@property (nonatomic, strong) UITableView *firstTable;
@property (nonatomic, strong) YDPersonalTableView *secondTable;



@end

@implementation YDPersonalDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *subviews = @[self.headerView,self.labelView,self.scrolleView];
    [self.view sd_addSubviews:subviews];
    [self.scrolleView addSubview:self.firstTable];
    [self.scrolleView addSubview:self.secondTable];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

#pragma mark - Events
- (void)typeButtonAction:(UIButton *)sender{
   
    if (sender == self.selectedBtn ) {
        return;
    }else{
        CGPoint offset = self.scrolleView.contentOffset;
        if ([sender.titleLabel.text isEqualToString:@"资料"]) {
            offset.x = 0;
        }else{
            offset.x = screen_width;
        }
        [self.scrolleView setContentOffset:offset animated:YES];
    }
}

#pragma mark - Getters
- (YDPersonalHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [YDPersonalHeaderView new];
        _headerView.frame = CGRectMake(0, 64, screen_width, 200*widthHeight_ratio);
    }
    return _headerView;
}

- (UIView *)labelView{
    if (!_labelView) {
        _labelView = [UIView new];
        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), screen_width, 40);
        _labelView.frame = frame;
        
        UIButton *leftBtn = [UIButton new];
        leftBtn.frame = CGRectMake(10, 0, 60, frame.size.height);
        [leftBtn setTitle:@"资料" forState:0];
        [leftBtn setTitleColor:[UIColor blackColor] forState:0];
        [leftBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        leftBtn.selected = YES;
        [leftBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.leftBtn = leftBtn;
        self.selectedBtn = self.leftBtn;
        
        UIButton *rightBtn = [UIButton new];
        rightBtn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame)+5, 0, 60, frame.size.height);
        [rightBtn setTitle:@"动态" forState:0];
        [rightBtn setTitleColor:[UIColor blackColor] forState:0];
        [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [rightBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.rightBtn = rightBtn;
        
        [_labelView sd_addSubviews:@[leftBtn,rightBtn]];
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor colorGrayLine];
        lineView.frame = CGRectMake(0, frame.size.height-0.5, screen_width, 0.5);
        [_labelView addSubview:lineView];
    }
    return _labelView;
}

- (UIScrollView *)scrolleView{
    if (!_scrolleView) {
        _scrolleView = [UIScrollView new];
        _scrolleView.pagingEnabled = YES;
        _scrolleView.frame = CGRectMake(0, CGRectGetMaxY(self.labelView.frame), screen_width, screen_height - CGRectGetMaxY(self.labelView.frame));
        _scrolleView.contentSize = CGSizeMake(2*screen_width, _scrolleView.bounds.size.height);
        _scrolleView.delegate = self;
    }
    return _scrolleView;
}

- (UITableView *)firstTable{
    if (!_firstTable) {
        _firstTable = [UITableView new];
        _firstTable.frame = CGRectMake(0, 0, screen_width, self.scrolleView.bounds.size.height);
        _firstTable.backgroundColor = [UIColor whiteColor];
        _firstTable.tableFooterView = [UIView new];
        _firstTable.dataSource = self;
        _firstTable.delegate =  self;
        
        [_firstTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"YDPSecondSectionCell"];
        [_firstTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"YDPThirdSectionCell"];
        [_firstTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"YDPFourthSectionCell"];
        [_firstTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"YDPTitleCell"];
    }
    return _firstTable;
}

- (YDPersonalTableView *)secondTable{
    if (!_secondTable) {
        CGRect frame = CGRectMake(screen_width, 0, screen_width, self.scrolleView.bounds.size.height);
        _secondTable = [[YDPersonalTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        
        YDPTimeAxisModel *model1 = [YDPTimeAxisModel new];
        model1.time = @"1小时前";
        model1.name = @"Candy";
        model1.picArray = [NSMutableArray arrayWithObjects:@"speed_car.png", nil];
        model1.content = @"今天玩的很开心!";
        model1.likeBtnTitle = @"66";
        model1.commentBtnTitle = @"11";
        
        YDPTimeAxisModel *model2 = [YDPTimeAxisModel new];
        model2.time = @"一天前";
        model2.name = @"Candy";
        model2.picArray = [NSMutableArray arrayWithObjects:@"head2.jpg",@"head3.jpg",@"head4.jpg",@"head0.jpg", nil];
        model2.content = @"今天玩的很开心!";
        model2.likeBtnTitle = @"10";
        model2.commentBtnTitle = @"9";
        
        YDPTimeAxisModel *model3 = [YDPTimeAxisModel new];
        model3.time = @"3天前";
        model3.name = @"Candy";
        model3.picArray = [NSMutableArray arrayWithObjects:@"test0.jpg",@"head1.jpg", nil];
        model3.content = @"今天玩的很开心!";
        model3.likeBtnTitle = @"1";
        model3.commentBtnTitle = @"0";
        
        YDPTimeAxisModel *model4 = [YDPTimeAxisModel new];
        model4.time = @"3天前";
        model4.name = @"Candy";
        model4.picArray = [NSMutableArray arrayWithObjects:@"test0.jpg",@"head1.jpg", nil];
        model4.content = @"今天玩的很开心!";
        model4.likeBtnTitle = @"1";
        model4.commentBtnTitle = @"0";
        
        YDPTimeAxisModel *model5 = [YDPTimeAxisModel new];
        model5.time = @"3天前";
        model5.name = @"Candy";
        model5.picArray = [NSMutableArray arrayWithObjects:@"test0.jpg",@"head1.jpg", nil];
        model5.content = @"今天玩的很开心!";
        model5.likeBtnTitle = @"1";
        model5.commentBtnTitle = @"0";
        
        _secondTable.data = [NSMutableArray arrayWithObjects:model1,model2,model3,model4,model5, nil];
    }
    return _secondTable;
}

- (UIView *)identifierView{
    if (!_identifierView) {
        _identifierView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, screen_width, 100*widthHeight_ratio)];
        NSArray *array = @[@"头像认证",@"视频认证",@"支付宝认证",@"车辆认证",@"OBD认证"];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [UIButton new];
            [button setTitle:obj forState:0];
            [button setTitleColor:[UIColor blackColor] forState:0];
            [button setImage:[UIImage imageNamed:@"mine_gou"] forState:0];
            [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
            button.titleLabel.textAlignment = NSTextAlignmentLeft;
            [button.titleLabel setFont:[UIFont font_13]];
            button.contentMode = UIViewContentModeCenter;
            [_identifierView addSubview:button];
            button.height = _identifierView.height/2;
            button.width = screen_width/3;
            [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
            if (idx <= 2) {
                button.x = idx * button.width-15;
                button.y = 0;
            }else{
                button.x = (idx - 3) * button.width-15;
                button.y = button.height;
            }
        }];
    }
    return _identifierView;
}

- (NSMutableArray *)firstTableData{
    if (!_firstTableData) {
        _firstTableData = [NSMutableArray arrayWithObjects:@{@"id":@"1000000"},
                           @{@"星座":@"白羊座"},
                           @{@"感情状态":@"单身"},
                           @{@"常出没地点":@"上海  闵行"},
                           @{@"爱车":@"BMW  530li"},
                           nil];
       
    }
    return _firstTableData;
}
@end

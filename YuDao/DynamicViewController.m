//
//  DynamicViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "DynamicViewController.h"
#import "YDMainTitleView.h"
#import "XRWaterfallLayout.h"
#import "XRCollectionViewCell.h"
#import "YDMainViewConfigure.h"
#import "YDDynamicCell.h"
#import "YDDModel.h"
#import "DynamicTableViewController.h"
#import "YDDynamicDetailController.h"

static NSString *const YDDynamicCellIdentifier = @"YDDynamicCell";

@interface DynamicViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) YDMainTitleView *titleView;
@property (nonatomic, strong) UIButton *allDynamicBtn;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleView];
    
    [self.view addSubview:self.collectionView];
    
    
    [self.view addSubview:self.allDynamicBtn];
    self.allDynamicBtn.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.collectionView,10)
    .widthRatioToView(self.view,0.7)
    .heightIs(40);
    
    [self.view setupAutoHeightWithBottomView:self.allDynamicBtn bottomMargin:5];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

#pragma mark - Events

- (void)allDynamicBtnAction:(UIButton *)sender{
    [self.navigationController firstLevel_push_fromViewController:self toVC:[DynamicTableViewController new]];
}


#pragma mark collectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource? self.dataSource.count:0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YDDynamicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YDDynamicCellIdentifier forIndexPath:indexPath];
//    cell.imageView.image = [UIImage imageNamed:self.dataSource[indexPath.row]];
//    cell.label.text = self.dataSource[indexPath.row];
    YDDModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YDDynamicDetailController *detailVC = [YDDynamicDetailController new];
    if (self.delegate && [self.delegate respondsToSelector:@selector(YDDynamicViewControllerPushToVC:index:)]) {
        [self.delegate YDDynamicViewControllerPushToVC:detailVC index:indexPath.row];
    }
    
}

- (void)collectionContentHeight{
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0]];
    NSLog(@"height = %f",CGRectGetMaxY(cell.frame));
}


#pragma mark lazy load -
- (YDMainTitleView *)titleView{
    if (!_titleView) {
        _titleView = [YDMainTitleView new];
        _titleView.frame = CGRectMake(0, 0, screen_width, kTitleViewHeight);
        [_titleView setTitle:@"动态" leftBtnImage:@"dynomic_leaf" rightBtnImage:@"more"];
    }
    return _titleView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        //创建瀑布流布局
        XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
        //一次性设置
        [waterfall setColumnSpacing:10 rowSpacing:10 sectionInset:UIEdgeInsetsMake(0, 10, 10, 10)];
        __weak DynamicViewController *weakSelf = self;
        __weak XRWaterfallLayout *weakFall = waterfall;
        [waterfall setItemHeightBlock:^CGFloat(CGFloat itemWidth, NSIndexPath * indexPath) {
            
            YDDModel *model = weakSelf.dataSource[indexPath.row];
            UIImage *image = [UIImage imageNamed:model.imageName];
            CGSize size = [image size];
            if (indexPath.row == weakSelf.dataSource.count-1) {
                weakSelf.collectionView.height = [weakFall collectionViewContentSize].height+120;
                [weakSelf.view layoutIfNeeded];
            }
            
            return size.height / size.width * itemWidth+100;
        }];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), screen_width, screen_height) collectionViewLayout:waterfall];
        _collectionView.backgroundColor = [UIColor colorWithString:@"#dcdcdc"];
        _collectionView.scrollEnabled = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"XRCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[YDDynamicCell class] forCellWithReuseIdentifier:YDDynamicCellIdentifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (UIButton *)allDynamicBtn{
    if (!_allDynamicBtn) {
        _allDynamicBtn = [UIButton new];
        _allDynamicBtn.sd_cornerRadiusFromHeightRatio = @0.5;
        _allDynamicBtn.layer.borderWidth = 1;
        _allDynamicBtn.layer.borderColor = [UIColor colorWithString:@"#8159aa"].CGColor;
        [_allDynamicBtn setTitle:@"查看全部动态" forState:0];
        [_allDynamicBtn setTitleColor:[UIColor blackColor] forState:0];
        _allDynamicBtn.backgroundColor = [UIColor yellowColor];
        [_allDynamicBtn addTarget:self action:@selector(allDynamicBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allDynamicBtn;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (NSInteger i = 0; i<5; i++) {
            YDDModel *model = [YDDModel modelWithImageName:[NSString stringWithFormat:@"head%ld.jpg",(long)i] number:@"999看过" time:@"刚刚" name:@"互相伤害" content:@"万事开头难,中间难,结尾更难" placeImageName:@"locationIcon" place:@"金沙江路"];
            [_dataSource addObject:model];
        }
        for (NSInteger i = 0; i<8; i++) {
            YDDModel *model = [YDDModel modelWithImageName:[NSString stringWithFormat:@"test%ld.jpg",(long)i] number:@"999看过" time:@"刚刚" name:@"互相伤害" content:@"万事开头难,中间难,结尾更难" placeImageName:@"locationIcon" place:@"金沙江路"];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}


@end

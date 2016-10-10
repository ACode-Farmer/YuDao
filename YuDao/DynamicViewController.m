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

static NSString *const YDDynamicCellIdentifier = @"YDDynamicCell";

@interface DynamicViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) YDMainTitleView *titleView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleView];
    
    [self.view addSubview:self.collectionView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark collectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource? self.dataSource.count:0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YDDynamicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YDDynamicCellIdentifier forIndexPath:indexPath];
//    cell.imageView.image = [UIImage imageNamed:self.dataSource[indexPath.row]];
//    cell.label.text = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld %ld",(long)indexPath.section,(long)indexPath.row);
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
        [_titleView setTitle:@"动态" leftBtnImage:@"Icon-60" rightBtnImage:@"Icon-60"];
    }
    return _titleView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        //创建瀑布流布局
        XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
        //一次性设置
        [waterfall setColumnSpacing:10 rowSpacing:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
        __weak DynamicViewController *weakSelf = self;
        [waterfall setItemHeightBlock:^CGFloat(CGFloat itemWidth, NSIndexPath * indexPath) {
            UIImage *image = [UIImage imageNamed:weakSelf.dataSource[indexPath.row]];
            CGSize size = [image size];
            return size.height / size.width * itemWidth;
        }];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), screen_width, 3*screen_height) collectionViewLayout:waterfall];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"XRCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[YDDynamicCell class] forCellWithReuseIdentifier:YDDynamicCellIdentifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (NSInteger i = 0; i<5; i++) {
            NSString *imageName = [NSString stringWithFormat:@"head%ld.jpg",(long)i];
            [_dataSource addObject:imageName];
        }
        for (NSInteger i = 0; i<9; i++) {
            NSString *imageName = [NSString stringWithFormat:@"test%ld.jpg",(long)i];
            [_dataSource addObject:imageName];
        }
    }
    return _dataSource;
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

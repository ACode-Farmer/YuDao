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

@interface DynamicViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) YDMainTitleView *titleView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleView];
    //创建瀑布流布局
    XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
    //设置各属性的值
    //waterfall.rowSpacing = 10;
    //waterfall.columnSpacing = 10;
    //waterfall.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //一次性设置
    [waterfall setColumnSpacing:10 rowSpacing:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    __weak DynamicViewController *weakSelf = self;
    [waterfall setItemHeightBlock:^CGFloat(CGFloat itemWidth, NSIndexPath * indexPath) {
        UIImage *image = [UIImage imageNamed:weakSelf.dataSource[indexPath.row]];
        CGSize size = [image size];
        return size.height / size.width * itemWidth;
    }];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), screen_width, 3*screen_height) collectionViewLayout:waterfall];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"XRCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
}

#pragma mark lazy load -
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

#pragma mark collectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource? self.dataSource.count:0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.dataSource[indexPath.row]];
    cell.label.text = self.dataSource[indexPath.row];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (YDMainTitleView *)titleView{
    if (!_titleView) {
        _titleView = [YDMainTitleView new];
        [_titleView setTitle:@"动态" leftBtnImage:@"AppIcon" rightBtnImage:@"AppIcon"];
    }
    return _titleView;
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

//
//  DynamicViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "DynamicViewController.h"
#import "XRWaterfallLayout.h"
#import "XRCollectionViewCell.h"

@interface DynamicViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,XRWaterfallLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTitle = @"动态";
    //标题
    UILabel *titleLabel = [self.titleView viewWithTag:1001];
    titleLabel.text = self.mainTitle;
    
    //创建瀑布流布局
    XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
    //设置各属性的值
    //    waterfall.rowSpacing = 10;
    //    waterfall.columnSpacing = 10;
    //    waterfall.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //或者一次性设置
    [waterfall setColumnSpacing:10 rowSpacing:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    //设置代理，实现代理方法
    waterfall.delegate = self;
    
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

#pragma mark XRWaterfallLayoutDelegate -
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
    UIImage *image = [UIImage imageNamed:self.dataSource[indexPath.row]];
    CGSize size = [image size];
    return size.height / size.width * itemWidth;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

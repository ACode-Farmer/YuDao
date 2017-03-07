//
//  YDSlipFaceController.m
//  YuDao
//
//  Created by 汪杰 on 2017/1/16.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import "YDSlipFaceController.h"
#import "YDSlipFaceModel.h"
#import "YDCustomCardView.h"
#import "CCDraggableContainer.h"
#import "YDUserFilesController.h"

#define kSlipFaceUrl [kOriginalURL stringByAppendingString:@"faceswiping"]

//static NSInteger kAllImageCount = 0;

//static NSInteger kRemainingCount = 5;

@interface YDSlipFaceController ()<CCDraggableContainerDataSource, CCDraggableContainerDelegate>

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) CCDraggableContainer *container;

@property (nonatomic, strong) NSArray  *cardData;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIImageView *backgroundImageV;

@end

@implementation YDSlipFaceController
{
    NSInteger _loc;
    NSInteger _len;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"刷脸";
    _loc = -1;
    _len = 10;
    //self.view.backgroundColor = [UIColor colorWithString:@"#EBEBEB"];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    effectView.frame = CGRectMake(0, 0, screen_width, screen_height-64);
    self.backgroundImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-64)];
    self.backgroundImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.backgroundImageV];
    [self.view addSubview:effectView];
    
    self.container = [[CCDraggableContainer alloc] initWithFrame:CGRectMake(0, 10, CCWidth, CCWidth*1.26) style:CCDraggableStyleUpOverlay];
    self.container.delegate = self;
    self.container.dataSource = self;
    [self.view addSubview:self.container];
    
    
    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.rightButton];
    
    [self downloadSlipFaceData];
    
    //UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(slipFaceRightBarItemAction:)];
    
    //[self.navigationItem setRightBarButtonItem:rightBarItem];
    
    
}

//MARK:点击筛选
- (void)slipFaceRightBarItemAction:(UIBarButtonItem *)rightBarItem{
    NSLog(@"点击筛选");
}

//MARK:下载刷脸数据
- (void)downloadSlipFaceData{
    NSString *lon = [NSString stringWithFormat:@"%f",[YDCurrentLocation shareCurrentLocation].coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",[YDCurrentLocation shareCurrentLocation].coordinate.latitude];
    NSString *location = [lon stringByAppendingString:[NSString stringWithFormat:@",%@",lat]];
    NSDictionary *parameters = @{@"access_token":[YDUserDefault defaultUser].user.access_token,
                                 @"ud_location":location};
    YDWeakSelf(self);
    [YDNetworking getUrl:kSlipFaceUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *originDic = [responseObject mj_JSONObject];
        NSLog(@"originDic = %@",originDic);
        weakself.data = [YDSlipFaceModel mj_objectArrayWithKeyValuesArray:[originDic objectForKey:@"data"]];
        if (weakself.data.count > 0) {
            YDSlipFaceModel *model = weakself.data.firstObject;
            [weakself.backgroundImageV sd_setImageWithURL:[NSURL URLWithString:model.ud_face] placeholderImage:[UIImage imageNamed:@"default_user_image"]];
        }
        [weakself.container reloadData];
        //[weakself loadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"刷脸数据请求失败error = %@",error);
    }];
}
//喜欢这个人
- (void)likePersonAction:(NSInteger )index{
    if (!YDHadLogin) {
        [self presentViewController:[YDLoginViewController new] animated:YES completion:^{
            
        }];
        return;
    }
    
    YDSlipFaceModel *model = [self.data objectAtIndex:index];
    NSDictionary *parameters = @{@"access_token":[YDUserDefault defaultUser].user.access_token,
                                 @"ub_id":model.ub_id};
    NSLog(@"parameters = %@",parameters);
    [YDNetworking postUrl:kAddLikeUserURL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"刷脸——喜欢——%@",[responseObject mj_JSONObject]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"刷脸——喜欢——失败--%@",error);
    }];
}

#pragma mark - Events
- (void)slipFaceLeftButtonAction:(UIButton *)leftBtn{
    [self.container removeFormDirection:CCDraggableDirectionLeft];
}

- (void)slipFaceRightButtonAction:(UIButton *)rightBtn{
    
    [self.container removeFormDirection:CCDraggableDirectionRight];
}

#pragma mark - CCDraggableContainer DataSource

- (CCDraggableCardView *)draggableContainer:(CCDraggableContainer *)draggableContainer viewForIndex:(NSInteger)index {
    YDCustomCardView *cardView = [[YDCustomCardView alloc] initWithFrame:draggableContainer.bounds];
    [cardView setModel:self.data[index]];
    return cardView;
}

- (NSInteger)numberOfIndexs {
    return self.data? self.data.count : 0;
}

#pragma mark - CCDraggableContainer Delegate
- (void)draggableContainer:(CCDraggableContainer *)draggableContainer draggableDirection:(CCDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio {
    
    CGFloat scale = 1 + ((kBoundaryRatio > fabs(widthRatio) ? fabs(widthRatio) : kBoundaryRatio)) / 4;
    if (draggableDirection == CCDraggableDirectionLeft) {
        self.leftButton.transform = CGAffineTransformMakeScale(scale, scale);
    }
    if (draggableDirection == CCDraggableDirectionRight) {
        self.rightButton.transform = CGAffineTransformMakeScale(scale, scale);
    }
}


//点击图片
- (void)draggableContainer:(CCDraggableContainer *)draggableContainer cardView:(CCDraggableCardView *)cardView didSelectIndex:(NSInteger)didSelectIndex {
    YDSlipFaceModel *model = [self.data objectAtIndex:didSelectIndex];
    YDUserFilesController *userVC = [YDUserFilesController new];
    userVC.currentUserId = model.ub_id;
    [self.navigationController pushViewController:userVC animated:YES];
    NSLog(@"点击了Tag为%ld的Card", (long)didSelectIndex);
    
}
//图片被滑完时调用
- (void)draggableContainer:(CCDraggableContainer *)draggableContainer finishedDraggableLastCard:(BOOL)finishedDraggableLastCard {
    
//    [self loadData];
//    [draggableContainer reloadData];
}
//滑动结束
- (void)draggableContainer:(CCDraggableContainer *)draggableContainer
finishedDraggableCardIndex:(NSInteger )index{
    NSInteger backgroundImageIndx = 0;
    if (index+1 == self.data.count) {
        backgroundImageIndx = index;
    }else{
        backgroundImageIndx = index+1;
    }
    YDSlipFaceModel *model = [self.data objectAtIndex:backgroundImageIndx];
    [self.backgroundImageV sd_setImageWithURL:[NSURL URLWithString:model.ud_face] placeholderImage:[UIImage imageNamed:@"default_user_image"]];
    if (draggableContainer.direction == CCDraggableDirectionRight) {
        [self likePersonAction:index];
    }
    NSLog(@"draggableContainer.direction = %ld",draggableContainer.direction);
}
//加载更多数据
- (void)loadData{
    _loc ++;
    if ((_loc*_len) == _data.count || (_loc*_len) > _data.count) {
        NSLog(@"数据已加载完了!");
        return;
    }
    
    NSRange range;
    if ((_loc+1)*_len > _data.count) {
        NSLog(@"数据不够十个了");
        range = NSMakeRange(_loc*_len, _data.count-(_loc*_len));
        
    }else{
        range = NSMakeRange(_loc*_len, _len);
        
    }
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:range];
    _cardData = [NSArray arrayWithArray:[_data objectsAtIndexes:indexes]];
    
    [_container reloadData];
}

- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [YDUIKit buttonWithImage:[UIImage imageNamed:@"discover_slipFace_hate"]  target:self];
        CGSize size = [UIImage imageNamed:@"discover_slipFace_hate"].size;
        _leftButton.frame = CGRectMake(CGRectGetMinX(self.container.frame)+45, CGRectGetMaxY(self.container.frame)+kHeight(25), size.width, size.height);
        [_leftButton addTarget:self action:@selector(slipFaceLeftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [YDUIKit buttonWithImage:[UIImage imageNamed:@"discover_slipFace_like"]  target:self];
        CGSize size = [UIImage imageNamed:@"discover_slipFace_like"].size;
        _rightButton.frame = CGRectMake(CGRectGetMaxX(self.container.frame)-size.width-45, CGRectGetMaxY(self.container.frame)+kHeight(25), size.width, size.height);
        [_rightButton addTarget:self action:@selector(slipFaceRightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

@end

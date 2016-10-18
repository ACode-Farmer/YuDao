//
//  YDMGroupDetailViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/15.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMGroupDetailViewController.h"
#import "AWActionSheet.h"
#import "YDMGroupDetailViewController+Delegate.h"
#import "ChangeImageController.h"
#import "GroupController.h"

@interface YDMGroupDetailViewController ()

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIView *bottomView;



@end

@implementation YDMGroupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:self.rightBarButtonTitle style:UIBarButtonItemStylePlain target:self action:@selector(rightBarbuttonAction:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    self.tableView.tableHeaderView = self.headerImageView;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"YDMTitleCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"YDMFirstCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"YDMSecondCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"YDMThirdCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"YDMFourthCell"];
    
    self.tableView.tableFooterView = self.bottomView;
//    [self.tableView addSubview:self.bottomView];
//    [self.view bringSubviewToFront:self.bottomView];
//    self.bottomView.sd_layout
//    .leftSpaceToView(self.tableView,0)
//    .rightSpaceToView(self.tableView,0)
//    .topSpaceToView(self.tableView,0)
//    .heightIs(40*widthHeight_ratio);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self updateHeaderView:self.headerImageView];
}

#pragma mark - Events
- (void)rightBarbuttonAction:(UIBarButtonItem *)sender{
    if (self.groupType == YDGroupDetailTypeNew) {
        NSArray *controllers = self.navigationController.viewControllers;
        for (UIViewController *vc in controllers) {
            if ([vc isKindOfClass:[GroupController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
    }else{
        AWActionSheet *sheet = [[AWActionSheet alloc] initWithIconSheetDelegate:self ItemCount:4];
        [sheet show];
    }
}

- (void)tapAction:(id)sender{
    [self userImageBtnAction:nil];
}

- (void)userImageBtnAction:(UIButton *)sender{
    NSString *title = nil;
    if (sender) {
        title = @"更换头像";
    }else{
        title = @"更换封面背景";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *one = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ChangeImageController *changeVC = [ChangeImageController new];
        changeVC.optionalTitle = title;
        [self.navigationController firstLevel_push_fromViewController:self toVC:changeVC];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:one];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)updateHeaderView:(UIImageView *)imageView{
    //根据进入界面的权限不同，限制是否可操作背景和头像
    if (self.groupType == YDGroupDetailTypeNew || self.groupType == YDGroupDetailTypeMine) {
        _headerImageView.userInteractionEnabled = YES;
    }else{
        _headerImageView.userInteractionEnabled = NO;
    }
    
    imageView.image = [UIImage imageNamed:@"test0.jpg"];
    UIButton *imageBtn = [imageView viewWithTag:101];
    UILabel *label = [imageView viewWithTag:102];
    
    [imageBtn setImage:[UIImage imageNamed:@"test8.jpg"] forState:0];
    [imageBtn setImage:[UIImage imageNamed:@"test8.jpg"] forState:UIControlStateHighlighted];
    
    label.text = @"今晚猎个痛快";
    
}

#pragma mark - Getters
- (UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [UIImageView new];
        _headerImageView.frame = CGRectMake(0, 0, screen_width, 200*widthHeight_ratio);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_headerImageView addGestureRecognizer:tap];
        
        UIView *backView = [UIView new];
        backView.backgroundColor = [UIColor colorGrayBG];
        backView.alpha = 0.5f;
        UIButton *imageBtn = [UIButton new];
        imageBtn.tag = 101;
        [imageBtn addTarget:self action:@selector(userImageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label = [UILabel new];
        label.tag = 102;
        
        NSArray *views = @[backView,imageBtn,label];
        [_headerImageView sd_addSubviews:views];
        [self.view addSubview:_headerImageView];
        
        backView.sd_layout
        .leftSpaceToView(_headerImageView,0)
        .bottomSpaceToView(_headerImageView,0)
        .widthIs(screen_width)
        .heightIs(50);
        
        imageBtn.sd_layout
        .leftSpaceToView(_headerImageView,10)
        .bottomEqualToView(backView)
        .widthIs(80)
        .heightIs(80);
        imageBtn.sd_cornerRadius = @40;
        
        label.sd_layout
        .centerYEqualToView(backView)
        .leftSpaceToView(imageBtn,10)
        .rightEqualToView(backView)
        .heightIs(21);
        
    }
    return _headerImageView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.frame = CGRectMake(0, 0, screen_width, 40);
        UIView *lineView = [UIView new];
        lineView.frame = CGRectMake(0, 0, screen_width, 1);
        lineView.backgroundColor = [UIColor colorGrayLine];
        [_bottomView addSubview:lineView];
        {
            UIButton *oneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            oneBtn.frame = CGRectMake(0, 0, screen_width/2-0.5, 40);
            oneBtn.backgroundColor = [UIColor clearColor];
            [oneBtn setTitleColor:[UIColor blackColor] forState:0];
            [oneBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            if (self.groupType == YDGroupDetailTypeJoined || self.groupType == YDGroupDetailTypeMine || self.groupType == YDGroupDetailTypeNew) {
                [oneBtn setTitle:@"发消息" forState:0];
            }else if (self.groupType == YDGroupDetailTypeNotJoin){
                [oneBtn setTitle:@"申请加入" forState:0];
            }
            [_bottomView addSubview:oneBtn];
        }
        {
            UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(screen_width/2-0.5, 5, 1, 30)];
            spaceView.backgroundColor = [UIColor blackColor];
            [_bottomView addSubview:spaceView];
            UIButton *twoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            twoBtn.frame = CGRectMake(screen_width/2+1, 0, screen_width/2-0.5, 40);
            twoBtn.backgroundColor = [UIColor clearColor];
            [twoBtn setTitleColor:[UIColor blackColor] forState:0];
            [twoBtn setTitle:@"举报" forState:0];
            [twoBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_bottomView addSubview:twoBtn];
        }
    }
    return _bottomView;
}

- (NSMutableArray *)members{
    if (!_members) {
        _members = [NSMutableArray arrayWithCapacity:5];
        for (NSInteger i = 0; i<5; i++) {
            NSString *string = [NSString stringWithFormat:@"head%ld.jpg",i];
            [_members addObject:string];
        }
    }
    return _members;
}
- (void)bottomBtnAction:(UIButton *)sender{
    NSLog(@"title = %@",sender.titleLabel.text);
}
@end

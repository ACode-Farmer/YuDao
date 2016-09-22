//
//  GroupDetailController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "GroupDetailController.h"
#import "InterestView.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
#import "MCommonModel.h"
#import "MembersListController.h"
#import "ChangeImageController.h"
#import "AWActionSheet.h"

@interface GroupDetailController ()<UITableViewDataSource,UITableViewDelegate,AWActionSheetDelegate>

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) NSMutableArray *members;

@property (nonatomic, strong) InterestView *inView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GroupDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群组详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = [UIView new];
    [self updateHeaderView:self.headerView];
    
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction)];
        
        rightItem;
    });
    
    [self.view addSubview:self.bottomView];
    [self.view bringSubviewToFront:self.bottomView];
}

#pragma mark - AWActionSheetDelegate
- (void)rightBarButtonItemAction{
    AWActionSheet *sheet = [[AWActionSheet alloc] initWithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    [sheet show];
}

-(int)numberOfItemsInActionSheet
{
    return 4;
}

-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[AWActionSheetCell alloc] init];
    cell.iconView.image = [UIImage imageNamed:@"head0.jpg"];
    [[cell iconView] setBackgroundColor:
     [UIColor colorWithRed:rand()%255/255.0f
                     green:rand()%255/255.0f
                      blue:rand()%255/255.0f
                     alpha:1]];
    [[cell titleLabel] setText:[NSString stringWithFormat:@"item %d",(int)index]];
    cell.index = (int)index;
    return cell;
}

- (void)DidTapOnItemAtIndex:(NSInteger)index title:(NSString*)name
{
    NSLog(@"tap on %d",(int)index);
    //[TapToShowActionsheet setText:[NSString stringWithFormat:@"Selected Item %d",(int)index]];
}



#pragma mark - lazy load

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

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.frame = CGRectMake(0, 0, screen_width, 200);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_headerView addGestureRecognizer:tap];
        
        UIView *backView = [UIView new];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.4f;
        UIButton *imageBtn = [UIButton new];
        imageBtn.tag = 101;
        [imageBtn addTarget:self action:@selector(imageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label = [UILabel new];
        label.tag = 102;
        
        NSArray *views = @[backView,imageBtn,label];
        [_headerView sd_addSubviews:views];
        [self.view addSubview:_headerView];
        
        backView.sd_layout
        .leftSpaceToView(_headerView,0)
        .bottomSpaceToView(_headerView,0)
        .widthIs(screen_width)
        .heightIs(50);
        
        imageBtn.sd_layout
        .leftSpaceToView(_headerView,10)
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
    return _headerView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height-40, screen_width, 40)];
        _bottomView.backgroundColor = [UIColor blueColor];
        
        {
            UIButton *oneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            oneBtn.frame = CGRectMake(0, 0, screen_width/2-0.5, 40);
            oneBtn.backgroundColor = [UIColor clearColor];
            [oneBtn setTitleColor:[UIColor whiteColor] forState:0];
            [oneBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            if (self.type == ControllerTypeOld) {
                [oneBtn setTitle:@"发消息" forState:0];
            }else if (self.type == ControllerTypeNew){
                [oneBtn setTitle:@"申请加入" forState:0];
            }else{
                [oneBtn setTitle:@"解散" forState:0];
            }
            [_bottomView addSubview:oneBtn];
        }
        {
            UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(screen_width/2-0.5, 5, 1, 30)];
            spaceView.backgroundColor = [UIColor whiteColor];
            [_bottomView addSubview:spaceView];
            UIButton *twoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            twoBtn.frame = CGRectMake(screen_width/2+1, 0, screen_width/2-0.5, 40);
            twoBtn.backgroundColor = [UIColor clearColor];
            [twoBtn setTitleColor:[UIColor whiteColor] forState:0];
            [twoBtn setTitle:@"举报" forState:0];
            [twoBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_bottomView addSubview:twoBtn];
        }
    }
    return _bottomView;
}

- (void)bottomBtnAction:(UIButton *)sender{
    NSLog(@"title = %@",sender.titleLabel.text);
}

- (void)tapAction:(id)sender{
    [self imageBtnAction:nil];
}
- (void)imageBtnAction:(UIButton *)sender{
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
        [self.navigationController pushViewController:changeVC animated:YES];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:one];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)updateHeaderView:(UIView *)view{
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"test0.jpg"]];
    UIButton *imageBtn = [view viewWithTag:101];
    UILabel *label = [view viewWithTag:102];
    
    [imageBtn setImage:[UIImage imageNamed:@"test8.jpg"] forState:0];
    [imageBtn setImage:[UIImage imageNamed:@"test8.jpg"] forState:UIControlStateHighlighted];
    
    label.text = @"今晚猎个痛快";
    
}

#pragma tableview dataSource
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"GDCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"成员";
            cell.textLabel.textColor = [UIColor blueColor];
            cell.detailTextLabel.text = @"100人";
            cell.accessoryType = 1;
            break;}
        case 1:
        {
            [self memberAddView:cell.contentView from:self.members];
            break;}
        case 2:
        {
            cell.textLabel.text = @"所在位置";
            cell.textLabel.textColor = [UIColor blueColor];
            break;}
        case 3:
        {
            cell.textLabel.text = @"上海东方明珠塔";
            break;}
        case 4:
        {
            cell.textLabel.text = @"群组标签";
            cell.textLabel.textColor = [UIColor blueColor];
            break;}
        case 5:
        {
            if (!self.inView) {
                [self interestAddView:cell.contentView from:[NSMutableArray arrayWithObjects:@"旅行",@"美食",@"交友",@"同城聚会" ,nil]];
            }
            break;}
        default:
            break;
    }
    
    return cell;
}

/**
 *  成员视图
 *
 *  @param view    cell.contentView
 *  @param members 成员数组
 */
- (void )memberAddView:(UIView *)view from:(NSMutableArray *)members{
    NSMutableArray *subViews = [NSMutableArray arrayWithCapacity:5];
    UIView *lastView = nil;
    for (NSInteger i = 0; i < members.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:members[i]]];
        [view addSubview:imageView];
        [subViews addObject:imageView];
        if (i == 0) {
            imageView.sd_layout
            .leftSpaceToView(view,0)
            .topSpaceToView(view,2)
            .bottomSpaceToView(view,2);
        }else{
            lastView = subViews[i-1];
            imageView.sd_layout
            .leftSpaceToView(lastView,0)
            .topSpaceToView(view,2)
            .bottomSpaceToView(view,2);
        }
        
        imageView.sd_cornerRadius = @10;
        imageView.layer.borderWidth = 5;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        
    }
    [view setSd_equalWidthSubviews:subViews];
}

- (void)interestAddView:(UIView *)view from:(NSMutableArray *)interests{
    self.inView = [InterestView new];
    [view addSubview:self.inView];
    [self.inView addItemsToCell:interests];
    self.inView.sd_layout
    .topSpaceToView(view,0)
    .leftSpaceToView(view,0)
    .rightSpaceToView(view,0);
}

#pragma tablei view delegate
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return screen_width/5+1;
    }else{
        return 45.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        [self.navigationController pushViewController:[MembersListController new] animated:YES];
    }
    
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

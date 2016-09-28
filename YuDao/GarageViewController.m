//
//  GarageViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/28.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "GarageViewController.h"
#import "BrandViewController.h"

@interface GarageViewController ()

@property (nonatomic, strong) UIView *addCarView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GarageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的车库";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"notFirstAddCar"]) {
        
    }else{
        [self.view addSubview:self.addCarView];
    }
    
}

#pragma lazy load

- (UIView *)addCarView{
    if (!_addCarView) {
        _addCarView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, screen_width, 0.3*screen_height)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, screen_width, 21)];
        label.text = @"车库里面空空如也，快添加你的爱车吧!";
        label.textColor = [UIColor blackColor];
        [_addCarView addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(label.frame)+5, screen_width - 10, _addCarView.bounds.size.height - label.bounds.size.height-10)];
        imageView.layer.cornerRadius = 30;
        imageView.layer.borderWidth = 1.f;
        imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imageView.layer.masksToBounds = YES;
        imageView.image = [UIImage imageNamed:@"add"];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addViewAction:)];
        [imageView addGestureRecognizer:tap];
        [_addCarView addSubview:imageView];
    }
    return _addCarView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64) style:UITableViewStylePlain];
        
    }
    return _tableView;
}

#pragma mark actions - 
- (void)addViewAction:(UIGestureRecognizer *)tap{
    [self.navigationController pushViewController:[BrandViewController new] animated:YES];
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

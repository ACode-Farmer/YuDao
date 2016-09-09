//
//  SearchController.m
//  JiaPlus
//
//  Created by 汪杰 on 16/9/6.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "SearchController.h"

@interface SearchController ()
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourthBtn;

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidLayoutSubviews{
    NSArray *views = @[_firstBtn,_secondBtn,_thirdBtn,_fourthBtn];
    [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = (UIButton *)obj;
        button.layer.cornerRadius = button.bounds.size.height/2;
        button.layer.masksToBounds = YES;
    }];
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

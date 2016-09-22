//
//  CreateGroupController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/22.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "CreateGroupController.h"
#import "ChangeImageController.h"
#import "PlaceController.h"

@interface CreateGroupController ()
@property (weak, nonatomic) IBOutlet UIImageView *groupImage;
@property (weak, nonatomic) IBOutlet UITextField *groupNameTF;

@end

@implementation CreateGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建群组";
    UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)];
    [self.view addGestureRecognizer:viewTap];
    
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
    
    [self.groupImage addGestureRecognizer:imageTap];
    
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
        rightItem;
    });
    
}

#pragma mark - tap action
- (void)viewTapAction:(id)sender{
    [self.groupNameTF resignFirstResponder];
}

- (void)imageTapAction:(id)sender{
    ChangeImageController *changeVC = [ChangeImageController new];
    changeVC.optionalTitle = @"更换头像";
    
    [self.navigationController pushViewController:changeVC animated:YES];
}

- (void)rightItemAction{
    
    [self.navigationController pushViewController:[PlaceController  new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)explainBtn:(id)sender {
    
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

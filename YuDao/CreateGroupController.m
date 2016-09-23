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

@interface CreateGroupController ()<UITextFieldDelegate>
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardDidShow:(NSNotification *)noti{
    CGFloat margin = 0;
    CGRect keyboardRect = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    double duration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if ((keyboardRect.size.height + CGRectGetMaxY(self.groupNameTF.frame)) > screen_height) {
        margin = CGRectGetMaxY(self.groupNameTF.frame) - (screen_height - keyboardRect.size.height);
    }
    CGRect frame = self.view.frame;
    frame.origin.y -= margin;
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = frame;
    }];
}

- (void)keyboardDidHidden:(NSNotification *)noti{
    CGRect frame = self.view.frame;
    if (frame.origin.y < 0) {
        frame.origin.y = 0;
        double duration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = frame;
        }];
    }
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

#pragma mark - textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.groupNameTF resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)explainBtn:(id)sender {
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

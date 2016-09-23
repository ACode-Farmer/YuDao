//
//  RealOrNickNameController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "RealOrNickNameController.h"

@interface RealOrNickNameController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textF;
@property (nonatomic, strong) UILabel *label;

@end

@implementation RealOrNickNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.textF.sd_layout
    .topSpaceToView(self.view,74)
    .leftSpaceToView(self.view,5)
    .rightSpaceToView(self.view,5)
    .heightIs(40);
    
    if (self.isReal) {
        self.title = @"真实姓名";
        [self.view addSubview:self.label];
        self.label.sd_layout
        .leftEqualToView(self.textF)
        .rightEqualToView(self.textF)
        .topSpaceToView(self.textF,5)
        .heightIs(21);
    }
    else{
        self.title = @"昵称";
    }
    self.textF.text = [defaults stringForKey:self.title];
    
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textF becomeFirstResponder];
}


- (void)rightItemAction:(id)sender{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.textF.text forKey:self.title];
    [defaults synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITextField *)textF{
    if (!_textF) {
        _textF = [UITextField new];
        _textF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textF.layer.borderWidth = 1.0f;
        _textF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textF.layer.cornerRadius = 5.0f;
        _textF.layer.masksToBounds = YES;
        _textF.delegate = self;
        [self.view addSubview:_textF];
    }
    return _textF;
}

- (UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.text = @"*真实姓名不显示在个人资料中，请放心填写";
    }
    return _label;
}

#pragma textField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (string.length > 0) {
        string = [textField.text stringByAppendingString:string];
    }else{
        string = [textField.text substringWithRange:NSMakeRange(0, textField.text.length-1)];
    }
    NSLog(@"string - %@",string);
    if (![string isEqualToString:@"此处后期使用单例"]) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }else{
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    return YES;
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
